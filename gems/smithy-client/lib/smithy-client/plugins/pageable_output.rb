# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class PageableOutput < Plugin
        # @api private
        class Handler < Client::Handler
          def call(context)
            context[:original_params] = context.params
            output = @handler.call(context)
            output.extend(Client::PageableOutput)
            trait = paginated_trait(context)
            output.pager = Paginator.new(
              input_token: trait['inputToken'],
              output_token: trait['outputToken'],
              items: trait['items'],
              page_size: trait['pageSize']
            )
            output
          end

          private

          def paginated_trait(context)
            service = context.config.service
            operation = context.operation
            service
              .traits.fetch('smithy.api#paginated', {})
              .merge(operation.traits.fetch('smithy.api#paginated', {}))
          end
        end

        handler(Handler, step: :initialize, priority: 95)
      end
    end
  end
end
