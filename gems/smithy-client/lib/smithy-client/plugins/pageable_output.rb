# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class PageableOutput < Plugin
        # @api private
        class Handler < Client::Handler
          def call(context)
            output = @handler.call(context)
            output.extend(Client::PageableOutput)
            output.paginator = context.operation[:paginator] || NullPaginator.new
            output
          end

          # @api private
          class NullPaginator
            def next_tokens(_data)
              {}
            end

            def prev_tokens(_params)
              {}
            end

            def items(_data)
              raise NotImplementedError, 'item iteration is not implemented for this operation'
            end
          end
        end

        handler(Handler, step: :initialize, priority: 95)
      end
    end
  end
end
