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
            raise 'No auth options were resolved' if auth_options.empty?

            failures = []
            auth_options.each do |auth_option|
              scheme_id = auth_option[:scheme_id]

              # Anonymous auth does not have a plugin and does not sign
              return auth_option if scheme_id == 'smithy.api#noAuth'

              error = validate_auth_scheme(context, scheme_id)
              return auth_option unless error

              failures << error
            end

            raise failures.join("\n")
          end

          def validate_auth_scheme(context, scheme_id)
            unless context.config.auth_schemes.key?(scheme_id)
              return "Auth scheme #{scheme_id} was not enabled for this request"
            end

            identity_provider = context.config.auth_schemes[scheme_id]
            return "Auth scheme #{scheme_id} did not have an identity provider configured" unless identity_provider
            return "Auth scheme #{scheme_id} failed to resolve identity" unless identity_provider.set?

            nil
          end
        end

        handler(Handler, step: :sign, priority: 70)
      end
    end
  end
end
