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

          instance_variable_set("@#{key}", value)
          @identity_resolvers[identity_type_for(key)] = value
        end
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        auth_options = @auth_resolver.resolve(@auth_params)
        context.auth_scheme = select_auth_scheme(auth_options)
        @app.call(input, context)
      end

      private

      SelectedAuthScheme = Struct.new(:identity, :signer, :auth_option)

      def identity_type_for(config_key)
        case config_key
        when :http_api_key_identity_resolver
          Identities::HTTPApiKey
        when :http_basic_identity_resolver, :http_digest_identity_resolver
          Identities::HTTPLogin
        when :http_bearer_identity_resolver
          Identities::HTTPBearer
        else
          raise "Unknown identity type for #{config_key}"
        end
      end

      def select_auth_scheme(auth_options)
        auth_options.each do |auth_option|
          if auth_option.scheme_id == 'smithy.api#noAuth'
            return SelectedAuthScheme.new(nil, nil, auth_option)
          end

          auth_scheme = @auth_schemes[auth_option.scheme_id]
          selected_auth_scheme = try_load_auth_scheme(auth_option, auth_scheme)

          return selected_auth_scheme if selected_auth_scheme
        end

        raise "No auth scheme found for #{auth_options}"
      end

      def try_load_auth_scheme(auth_option, auth_scheme)
        scheme_id = auth_option.scheme_id
        unless auth_scheme
          raise "Auth scheme #{scheme_id} was not enabled for this request"
        end

        identity_resolver = auth_scheme.identity_resolver(@identity_resolvers)
        unless identity_resolver
          raise "Auth scheme #{scheme_id} did not have an " \
                'identity resolver configured'
        end

        identity_properties = auth_option.identity_properties
        identity = identity_resolver.identity(identity_properties)

        SelectedAuthScheme.new(identity, auth_scheme.signer, auth_option)
      end
    end
  end
end
