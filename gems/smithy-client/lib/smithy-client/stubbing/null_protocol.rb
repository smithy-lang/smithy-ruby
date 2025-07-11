# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # @api private
      class NullProtocol
        def stub_data(_config, _operation, _data)
          HTTP::Response.new
        end

        def stub_error(_config, _error_code)
          HTTP::Response.new
        end
      end
    end
  end
end
