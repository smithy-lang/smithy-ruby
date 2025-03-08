# frozen_string_literal: true

module Smithy
  module Client
    module RPCv2CBOR
      # @api private
      class ParseHandler < Handler
        def call(context)
          output = @handler.call(context)
          output.error = parse_error(context) unless output.error
          output.data = parse_response(context) unless output.error
          output
        end

        private

        def parse_error(context)
          if !valid_response?(context)
            code, message, data = http_status_error(context)
            build_error(context, code, message, data)
          elsif (300..599).cover?(context.response.status_code)
            error(context)
          end
        end

        def valid_response?(context)
          req_header = context.request.headers['smithy-protocol']
          resp_header = context.request.headers['smithy-protocol']
          req_header == resp_header
        end

        def error(context)
          body = context.response.body.read
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
          context.operation.errors.each do |error|
            next unless error.id == code

            data = CBOR::Codec.deserialize(error, body, error.type.new)
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
          status_code = context.response.status_code
          "HTTP#{status_code}Error"
        end

        def parse_response(context)
          CBOR::Codec.deserialize(context.operation.output, context.response.body.read)
        end
      end
    end
  end
end
