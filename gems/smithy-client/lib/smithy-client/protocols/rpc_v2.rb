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

        # @param options [Hash] Protocol options
        # @option options [Boolean] :query_compatible (nil)
        def initialize(options = {})
          @query_compatible = options[:query_compatible]
        end

        def build(context)
          codec = Codecs::CBOR.new(setting(context))
          context.request.body = codec.serialize(context.params, context.operation.input)
          context.request.http_method = 'POST'
          apply_headers(context)
          build_url(context)
        end

        def parse(context)
          output_shape = context.operation.output
          codec = Codecs::CBOR.new(setting(context))
          codec.deserialize(context.response.body.read, output_shape)
        end

        def error(context)
          code, message, data = extract_error(context)
          return unless code

          errors_module = context.client.class.errors_module
          errors_module.error_class(code).new(context, message, data)
        end

        def stub_data(operation, data)
          resp = HTTP::Response.new
          resp.status_code = 200
          resp.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          resp.headers['Content-Type'] = 'application/cbor'
          codec = Codecs::CBOR.new # (setting(context))
          resp.body = codec.serialize(data, operation.output)
          resp
        end

        def stub_error(operation, error_code)
          resp = HTTP::Response.new
          resp.status_code = 400
          resp.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          resp.headers['Content-Type'] = 'application/cbor'
          type = operation.errors.find { |e| e.type.name.include?("Types::#{error_code}") }
          resp.body = CBOR.encode({ '__type' => type.id, 'message' => 'stubbed-error-message' })
          resp
        end

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
          if (error_rules = context.operation.errors)
            error_rules.each do |rule|
              # match modeled shape name with the type(code) only
              # some type(code) might contains invalid characters
              # such as ':' (efs) etc
              match = rule.id.split('#').last == code.gsub(/[^^a-zA-Z0-9]/, '')
              next unless match && rule.members.any?

              codec = Codecs::CBOR.new(setting(context))
              data = codec.deserialize(body, rule, rule.type.new)
            end
          end
          data
        end

        def apply_headers(context)
          context.request.headers['X-Amzn-Query-Mode'] = 'true' if query_compatible?(context)
          context.request.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
          apple_content_type(context)
          apply_accept_header(context)
          # TODO: Implement Content-Length Plugin/Handler
          context.request.headers['Content-Length'] = context.request.body.size
        end

        def apply_accept_header(context)
          # TODO: Needs an update when streaming is handled
          context.request.headers['Accept'] = 'application/cbor'
        end

        def apple_content_type(context)
          return if context.operation.input == Schema::Shapes::Prelude::Unit

          # TODO: Needs an update when streaming is handled
          context.request.headers['Content-Type'] = 'application/cbor'
        end

        def build_url(context)
          base = context.request.endpoint
          base.path +=
            "/service/#{context.config.service.name}/operation/#{context.operation.name}"
        end

        def setting(context)
          {}.tap do |h|
            h[:query_compatible] = true if query_compatible?(context)
          end
        end

        def query_compatible?(context)
          @query_compatible ||
            context.config.service.traits.one? { |k, _v| k == 'aws.protocols#awsQuery' }
        end
      end
    end
  end
end
