# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class ResolveAuth < Plugin
        option(:auth_schemes, docstring: 'todo') { {} }
        option(:auth_resolver, docstring: 'todo')

        def after_initialize(client)
          client.config.auth_resolver ||= client.class.auth_resolver.new
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            identity_providers = context.client.class.identity_providers(context.config)
            auth_params = context.client.class.auth_parameters.create(context)
            auth_options = context.config.auth_resolver.resolve(auth_params)
            context[:auth] = resolve_auth(context, auth_options, identity_providers)
            @handler.call(context)
          end

          private

          def resolve_auth(context, auth_options, identity_providers)
            failures = []

            raise 'No auth options were resolved' if auth_options.empty?

            auth_options.each do |auth_option|
              auth_scheme = context.config.auth_schemes[auth_option.scheme_id]
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
            scheme_id = auth_option.scheme_id
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

            identity_properties = auth_option.identity_properties
            identity = identity_provider.identity(identity_properties)

            ResolvedAuth.new(
              scheme_id: scheme_id,
              identity: identity,
              identity_properties: auth_option.identity_properties,
              signer: auth_scheme.signer,
              signer_properties: auth_option.signer_properties
            )
          end

          # @api private
          class ResolvedAuth
            def initialize(options = {})
              @scheme_id = options[:scheme_id]
              @signer = options[:signer]
              @signer_properties = options[:signer_properties]
              @identity = options[:identity]
              @identity_properties = options[:identity_properties]
            end

            attr_accessor :scheme_id, :signer, :signer_properties, :identity, :identity_properties
          end
        end

        handler(Handler, priority: 60)
      end
    end
  end
end
