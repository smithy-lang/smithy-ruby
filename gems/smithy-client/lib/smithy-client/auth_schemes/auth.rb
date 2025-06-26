# frozen_string_literal: true

module Smithy
  module Client
    module AuthSchemes
      # @api private
      class Handler < Smithy::Client::Handler
        def call(context)
          # TODO: apply endpoint auth properties if present
          auth_options = context.config.auth_resolver.resolve(context)
          context.auth = resolve_auth(context, auth_options)
          puts "Resolved context auth is #{context.auth}"
          @handler.call(context)
        end

        private

        def resolve_auth(context, auth_options)
          failures = []

          raise 'No auth options were resolved' if auth_options.empty?

          auth_to_identity = context.client.class.auth_to_identity(context)

          auth_options.each do |auth_option|
            auth_scheme = context.config.auth_schemes[auth_option]
            puts "Auth scheme: #{auth_scheme.inspect}"
            identity_provider = auth_to_identity[auth_scheme]
            puts "Identity provider: #{identity_provider.inspect}"
            puts "This should definitely work: #{auth_to_identity['aws.auth#sigv4']}"
            resolved_auth = try_load_auth_scheme(
              auth_option,
              auth_scheme,
              identity_provider,
              failures
            )

            return resolved_auth if resolved_auth
          end

          raise failures.join("\n")
        end

        def try_load_auth_scheme(auth_option, auth_scheme, identity_provider, failures)
          scheme_id = auth_option
          unless auth_scheme
            failures << "Auth scheme #{scheme_id} was not enabled " \
                        'for this request'
            return
          end

          unless identity_provider
            failures << "Auth scheme #{scheme_id} did not have an " \
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
