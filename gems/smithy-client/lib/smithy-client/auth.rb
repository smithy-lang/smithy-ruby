# frozen_string_literal: true

module Smithy
  module Client
    # The result of resolving the authentication scheme for a request.
    ResolvedAuth = Struct.new(:scheme_id, :signer, :signer_properties, :identity_provider, keyword_init: true)

    # @api private
    module Auth
      class << self
        def resolve(context, endpoint_properties = {})
          if endpoint_properties.key?('authSchemes')
            resolve_with_endpoint_auth(context.config, endpoint_properties['authSchemes'])
          else
            auth_parameters = context.client.class.auth_parameters.create(context)
            resolve_without_endpoint_auth(context.config, auth_parameters)
          end
        end

        private

        def resolve_with_endpoint_auth(config, endpoint_auth_schemes)
          endpoint_auth_schemes_map = config.endpoint_auth_schemes
          normalized_endpoint_schemes = []
          endpoint_auth_schemes.each do |scheme|
            normalized_scheme_id = endpoint_auth_schemes_map[scheme['name']]
            next unless normalized_scheme_id

            properties = {}
            scheme.each do |key, value|
              next if key == 'name'

              properties[key] = value
            end
            normalized_endpoint_schemes << { scheme_id: normalized_scheme_id, signer_properties: properties }
          end
          resolved_auth_options = prioritize_auth_options(normalized_endpoint_schemes, config.auth_scheme_preference)
          resolve_auth_scheme(config.auth_schemes, resolved_auth_options)
        end

        def resolve_without_endpoint_auth(config, auth_parameters)
          auth_options = config.auth_resolver.resolve(auth_parameters)
          resolved_auth_options = prioritize_auth_options(auth_options, config.auth_scheme_preference)
          resolve_auth_scheme(config.auth_schemes, resolved_auth_options)
        end

        def prioritize_auth_options(auth_options, auth_scheme_preference)
          return auth_options if auth_scheme_preference.empty?

          auth_options_by_id = {}
          auth_options.each do |option|
            auth_options_by_id[option[:scheme_id]] = option
          end

          preferred_options = []
          auth_scheme_preference.each do |scheme_id|
            option = auth_options_by_id[scheme_id]
            next unless option

            preferred_options << option
          end

          preferred_options.empty? ? auth_options : preferred_options
        end

        def resolve_auth_scheme(auth_schemes, auth_options) # rubocop:disable Metrics/MethodLength
          raise 'No auth options were resolved' if auth_options.empty?

          failures = []
          auth_options.each do |auth_option|
            scheme_id = auth_option[:scheme_id]
            if scheme_id == 'smithy.api#noAuth'
              return ResolvedAuth.new(
                scheme_id: 'smithy.api#noAuth', signer: NullSigner.new, signer_properties: {},
                identity_provider: nil
              )
            end
            auth_scheme = auth_schemes[scheme_id]
            error = validate_auth_scheme(auth_scheme, scheme_id)
            unless error
              return ResolvedAuth.new(
                scheme_id: scheme_id,
                signer: auth_scheme.signer,
                signer_properties: auth_option[:signer_properties] || {},
                identity_provider: auth_scheme.identity_provider
              )
            end

            failures << error
          end

          raise failures.join("\n")
        end

        def validate_auth_scheme(auth_scheme, scheme_id)
          return "Auth scheme #{scheme_id} was not enabled for this request" unless auth_scheme

          identity_provider = auth_scheme.identity_provider
          return "Auth scheme #{scheme_id} did not have an identity provider configured" unless identity_provider
          return "Auth scheme #{scheme_id} failed to resolve identity" unless identity_provider.set?

          nil
        end
      end
    end
  end
end
