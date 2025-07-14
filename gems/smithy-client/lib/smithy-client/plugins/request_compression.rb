# frozen_string_literal: true

require 'zlib'

module Smithy
  module Client
    module Plugins
      # @api private
      class RequestCompression < Plugin
        DEFAULT_MIN_COMPRESSION_SIZE = 10_240
        MIN_COMPRESSION_SIZE_LIMIT = 10_485_760
        SUPPORTED_ENCODINGS = %w[gzip].freeze
        CHUNK_SIZE = 1 * 1024 * 1024 # one MB

        option(
          :disable_request_compression,
          default: false,
          doc_type: 'Boolean',
          docstring: 'When `true`, the request body will not be compressed for supported operations.'
        ) do |_config|
          value = ENV['DISABLE_REQUEST_COMPRESSION'] || 'false'
          Util.str_to_bool(value)
        end

        option(
          :request_min_compression_size_bytes,
          default: DEFAULT_MIN_COMPRESSION_SIZE,
          doc_type: Integer,
          docstring: <<~DOCS) do |_config|
            The minimum size in bytes that triggers compression for request bodies.
            The value must be non-negative integer value between 0 and 10,485,780 bytes inclusive.
          DOCS
          value = ENV['REQUEST_MIN_COMPRESSION_SIZE_BYTES'] || DEFAULT_MIN_COMPRESSION_SIZE
          Integer(value)
        end

        def after_initialize(client)
          validate_disable_request_compression(client.config)
          validate_request_min_compression_size_bytes(client.config)
        end

        def validate_disable_request_compression(config)
          return if [true, false].include?(config.disable_request_compression)

          raise ArgumentError,
                ':disable_request_compression must be either `true` or `false`'
        end

        def validate_request_min_compression_size_bytes(config)
          begin
            value = Integer(config.request_min_compression_size_bytes)
            return if value.between?(0, MIN_COMPRESSION_SIZE_LIMIT)
          rescue ArgumentError
            # handled below
          end

          raise ArgumentError,
                ':request_min_compression_size_bytes must be a non-negative integer ' \
                'value between `0` and `10,485,760` bytes inclusive'
        end

        def add_handlers(handlers, config)
          # Ensure compression is performed BEFORE calculating a checksum
          handlers.add(Handler, priority: 25) unless config.disable_request_compression
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            if request_compression_trait?(context)
              selected_encoding = request_encoding_selection(context)
              if selected_encoding
                if streaming?(context.operation.input)
                  process_streaming_compression(selected_encoding, context)
                elsif context.http_request.body.size >= context.config.request_min_compression_size_bytes
                  process_compression(selected_encoding, context)
                end
              end
            end
            if selected_encoding == 'gzip'
              context[:user_agent_feature_ids] ||= []
              context[:user_agent_feature_ids] << 'GZIP_REQUEST_COMPRESSION'
              response = @handler.call(context)
              context[:user_agent_feature_ids].delete('GZIP_REQUEST_COMPRESSION')
              response
            else
              @handler.call(context)
            end
          end

          private

          def request_compression_trait?(context)
            context.operation.traits.key?('smithy.api#requestCompression')
          end

          def request_encoding_selection(context)
            encodings = context.operation.traits['smithy.api#requestCompression']['encodings']
            encodings.find { |encoding| RequestCompression::SUPPORTED_ENCODINGS.include?(encoding) }
          end

          def streaming?(input)
            input.shape.members.any? do |_, member_ref|
              member_ref.shape.traits.key?('smithy.api#streaming') &&
                !member_ref.shape.traits.key?('smithy.api#requiresLength')
            end
          end

          def process_streaming_compression(encoding, context)
            case encoding
            when 'gzip'
              context.http_request.body = GzipIO.new(context.http_request.body)
            else
              raise StandardError, "Encoding #{encoding} is not supported"
            end
            update_content_encoding(encoding, context)
          end

          def process_compression(encoding, context)
            case encoding
            when 'gzip'
              gzip_compress(context)
            else
              raise StandardError, "We currently do not support #{encoding} encoding"
            end
            update_content_encoding(encoding, context)
          end

          def gzip_compress(context) # rubocop:disable Metrics/AbcSize
            compressed = StringIO.new
            compressed.binmode
            gzip_writer = Zlib::GzipWriter.new(compressed)
            if context.http_request.body.respond_to?(:read)
              update_in_chunks(gzip_writer, context.http_request.body)
            else
              gzip_writer.write(context.http_request.body)
            end
            gzip_writer.close
            context.http_request.body = StringIO.new(compressed.string)
          end

          def update_in_chunks(compressor, io)
            loop do
              chunk = io.read(CHUNK_SIZE)
              break unless chunk

              compressor.write(chunk)
            end
          end

          def update_content_encoding(encoding, context)
            headers = context.http_request.headers
            if headers['Content-Encoding']
              headers['Content-Encoding'] += ", #{encoding}"
            else
              headers['Content-Encoding'] = encoding
            end
          end

          def with_metric(encoding, &block)
            metric = encoding == 'gzip' ? 'L' : nil
            return block.call unless metric

            Thread.current[:smithy_ruby_user_agent_metric] ||= []
            Thread.current[:smithy_ruby_user_agent_metric] << metric
            block.call
          ensure
            Thread.current[:smithy_ruby_user_agent_metric].pop
          end

          # @api private
          class GzipIO
            def initialize(body)
              @body = body
              @buffer = ChunkBuffer.new
              @gzip_writer = Zlib::GzipWriter.new(@buffer)
            end

            def read(length, buff = nil)
              if @gzip_writer.closed?
                # an empty string to signify an end as
                # there will be nothing remaining to be read
                StringIO.new('').read(length, buff)
                return
              end

              chunk = @body.read(length)
              if !chunk || chunk.empty?
                # closing the writer will write one last chunk
                # with a trailer (to be read from the @buffer)
                @gzip_writer.close
              else
                # flush happens first to ensure that header fields
                # are being sent over since write will override
                @gzip_writer.flush
                @gzip_writer.write(chunk)
              end

              StringIO.new(@buffer.last_chunk).read(length, buff)
            end
          end

          # @api private
          class ChunkBuffer
            def initialize
              @last_chunk = nil
            end

            attr_reader :last_chunk

            def write(data)
              @last_chunk = data
            end
          end
        end
      end
    end
  end
end
