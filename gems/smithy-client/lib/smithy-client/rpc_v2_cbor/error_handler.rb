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
              code, data = http_status_error(context)
              response.error = build_error(context, code, data)
            elsif (400..599).cover?(context.http_response.status_code)
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

        def error(context)
          body = context.http_response.body.read
          if body.empty?
            code, data = http_status_error(context)
          else
            code, data = extract_error(body, context)
          end
          build_error(context, code, data)
        end

        def extract_error(body, context)
          data = Cbor.decode(body)
          code = error_code(context, data)
          data = parse_error_data(context, body, code)
          [code, data]
        rescue Cbor::Error
          [http_status_error_code(context), Schema::EmptyStructure.new]
        end

        def parse_error_data(context, body, code)
          data = Schema::EmptyStructure.new
          context.operation.errors.each do |ref|
            next unless ref.shape.name == code

            data = Cbor::Parser.new.parse(ref, body, ref.shape.type.new)
          end
          data
        end

        def error_code(context, data)
          code = data['__type']
          code ||= http_status_error_code(context)
          code.split('#').last.split('$').first
        end

        def build_error(context, code, data)
          errors_module = context.client.class.errors_module
          errors_module.error_class(code).new(context, data)
        end

        def http_status_error(context)
          [http_status_error_code(context), Schema::EmptyStructure.new]
        end

        def http_status_error_code(context)
          "HTTP#{context.http_response.status_code}Error"
        end
      end
    end
  end
end
