module Smithy
  module Client
    # @api private
    module Auth
      class << self
        def resolve_auth(context, endpoint_properties = {})
          if endpoint_properties.key?('authSchemes')
            resolve_auth_scheme_with_endpoint(context, endpoint_properties['authSchemes'])
          else
            resolve_auth_scheme_without_endpoint(context)
          end
        end

        private

        def resolve_auth_scheme_with_endpoint(context, endpoint_auth_schemes)
          normalized_endpoint_schemes = []
          endpoint_auth_schemes.each do |scheme|
            scheme_id = context.config.endpoint_auth_schemes[scheme['name']]
            next unless scheme_id

            normalized_scheme = { scheme_id: scheme_id }
            scheme.each do |key, value|
              next if key == 'name'

              normalized_scheme[key] = value
            end
            normalized_endpoint_schemes << normalized_scheme
          end
          resolved_auth_options = prioritize_auth_options(
            normalized_endpoint_schemes,
            context.config.auth_scheme_preference
          )
          resolve_auth_scheme(context.config.auth_schemes, resolved_auth_options)
        end

        def resolve_auth_scheme_without_endpoint(context)
          auth_parameters = context.client.class.auth_parameters.create(context)
          auth_options = context.config.auth_resolver.resolve(auth_parameters)
          resolved_auth_options = prioritize_auth_options(auth_options, context.config.auth_scheme_preference)
          resolve_auth_scheme(context.config.auth_schemes, resolved_auth_options)
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

        def resolve_auth_scheme(auth_schemes, auth_options)
          raise 'No auth options were resolved' if auth_options.empty?

          failures = []
          auth_options.each do |auth_option|
            scheme_id = auth_option[:scheme_id]

            # Anonymous auth does not have a plugin and does not sign
            return auth_option if scheme_id == 'smithy.api#noAuth'

            error = validate_auth_scheme(auth_schemes, scheme_id)
            return auth_option unless error

            failures << error
          end

          raise failures.join("\n")
        end

        def validate_auth_scheme(auth_schemes, scheme_id)
          return "Auth scheme #{scheme_id} was not enabled for this request" unless auth_schemes.key?(scheme_id)

          identity_provider = auth_schemes[scheme_id]
          return "Auth scheme #{scheme_id} did not have an identity provider configured" unless identity_provider
          return "Auth scheme #{scheme_id} failed to resolve identity" unless identity_provider.set?

          nil
        end
      end
    end
  end
end
