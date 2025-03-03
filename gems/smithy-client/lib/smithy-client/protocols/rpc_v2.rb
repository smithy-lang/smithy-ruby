# frozen_string_literal: true

module Smithy
  module Client
    module Protocols
      # A RPC-based protocol over HTTP that sends requests
      # and responses with CBOR payloads.
      #
      # TODO: Refactor methods to handle eventstreams
      class RPCv2
        # @api private
        SHAPE_ID = 'smithy.protocols#rpcv2Cbor'

        # @param options [Hash]
        def initialize(options = {})
          @codec = Codecs::CBOR.new(options)
        end

        def build(context)
          apply_headers(context)
          context.request.http_method = 'POST'
          context.request.body = @codec.serialize(context.operation.input, context.params)
          build_url(context)
        end

        def parse(context)
          output_shape = context.operation.output
          @codec.deserialize(output_shape, context.response.body.read)
        end

        def error(context)
          code, message, data = extract_error(context)
          return unless code

          errors_module = context.client.class.errors_module
          errors_module.error_class(code).new(context, message, data)
        end

        # def stub_data(operation, data)
        #   resp = HTTP::Response.new
        #   resp.status_code = 200
        #   resp.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        #   resp.headers['Content-Type'] = 'application/cbor'
        #   resp.body = @codec.serialize(operation.output, data)
        #   resp
        # end

        # def stub_error(operation, error_code)
        #   resp = HTTP::Response.new
        #   resp.status_code = 400
        #   resp.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        #   resp.headers['Content-Type'] = 'application/cbor'
        #   type = operation.errors.find { |e| e.type.name.include?("Types::#{error_code}") }
        #   shape = operation.errors.find { |e| e.id == type.id }
        #   data = { '__type' => type.id, 'message' => 'stubbed-error-message' }
        #   resp.body = @codec.serialize(shape, data)
        #   resp
        # end

        private

        def extract_error(context)
          body = context.response.body.read
          data = CBOR.decode(body)
          context.response.body.rewind
          return unless data && data['__type']

          code = data.delete('__type').split('#').last
          message = data['message']
          data = parse_error_data(context, body, code)
          [code, message, data]
        end

        def parse_error_data(context, body, code)
          data = Schema::EmptyStructure.new
          if (error_shapes = context.operation.errors)
            error_shapes.each do |rule|
              # match modeled shape name with the type(code) only
              # some type(code) might contains invalid characters
              # such as ':' (efs) etc
              match = rule.id.split('#').last == code.gsub(/[^^a-zA-Z0-9]/, '')
              next unless match && rule.members.any?

              data = @codec.deserialize(rule, body, rule.type.new)
            end
          end
          data
        end

        def apply_headers(context)
          context.request.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          apply_content_type(context)
          apply_accept_header(context)
          # TODO: Implement Content-Length Plugin/Handler
          context.request.headers['Content-Length'] = context.request.body.size
        end

        def apply_accept_header(context)
          # TODO: Needs an update when streaming is handled
          context.request.headers['Accept'] = 'application/cbor'
        end

        def apply_content_type(context)
          return if context.operation.input == Schema::Shapes::Prelude::Unit

          # TODO: Needs an update when streaming is handled
          context.request.headers['Content-Type'] = 'application/cbor'
        end

        def build_url(context)
          base = context.request.endpoint
          service_name = context.config.service.name
          base.path += "/service/#{service_name}/operation/#{context.operation.name}"
        end
      end
    end
  end
end
