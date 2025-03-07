# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # Default stubber when stubbing is configured.
      # @api private
      module Stubber
        def self.stub_data(_operation, _data)
          HTTP::Response.new
        end

        def self.stub_error(_error_code)
          HTTP::Response.new
        end
      end
    end
  end
end
