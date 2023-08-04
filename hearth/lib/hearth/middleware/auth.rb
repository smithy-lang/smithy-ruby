# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that resolves identities for signing requests.
    # @api private
    class Auth
      # @param [Class] app The next middleware in the stack.
      def initialize(app, auth_scheme_resolver:, **kwargs)
        @app = app
        @auth_scheme_resolver = auth_scheme_resolver

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
        @app.call(input, context)
      end
    end
  end
end
