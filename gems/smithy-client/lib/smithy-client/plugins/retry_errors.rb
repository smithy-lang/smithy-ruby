# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class RetryErrors < Plugin
        option(
          :retry_strategy,
          default: 'standard',
          doc_type: 'String, Class',
          docstring: <<~DOCS)
            The retry strategy to use when retrying errors. This can be one of the following:
            * `standard` - A standardized retry strategy used by the AWS SDKs. This includes support
              for retry quotas, which limit the number of unsuccessful retries a client can make.
            * `adaptive` - An experimental retry strategy that includes all the functionality of the
              `standard` strategy along with automatic client side throttling. This is a provisional
              strategy that may change behavior in the future.
            * Any instance of a class that implements the following methods:
              - `acquire_initial_retry_token(token_scope)`
              - `refresh_retry_token(retry_token, error_info)`
              - `record_success(retry_token)`
          DOCS

        option(
          :retry_max_attempts,
          default: 3,
          doc_type: Integer,
          docstring: <<~DOCS)
            The maximum number attempts that will be made for a single request, including
            the initial attempt. Used in the `standard` and `adaptive` retry strategies.
          DOCS

        option(
          :retry_backoff,
          default: Retry::EXPONENTIAL_BACKOFF,
          doc_default: 'Smithy::Client::Retry::EXPONENTIAL_BACKOFF',
          doc_type: 'lambda',
          docstring: <<~DOCS)
            A callable object that calculates a backoff delay for a retry attempt. The callable
            should accept a single argument, `attempts`, that represents the number of attempts
            that have been made. Used in the `standard` and `adaptive` retry strategies.
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

        def after_initialize(client)
          config = client.config
          config.retry_strategy =
            case config.retry_strategy
            when 'standard'
              Retry::Standard.new(
                max_attempts: config.retry_max_attempts,
                backoff: config.retry_backoff
              )
            when 'adaptive'
              Retry::Adaptive.new(
                max_attempts: config.retry_max_attempts,
                backoff: config.retry_backoff,
                wait_to_fill: config.adaptive_retry_wait_to_fill
              )
            else
              config.retry_strategy
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

        handler(Handler, step: :retry)
      end
    end
  end
end
