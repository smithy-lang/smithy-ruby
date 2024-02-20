# frozen_string_literal: true

# in Hearth middleware
module Hearth
  module Middleware
    # Resolves endpoints from endpoint parameters and modifies
    # the request with resolved endpoint, headers and auth schemes.
    # @api private
    class Endpoint
      # @param [Class] app The next middleware in the stack.
      # @param [#resolve_endpoint(endpoint_params)] endpoint_provider An object
      #   that responds to a `resolve_endpoint(endpoint_params)` method
      #   where `endpoint_params` is a service specific struct.
      #   The method must return an {Hearth::Endpoints::Endpoint} object.
      # @param [#build(config, input, context)] param_builder An object that
      #   responds to a `build(config, input, context)` method and returns
      #   an endpoint_params object.
      def initialize(
        app, endpoint_provider:, param_builder:, **kwargs
      )
        @app = app
        @param_builder = param_builder
        @endpoint_provider = endpoint_provider
        @config = kwargs
      end

      def call(input, context)
        params = @param_builder.build(@config, input, context)
        endpoint = @endpoint_provider.resolve_endpoint(params)
        update_request(context, endpoint)
        update_auth_properties(context, endpoint.auth_schemes)

        @app.call(input, context)
      end

      private

      # apply the resolved endpoint to the request
      def update_request(context, endpoint)
        context.request.uri = merge_endpoints(
          URI(endpoint.uri), context.request.uri
        )
        endpoint.headers.each do |key, val|
          context.request.headers[key] = val
        end
      end

      # merge the path and query parameters from serialization
      # URIs from endpoint resolution MUST contain port and hostname
      # and MAY contain port and base path.
      def merge_endpoints(resolved_uri, request_uri)
        merged = URI(resolved_uri)
        merged.path = resolved_uri.path + request_uri.path
        merged.query = request_uri.query
        merged
      end

      # merge properties from the endpoint resolved auth schemes onto
      # the auth scheme resolved by the auth resolver.
      def update_auth_properties(context, auth_schemes)
        context[:endpoint_auth_schemes] = auth_schemes
        # TODO: merge properties to context.auth
        # Need to match auth_scheme.name to the schemeId
      end
    end
  end
end
