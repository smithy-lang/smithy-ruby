# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class ResolveAuth < Plugin
        option(
          :auth_resolver,
          doc_default: '<DEFAULT_AUTH_RESOLVER>',
          doc_type: '#resolve(parameters)',
          docstring: 'An object that resolves authentication schemes for request signing'
        )

        def before_initialize(client_class, options)
          puts "In resolve auth before initialize"
          options[:auth_resolver] ||= client_class.auth_resolver.new
          puts "Auth resolver is #{options[:auth_resolver]}"
        end

        class << self
          def add_auth_scheme(scheme_id, identity_provider)
            @auth_schemes ||= {}
            puts "Auth_schemes are #{@auth_schemes}"
            @auth_schemes[scheme_id] = identity_provider
          end

          attr_reader :auth_schemes
        end

        # @api private
        class Handler < Smithy::Client::Handler
          def call(context)
            # TODO: apply endpoint auth properties if present
            puts "In resolve auth handler"
            auth_options = context.config.auth_resolver.resolve(context)
            context.auth = resolve_auth(context, auth_options)
            @handler.call(context)
          end

          private

          def resolve_auth(context, auth_options)
            failures = []

            raise 'No auth options were resolved' if auth_options.empty?

            auth_options.each do |auth_option|
              puts "Auth option is #{auth_option}"
              identity_provider = context.config[ResolveAuth.auth_schemes[auth_option]]
              puts "Identity provider is #{identity_provider}"
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

            identity = identity_provider.identity
            unless identity
              failures << "Auth scheme #{scheme_id} failed to resolve identity"
              return
            end

            {
              scheme_id: scheme_id,
              identity: identity,
            }
          end
        end

        handler(Handler, step: :sign, priority: 70)
      end
    end
  end
end
