# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class DefaultParams < Plugin
        def add_handlers(handlers, _config)
          handlers.add(Handler, step: :initialize)
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            Client::DefaultParams.new(context.operation.input).apply(context.params)
            @handler.call(context)
          end
        end
      end
    end
  end
end
