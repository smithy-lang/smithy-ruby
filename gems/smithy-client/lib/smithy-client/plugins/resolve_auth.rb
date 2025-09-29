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
          docstring: 'An object that resolves authentication schemes for request signing.'
        )

        option(
          :auth_scheme_preference,
          doc_type: 'Array<String>',
          rbs_type: 'Array[String]',
          docstring: 'A list of preferred authentication schemes to use when making a request.'
        ) do
          []
        end

        option(:auth_schemes) { {} }

        def before_initialize(client_class, options)
          options[:auth_resolver] ||= client_class.auth_resolver.new
        end

        # @api private
        class Handler < Smithy::Client::Handler
          def call(context)
            context.auth = Auth.resolve(context, context[:resolved_endpoint].properties)
            @handler.call(context)
          end
        end

        handler(Handler, step: :sign, priority: 75)
      end
    end
  end
end
