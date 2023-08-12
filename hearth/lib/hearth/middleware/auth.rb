# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that resolves identities for signing requests.
    # @api private
    class Auth
      # @param [Class] app The next middleware in the stack.
      def initialize(app, auth_resolver:, auth_params:, **kwargs)
        @app = app
        @auth_resolver = auth_resolver
        @auth_params = auth_params

        # Identity resolvers
        kwargs.each do |key, value|
          next unless key.end_with?('_identity_resolver')

          instance_variable_set("@#{key}", value)
        end
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        auth_options = @auth_resolver.resolve(@auth_params)
        auth_scheme = select_auth_scheme(auth_options)
        @app.call(input, context)
      end

      private

      def select_auth_scheme(auth_options)

      end
    end
  end
end
