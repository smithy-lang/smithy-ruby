# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # Default stubber when stubbing is configured.
      # @api private
      module Stubber
        def self.stub_data(_operation, _data)
          resp = HTTP::Response.new
          resp.status_code = 200
          resp.headers['Stubbed-Header'] = 'stubbed-header-value'
          resp.body = StringIO.new('stubbed-data')
          resp
        end

        def self.stub_error(_error_code)
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
