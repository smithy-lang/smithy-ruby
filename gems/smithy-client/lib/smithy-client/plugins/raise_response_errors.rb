# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class RaiseResponseErrors < Plugin
        option(
          :raise_response_errors,
          default: true,
          doc_type: 'Boolean',
          docstring: <<~DOCS)
            When `true`, response errors are raised. When `false`, the error is placed on the
            output in the {Smithy::Client::Response#error error accessor}.
          DOCS

        # @api private
        class Handler < Client::Handler
          def call(context)
            response = @handler.call(context)
            raise response.error if response.error

            response
          end
        end

        def add_handlers(handlers, config)
          handlers.add(Handler, step: :validate, priority: 95) if config.raise_response_errors
        end
      end
    end
  end
end
