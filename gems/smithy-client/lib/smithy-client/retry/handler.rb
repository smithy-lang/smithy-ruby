# frozen_string_literal: true

require 'pathname'

module Smithy
  module Client
    module Retry
      # @api private
      class Handler < Client::Handler
        def call(context)
          retry_strategy = context.config.retry_strategy
          token = retry_strategy.acquire_initial_retry_token(nil)
          handle(context, retry_strategy, token)
        end

        private

        def handle(context, retry_strategy, token)
          output = @handler.call(context)
          if (error = output.error)
            return output unless retryable?(context.request)

            error_info = HTTP::ErrorInspector.new(error, context.response)
            token = retry_strategy.refresh_retry_token(token, error_info)
            return output unless token

            Kernel.sleep(token.retry_delay)
          else
            retry_strategy.record_success(token)
            return output
          end

          reset_request(context)
          reset_response(context, output)
          context.retries += 1
          handle(context, retry_strategy, token)
        end

        def retryable?(request)
          # IO responds to #rewind however it returns an illegal seek error
          request.body.respond_to?(:rewind) && !request.body.instance_of?(IO)
        end

        def reset_request(context)
          request = context.request
          request.body.rewind
        end

        def reset_response(context, output)
          context.response.reset
          output.error = nil
        end
      end
    end
  end
end
