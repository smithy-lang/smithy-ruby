# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # Default protocol when stubbing is configured.
      # @api private
      class Protocol
        def build_request(_context); end
        def parse_data(_output); end
        def parse_error(_output); end

        def stub_data(_service, _operation, data)
          response = HTTP::Response.new
          response.status_code = 200
          response.body = StringIO.new(data.to_json)
          response
        end

        def stub_error(_service, error_code)
          response = HTTP::Response.new
          response.status_code = 500
          response.body = StringIO.new(error_code.to_json)
          response
        end
      end
    end
  end
end
