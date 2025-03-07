# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # Default endpoint provider when stubbing is configured.
      # @api private
      class EndpointProvider
        def resolve_endpoint(_parameters)
          Smithy::Client::EndpointRules::Endpoint.new(uri: 'http://stubbed-endpoint')
        end
      end
    end
  end
end
