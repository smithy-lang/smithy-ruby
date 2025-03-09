# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # Default stubber when stubbing is configured.
      # @api private
      module Stubber
        def self.stub_data(_operation, data)
          resp = HTTP::Response.new
          resp.status_code = 200
          resp.body = StringIO.new(data)
          resp
        end

        def self.stub_error(error_code)
          resp = HTTP::Response.new
          resp.status_code = 500
          resp.body = StringIO.new(error_code)
          resp
        end
      end
    end
  end
end
