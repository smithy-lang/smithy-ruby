# frozen_string_literal: true

module Smithy
  module Client
    module Stubbing
      # Default endpoint provider when stubbing is configured.
      # @api private
      class EndpointProvider
        def resolve(parameters)
          uri =
            if EndpointRules.set?(parameters.endpoint)
              parameters.endpoint
            else
              'http://stubbed-endpoint'
            end

          EndpointRules::Endpoint.new(uri: uri)
        end
      end
    end
  end
end
