# frozen_string_literal: true

require 'openssl'

module Smithy
  module Client
    module Plugins
      # @api private
      class ChecksumRequired < Plugin
        def add_handlers(handlers, _config)
          # Ensure checksum is computed AFTER the request is built but BEFORE it is signed
          handlers.add(Handler, priority: 15)
        end

        # @api private
        class Handler < Client::Handler
          CHUNK_SIZE = 1 * 1024 * 1024 # one MB

          def call(context)
            if checksum_required_operation?(context)
              context.http_request.headers['Content-Md5'] ||= md5(context.http_request.body)
            end
            @handler.call(context)
          end

          private

          def checksum_required_operation?(context)
            Smithy::Schema::Extension.checksum_required?(context.operation)
          end

          def md5(value)
            md5 = OpenSSL::Digest.new('MD5')
            update_in_chunks(md5, value)
            md5.base64digest
          end

          def update_in_chunks(digest, io)
            loop do
              chunk = io.read(CHUNK_SIZE)
              break unless chunk

              digest.update(chunk)
            end
            io.rewind
          end
        end
      end
    end
  end
end
