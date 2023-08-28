# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that resolves identities for signing requests.
    # @api private
    class Auth
      # @param [Class] app The next middleware in the stack.
      def initialize(app, auth_resolver:, auth_params:,
                     auth_schemes:, **kwargs)
        @app = app
        @auth_resolver = auth_resolver
        @auth_params = auth_params
        @auth_schemes = auth_schemes.to_h { |s| [s.scheme_id, s] }

        @identity_resolvers = {}
        kwargs.each do |key, value|
          next unless key.end_with?('_identity_resolver')

          @identity_resolvers[identity_type_for(key)] = value
        end
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        auth_options = @auth_resolver.resolve(@auth_params)
        context.auth = resolve_auth(auth_options)
        @app.call(input, context)
      end

      private

      ResolvedAuth = Struct.new(
        :signer,
        :signer_properties,
        :identity,
        :identity_properties,
        keyword_init: true
      )

      def identity_type_for(config_key)
        case config_key
        when :http_api_key_identity_resolver
          Identities::HTTPApiKey
        when :http_login_identity_resolver
          Identities::HTTPLogin
        when :http_bearer_identity_resolver
          Identities::HTTPBearer
        else
          raise "Unknown identity type for #{config_key}"
        end
      end

      def resolve_auth(auth_options)
        failures = []

        auth_options.each do |auth_option|
          auth_scheme = @auth_schemes[auth_option.scheme_id]
          resolved_auth = try_load_auth_scheme(
            auth_option,
            auth_scheme,
            failures
          )

          return resolved_auth if resolved_auth
        end

        raise failures.join("\n")
      end

      def try_load_auth_scheme(auth_option, auth_scheme, failures)
        scheme_id = auth_option.scheme_id
        unless auth_scheme
          failures << "Auth scheme #{scheme_id} was not enabled " \
                      'for this request'
          return
        end

        identity_resolver = auth_scheme.identity_resolver(@identity_resolvers)
        unless identity_resolver
          failures << "Auth scheme #{scheme_id} did not have an " \
                      'identity resolver configured'
          return
        end

        identity_properties = auth_option.identity_properties
        identity = identity_resolver.identity(identity_properties)

        ResolvedAuth.new(
          identity: identity,
          identity_properties: auth_option.identity_properties,
          signer: auth_scheme.signer,
          signer_properties: auth_option.signer_properties
        )
      end
    end
  end
end
