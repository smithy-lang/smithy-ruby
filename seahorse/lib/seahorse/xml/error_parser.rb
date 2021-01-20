# frozen_string_literal: true

require 'json'

module Seahorse
  module XML
    class ErrorParser
      # @api private
      HTTP_3XX = 300..399

      # @api private
      HTTP_4XX = 400..499

      # @api private
      HTTP_5XX = 500..599

      # @api private
      ERROR_STATUS_CODES = (300..599)

      def initialize(errors_module:)
        @errors_module = errors_module
      end

      def parse(http_resp:)
        if ERROR_STATUS_CODES.include?(http_resp.status_code)
          extract_error(http_resp)
        end
      end

      private

      def extract_error(http_resp)
        body = http_resp.body.read
        if body.empty?
          error_code = nil
          error_message = ''
        else
          body_xml = Seahorse::XML.parse(body)
          error_code = error_code(body_xml)
          error_message = error_message(body_xml)
          http_resp.body.rewind
        end
        build_error(
          error_code: error_code,
          error_message: error_message,
          http_status_code: http_resp.status_code,
          http_headers: http_resp.headers,
          http_body: body,
          request_id: http_resp.headers['X-Amzn-Requestid']
        )
      end

      def error_message(body_xml)
        body_xml['message'] || body_xml['Message']
      end

      def error_code(body_xml)
        code = body_xml['code']
        code = body_xml['Code'] if code.nil? || code.empty?
        code.first.text
      end

      def build_error(error_opts)
        # error_class = @errors_module::ERROR_CODES[error_opts[:error_code]]
        error_class = Object.const_get("#{@errors_module}::#{error_opts[:error_code]}")
        return error_class.new(error_opts) if error_class

        case error_opts.fetch(:http_status_code)
        when HTTP_3XX
          error_opts[:location] = error_opts[:http_headers]['Location']
          @errors_module::ApiRedirectError.new(error_opts)
        when HTTP_4XX then @errors_module::ApiClientError.new(error_opts)
        when HTTP_5XX then @errors_module::ApiServerError.new(error_opts)
        end
      end
    end
  end
end
