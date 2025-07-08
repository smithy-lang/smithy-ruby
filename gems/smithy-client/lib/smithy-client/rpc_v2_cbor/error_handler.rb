# frozen_string_literal: true

module Smithy
  module Client
    module RpcV2Cbor
      # @api private
      class ErrorHandler < Client::Handler
        def call(context)
          # Malformed responses should throw an http based error, so we check
          # 200 range for error handling only for this case.
          @handler.call(context).on_done(200..599) do |response|
            if !valid_response?(context)
              code, message, data = http_status_error(context)
              response.error = build_error(context, code, message, data)
            elsif (300..599).cover?(context.http_response.status_code)
              response.error = error(context)
            end
          end
        end

        private

        def valid_response?(context)
          req_header = context.http_request.headers['smithy-protocol']
          resp_header = context.http_response.headers['smithy-protocol']
          req_header == resp_header
        end

        # TODO: Fix this
        # This is not correct per protocol tests. Some headers will determine the error code.
        # If the body is empty, there is still potentially an error code from the header, but
        # we are making a generic http status error instead. In a new major version, we should
        # always try to extract header, and during extraction, check headers and body.
        def error(context)
          body = context.http_response.body.read
          if body.empty?
            code, message, data = http_status_error(context)
          else
            code, message, data = extract_error(body, context)
          end
          build_error(context, code, message, data)
        end

        def extract_error(body, context)
          data = CBOR.decode(body)
          type = data['__type']
          code = error_code(type, context)
          message = data['message']
          data = parse_error_data(context, body, type)
          [code, message, data]
        rescue CBOR::Error
          [http_status_error_code(context), '', Schema::EmptyStructure.new]
        end

        def parse_error_data(context, body, code)
          data = Schema::EmptyStructure.new
          context.operation.errors.each do |ref|
            next unless ref.shape.id == code

            data = context.config.cbor_codec.deserialize(ref, body, ref.shape.type.new)
          end
          data
        end

        def error_code(type, context)
          return type.split('#').last if type

          http_status_error_code(context)
        end

        def build_error(context, code, message, data)
          errors_module = context.client.class.errors_module
          errors_module.error_class(code).new(context, message, data)
        end

        def http_status_error(context)
          [http_status_error_code(context), '', Schema::EmptyStructure.new]
        end

        def http_status_error_code(context)
          status_code = context.http_response.status_code
          "HTTP#{status_code}Error"
        end
      end
    end
  end
end
