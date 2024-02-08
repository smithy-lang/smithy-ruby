# frozen_string_literal: true

# in Hearth middleware
module Hearth
  module Middleware
    # Resolves endpoints from endpoint parameters and modify
    # the request with resolved endpoint, headers and auth schemes.
    class Endpoint
      def initialize(
        app, endpoint_provider:, param_builder_class:
      )
        @app = app
        @param_builder_class = param_builder_class
        @endpoint_provider = endpoint_provider
      end

      def call(input, context)
        params = @param_builder_class.build(context)
        endpoint = @endpoint_provider.resolve_endpoint(params)
        # change URL
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
