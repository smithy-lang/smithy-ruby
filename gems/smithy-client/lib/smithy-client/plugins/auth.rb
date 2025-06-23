# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class Auth < Plugin
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

            identity_providers = context.client.class.identity_providers(context)

            auth_options.each do |auth_option|
              auth_scheme = context.config.auth_schemes[auth_option]
              resolved_auth = try_load_auth_scheme(
                auth_option,
                auth_scheme,
                identity_providers,
                failures
              )

              return resolved_auth if resolved_auth
            end

            raise failures.join("\n")
          end

          def try_load_auth_scheme(auth_option, auth_scheme, identity_providers, failures)
            scheme_id = auth_option
            unless auth_scheme
              failures << "Auth scheme #{scheme_id} was not enabled " \
                'for this request'
              return
            end

            identity_provider = auth_scheme.identity_provider(identity_providers)
            unless identity_provider
              failures << "Auth scheme #{scheme_id} did not have an " \
                'identity resolver configured'
              return
            end

            {
              scheme_id: scheme_id,
              identity: identity_provider.identity,
              signer: auth_scheme.signer
            }
          end
        end

        handler(Handler, step: :sign, priority: 70)
      end
    end
  end
end