# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class RetryErrors < Plugin
        option(
          :retry_mode,
          default: 'standard',
          doc_default: "'standard'",
          doc_type: 'String, Class',
          docstring: <<~DOCS)
            Specifies which retry algorithm to use. Values are:

            * `standard` - A standardized set of retry rules across the AWS SDKs.
              This includes support for retry quotas, which limit the number of
              unsuccessful retries a client can make. This is the default
            value if no retry mode is provided.

            * `adaptive` - A retry mode that includes all the functionality of
              `standard` mode along with automatic client side throttling.
          DOCS

        option(
          :max_attempts,
          default: 3,
          doc_type: Integer,
          docstring: <<~DOCS)
            The maximum number attempts that will be made for a single request, including
            the initial attempt. Used in the `standard` and `adaptive` retry strategies.
          DOCS

        option(
          :adaptive_retry_wait_to_fill,
          default: true,
          doc_type: 'Boolean',
          docstring: <<~DOCS)
            When true, the request will sleep until there is sufficient client side capacity to retry
            the request. When false, the request will raise a `CapacityNotAvailableError` and will
            not retry instead of sleeping.
          DOCS

        # @api private undocumented
        option(:retry_strategy)

        def after_initialize(client)
          config = client.config
          config.retry_strategy =
            case config.retry_mode
            when 'standard'
              Retry::Standard.new(
                max_attempts: config.max_attempts
              )
            when 'adaptive'
              Retry::Adaptive.new(
                max_attempts: config.max_attempts,
                wait_to_fill: config.adaptive_retry_wait_to_fill
              )
            else
              raise ArgumentError, 'Must provide either standard` or `adaptive` for retry_mode'
            end
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            retry_strategy = context.config.retry_strategy
            token = retry_strategy.acquire_initial_retry_token(nil)
            handle(context, retry_strategy, token)
          end

          private

          def handle(context, retry_strategy, token)
            response = track_feature(retry_strategy) { @handler.call(context) }
            unless response.error
              retry_strategy.record_success(token)
              return response
            end
            return response unless retryable?(context.http_request)

            token = handle_error(context, response, retry_strategy, token)
            return response unless token

            retry_request(context, response, retry_strategy, token)
          end

          def handle_error(context, response, retry_strategy, token)
            error_info = Http::ErrorInspector.new(response.error, context.http_response)
            retry_strategy.request_bookkeeping(error_info)
            token = retry_strategy.refresh_retry_token(token, error_info)
            return unless token

            if token.no_retry_reason == :quota_exhausted
              Kernel.sleep(token.retry_delay) if long_polling_operation?(context)
              return
            end

            Kernel.sleep(token.retry_delay)
            token
          end

          def retry_request(context, response, retry_strategy, token)
            reset_request(context)
            reset_response(context, response)
            context.retries += 1
            handle(context, retry_strategy, token)
          end

          def retryable?(request)
            # IO responds to #rewind however it returns an illegal seek error
            request.body.respond_to?(:rewind) && !request.body.instance_of?(IO)
          end

          def reset_request(context)
            context.http_request.body.rewind
          end

          def reset_response(context, response)
            context.http_response.reset
            response.error = nil
          end

          # TODO: Revisit after trait is finalized.
          def long_polling_operation?(context)
            context.operation.traits.key?('smithy.api#longPoll')
          end

          def track_feature(retry_strategy, &block)
            case retry_strategy
            when Retry::Standard then Features.track('RETRY_MODE_STANDARD', &block)
            when Retry::Adaptive then Features.track('RETRY_MODE_ADAPTIVE', &block)
            else block.call
            end
          end
        end

        handler(Handler, step: :retry)
      end
    end
  end
end
