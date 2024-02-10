# frozen_string_literal: true

# in Hearth middleware
module Hearth
  module Middleware
    # Resolves endpoints from endpoint parameters and modify
    # the request with resolved endpoint, headers and auth schemes.
    class Endpoint
      def initialize(
        app, endpoint_provider:, param_builder:, config:
      )
        @app = app
        @param_builder = param_builder
        @endpoint_provider = endpoint_provider
        @config = config
      end

      def call(input, context)
        params = @param_builder.build(@config, context)
        endpoint = @endpoint_provider.resolve_endpoint(params)
        # TODO: update uri, keeping path/query parameters from build
        context.request.uri = endpoint.uri
        endpoint.headers.each do |key, val|
          context.request.headers[key] = val
        end

        # TODO: combine with auth middleware
        context[:auth_schemes] = endpoint.auth_schemes

        @app.call(input, context)
      end
    end
  end
end
