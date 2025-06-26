# frozen_string_literal: true

module Smithy
  module Client
    module Auth
      # @api private
      class Handler < Smithy::Client::Handler
        def call(context)
          # TODO: apply endpoint auth properties if present
          auth_options = context.config.auth_resolver.resolve(context)
          context.auth = resolve_auth(context, auth_options)
          @handler.call(context)
        end

        private

        def resolve_auth(context, auth_options)
          failures = []

          raise 'No auth options were resolved' if auth_options.empty?

          default_auth_schemes = context.config.default_auth_schemes

          auth_options.each do |auth_option|
            identity_provider = context.config[default_auth_schemes[auth_option]]
            resolved_auth = try_load_auth_scheme(
              auth_option,
              identity_provider,
              failures
            )

            return resolved_auth if resolved_auth
          end

          raise failures.join("\n")
        end

        def try_load_auth_scheme(auth_option, identity_provider, failures)
          scheme_id = auth_option

          unless identity_provider
            failures << "Auth scheme #{scheme_id} was not enabled " \
                        'for this request or did not have an ' \
                        'identity resolver configured'
            return
          end

          {
            scheme_id: scheme_id,
            identity: identity_provider.identity,
          }
        end
      end
    end
  end
end
