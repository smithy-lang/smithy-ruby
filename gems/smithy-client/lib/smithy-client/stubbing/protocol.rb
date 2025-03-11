# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # Default protocol when stubbing is configured.
      # @api private
      class Protocol
        def build_request(_context); end
        def parse_data(_context); end
        def parse_error(_context); end

        def stub_data(_service, _operation, _data)
          resp = HTTP::Response.new
          resp.status_code = 200
          resp.headers['Stubbed-Header'] = 'stubbed-header-value'
          resp.body = StringIO.new('stubbed-data')
          resp
        end

        def stub_error(_error_code)
          resp = HTTP::Response.new
          resp.status_code = 500
          resp.headers['Stubbed-Header'] = 'stubbed-header-value'
          resp.body = StringIO.new('stubbed-error-body')
          resp
        end
      end
    end
  end
end
