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
          resp = HTTP::Response.new
          resp.status_code = 200
          resp.body = StringIO.new(data.to_json)
          resp
        end

        def stub_error(error_code)
          resp = HTTP::Response.new
          resp.status_code = 500
          resp.body = StringIO.new(error_code.to_json)
          resp
        end
      end
    end
  end
end
