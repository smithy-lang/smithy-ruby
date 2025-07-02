# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class ResolveAuth < Plugin
        option(
          :auth_resolver,
          doc_default: 'AuthResolver.new',
          doc_type: '#resolve(context)',
          rbs_type: 'AuthResolver',
          docstring: 'An object that resolves authentication schemes for request signing'
        )

        # @api private
        option(:auth_schemes) { {} }

        def before_initialize(client_class, options)
          options[:auth_resolver] ||= client_class.auth_resolver.new
        end

        # @api private
        class Handler < Smithy::Client::Handler
          def call(context)
            auth_parameters = context.client.class.auth_parameters.create(context)
            auth_options = context.config.auth_resolver.resolve(auth_parameters)
            context.auth = resolve_auth(context, auth_options)
            @handler.call(context)
          end

          private

          def resolve_auth(context, auth_options)
            failures = []
            raise 'No auth options were resolved' if auth_options.empty?

            auth_options.each do |auth_option|
              # Anonymous auth does not have a plugin and does not sign,
              # so if auth scheme is noAuth then just return scheme_id.
              return { scheme_id: auth_option } if auth_option == 'smithy.api#noAuth'

              unless context.config.auth_schemes.key?(auth_option)
                failures << "Auth scheme #{auth_option} was not enabled for this request"
                next
              end

              identity_provider = context.config.auth_schemes[auth_option]
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
              failures << "Auth scheme #{scheme_id} did not have an identity resolver configured"
              return
            end

            identity = identity_provider.identity
            unless identity
              failures << "Auth scheme #{scheme_id} failed to resolve identity"
              return
            end

            {
              scheme_id: scheme_id,
              identity: identity
            }
          end
        end

        handler(Handler, step: :sign, priority: 70)
      end
    end
  end
end
