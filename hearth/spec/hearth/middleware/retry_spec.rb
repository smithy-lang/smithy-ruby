# frozen_string_literal: true

# A helper method to test Standard and Adaptive tests
# Expects a test case defined as a Hash with response and expect keys.
# response: Hash with status_code and error
# expect: delay, available_capacity, retries, calculated_rate,
#   measured_tx_rate, fill_rate
def handle_with_retry(test_cases, middleware_args = {})
  # Apply delay expectations first
  test_cases.each do |test_case|
    if test_case[:expect][:delay]
      expect(Kernel).to receive(:sleep).with(test_case[:expect][:delay])
    end
  end

  i = 0
  # The expectations need a reference to subject, but we cannot create it
  # until we define the expectations proc.
  subject = nil
  # The proc becomes the middleware's @app
  app = proc do |_input, context|
    apply_expectations(subject, test_cases[i - 1]) if i.positive?

    # Setup the next response
    output = setup_next_response(context, test_cases[i])

    i += 1
    # The app needs to return the output
    output
  end

  subject = Hearth::Middleware::Retry.new(
    app,
    error_inspector_class: Hearth::HTTP::ErrorInspector,
    retry_strategy: middleware_args[:retry_strategy]
  )
  subject.call(input, context)

  expect(i).to(
    eq(test_cases.size),
    "Wrong number of retries. Handler was called #{i} times " \
    "but #{test_cases.size} test cases were defined."
  )

  # Handle has finished called. Apply final expectations.
  apply_expectations(subject, test_cases[i - 1])
end

def apply_expectations(retry_class, test_case)
  expected = test_case[:expect]

  # Don't actually sleep
  allow(Kernel).to receive(:sleep)

  retry_strategy = retry_class.instance_variable_get(:@retry_strategy)
  retry_quota = retry_strategy.instance_variable_get(:@retry_quota)
  client_rate_limiter =
    retry_strategy.instance_variable_get(:@client_rate_limiter)

  if expected[:retries]
    expect(retry_class.instance_variable_get(:@retries))
      .to eq(expected[:retries])
  end
  if expected[:available_capacity]
    expect(retry_quota.instance_variable_get(:@available_capacity))
      .to eq(expected[:available_capacity])
  end
  if expected[:calculated_rate]
    expect(client_rate_limiter.instance_variable_get(:@calculated_rate))
      .to be_within(0.2).of(expected[:calculated_rate])
  end
  if expected[:measured_tx_rate]
    expect(client_rate_limiter.instance_variable_get(:@measured_tx_rate))
      .to be_within(0.1).of(expected[:measured_tx_rate])
  end
  if expected[:fill_rate]
    expect(client_rate_limiter.instance_variable_get(:@fill_rate))
      .to be_within(0.1).of(expected[:fill_rate])
  end
  nil
end

def setup_next_response(context, test_case)
  response = test_case[:response]
  if response[:timestamp]
    allow(Process).to receive(:clock_gettime)
      .with(Process::CLOCK_MONOTONIC).and_return(response[:timestamp])
  end
  context.response.status = response[:status_code]
  Hearth::Output.new(error: response[:error])
end

module Hearth
  module Middleware
    describe Retry do
      let(:input) { double('input') }

      let(:error) do
        Hearth::ApiError.new(
          error_code: 'error_code',
          metadata: {}
        )
      end

      let(:request) { Hearth::HTTP::Request.new }
      let(:response) { Hearth::HTTP::Response.new }
      let(:interceptors) { double('interceptors', each: []) }
      let(:logger) { Logger.new(IO::NULL) }
      let(:context) do
        Hearth::Context.new(
          request: request,
          response: response,
          logger: logger,
          interceptors: interceptors
        )
      end

      before { allow(error).to receive(:retryable?).and_return(true) }

      let(:token) { double('token', retry_delay: 0) }
      let(:retry_strategy) do
        double(
          'retry',
          acquire_initial_retry_token: token,
          record_success: nil,
          refresh_retry_token: nil
        )
      end
      let(:app) { double('app', call: output) }
      let(:output) { Hearth::Output.new(error: error) }
      let(:subject) do
        Hearth::Middleware::Retry.new(
          app,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: retry_strategy
        )
      end

      let(:signer) { double('signer', reset: nil) }
      let(:identity) { double('identity') }
      let(:auth_option) do
        double(
          'auth_option',
          signer_properties: {},
          identity_properties: {}
        )
      end
      let(:resolved_auth) do
        double(
          'resolved_auth',
          signer: signer,
          signer_properties: auth_option.signer_properties,
          identity: identity,
          identity_properties: auth_option.identity_properties
        )
      end

      before { context.auth = resolved_auth }

      it 'calls all of the interceptor hooks and the app' do
        expect(Interceptors).to receive(:invoke)
          .with(hash_including(
                  hook: Interceptor::MODIFY_BEFORE_RETRY_LOOP
                )).ordered
        expect(Interceptors).to receive(:invoke)
          .with(hash_including(
                  hook: Interceptor::READ_BEFORE_ATTEMPT
                )).ordered
        expect(app).to receive(:call).and_return(output).ordered
        expect(Interceptors).to receive(:invoke)
          .with(hash_including(
                  hook: Interceptor::MODIFY_BEFORE_ATTEMPT_COMPLETION
                )).ordered
        expect(Interceptors).to receive(:invoke)
          .with(hash_including(
                  hook: Interceptor::READ_AFTER_ATTEMPT
                )).ordered

        subject.call(input, context)
      end

      context 'modify_before_retry_loop error' do
        let(:interceptor_error) { StandardError.new }

        it 'returns output with the error and does not call app' do
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::MODIFY_BEFORE_RETRY_LOOP
                  )).and_return(interceptor_error)
          expect(app).not_to receive(:call)

          out = subject.call(input, context)
          expect(out.error).to eq(interceptor_error)
        end
      end

      context 'read_before_attempt error' do
        let(:interceptor_error) { StandardError.new }

        it 'returns output with the error and does not call app' do
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::MODIFY_BEFORE_RETRY_LOOP
                  ))
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::READ_BEFORE_ATTEMPT
                  )).and_return(interceptor_error)
          expect(app).not_to receive(:call)
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::MODIFY_BEFORE_ATTEMPT_COMPLETION
                  ))
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::READ_AFTER_ATTEMPT
                  ))

          out = subject.call(input, context)
          expect(out.error).to eq(interceptor_error)
        end
      end

      context 'modify_before_attempt_completion error' do
        let(:interceptor_error) { StandardError.new }

        it 'returns output with the error and calls app' do
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::MODIFY_BEFORE_RETRY_LOOP
                  ))
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::READ_BEFORE_ATTEMPT
                  ))
          expect(app).to receive(:call)
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::MODIFY_BEFORE_ATTEMPT_COMPLETION
                  )).and_return(interceptor_error)
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::READ_AFTER_ATTEMPT
                  ))

          out = subject.call(input, context)
          expect(out).to be output
        end
      end

      context 'read_after_attempt error' do
        let(:interceptor_error) { StandardError.new }

        it 'returns output with the error and calls app' do
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::MODIFY_BEFORE_RETRY_LOOP
                  ))
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::READ_BEFORE_ATTEMPT
                  ))
          expect(app).to receive(:call)
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::MODIFY_BEFORE_ATTEMPT_COMPLETION
                  ))
          expect(Interceptors).to receive(:invoke)
            .with(hash_including(
                    hook: Interceptor::READ_AFTER_ATTEMPT
                  )).and_return(interceptor_error)

          out = subject.call(input, context)
          expect(out).to be output
        end
      end

      it 'resets request, response, and output error on retry' do
        expect(app).to receive(:call).and_return(output).twice
        expect(retry_strategy).to receive(:refresh_retry_token)
          .and_return(token, nil)

        expect(request.body).to receive(:rewind)
        expect(response).to receive(:reset)
        expect(output).to receive(:error=).with(nil)
        expect(signer).to receive(:reset).with(
          request: request,
          properties: auth_option.signer_properties
        )
        subject.call(input, context)
      end

      it 'does not retry IO objects' do
        expect(app).to receive(:call).and_return(output).once
        expect(retry_strategy).not_to receive(:refresh_retry_token)

        rd, wr = IO.pipe
        wr.write('foo')
        wr.close
        request.body = rd
        expect(request.body).not_to receive(:rewind)
        subject.call(input, context)
      end

      context 'standard mode' do
        let(:retry_strategy) { Hearth::Retry::Standard.new }
        let(:retry_quota) do
          retry_strategy.instance_variable_get(:@retry_quota)
        end

        let(:middleware_args) do
          { retry_strategy: retry_strategy }
        end

        before do
          allow(Kernel).to receive(:rand).and_return(1)
        end

        it 'retry eventually succeeds' do
          test_cases = [
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 495, retries: 1, delay: 1 }
            },
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 490, retries: 2, delay: 2 }
            },
            {
              response: { status_code: 200, error: nil },
              expect: { available_capacity: 495, retries: 2 }
            } # success
          ]

          handle_with_retry(test_cases, middleware_args)
        end

        it 'fails due to max attempts reached' do
          test_cases = [
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 495, retries: 1, delay: 1 }
            },
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 490, retries: 2, delay: 2 }
            },
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 490, retries: 2 }
            } # failure
          ]

          handle_with_retry(test_cases, middleware_args)
        end

        it 'fails due to retry quota reached after a single retry' do
          retry_quota.instance_variable_set(:@available_capacity, 5)

          test_cases = [
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 0, retries: 1, delay: 1 }
            },
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 0, retries: 1 }
            }
          ]

          handle_with_retry(test_cases, middleware_args)
        end

        it 'does not retry if the retry quota is 0' do
          retry_quota.instance_variable_set(:@available_capacity, 0)

          test_cases = [
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 0, retries: 0 }
            }
          ]

          handle_with_retry(test_cases, middleware_args)
        end

        it 'uses exponential backoff timing' do
          test_cases = [
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 495, retries: 1, delay: 1 }
            },
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 490, retries: 2, delay: 2 }
            },
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 485, retries: 3, delay: 4 }
            },
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 480, retries: 4, delay: 8 }
            },
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 480, retries: 4 }
            }
          ]

          args = middleware_args.merge(
            retry_strategy: Hearth::Retry::Standard.new(max_attempts: 5)
          )
          handle_with_retry(test_cases, args)
        end

        it 'does not exceed the max backoff time' do
          stub_const('Hearth::Retry::ExponentialBackoff::MAX_BACKOFF', 3)

          test_cases = [
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 495, retries: 1, delay: 1 }
            },
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 490, retries: 2, delay: 2 }
            },
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 485, retries: 3, delay: 3 }
            },
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 480, retries: 4, delay: 3 }
            },
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 480, retries: 4 }
            }
          ]

          args = middleware_args.merge(
            retry_strategy: Hearth::Retry::Standard.new(max_attempts: 5)
          )
          handle_with_retry(test_cases, args)
        end
      end

      context 'adaptive mode' do
        let(:retry_strategy) { Hearth::Retry::Adaptive.new }
        let(:retry_quota) do
          retry_strategy.instance_variable_get(:@retry_quota)
        end
        let(:client_rate_limiter) do
          retry_strategy.instance_variable_get(:@client_rate_limiter)
        end

        let(:middleware_args) do
          { retry_strategy: retry_strategy }
        end

        it 'verifies cubic calculations for successes' do
          client_rate_limiter.instance_variable_set(:@last_throttle_time, 5)
          client_rate_limiter.instance_variable_set(:@last_tx_rate_bucket, 4.5)
          client_rate_limiter.instance_variable_set(:@last_max_rate, 10)

          successes = [
            {
              response: { status_code: 200, error: nil, timestamp: 5 },
              expect: { calculated_rate: 7.0 }
            },
            {
              response: { status_code: 200, error: nil, timestamp: 6 },
              expect: { calculated_rate: 9.6 }
            },
            {
              response: { status_code: 200, error: nil, timestamp: 7 },
              expect: { calculated_rate: 10.0 }
            },
            {
              response: { status_code: 200, error: nil, timestamp: 8 },
              expect: { calculated_rate: 10.45 }
            },
            {
              response: { status_code: 200, error: nil, timestamp: 9 },
              expect: { calculated_rate: 13.4 }
            },
            {
              response: { status_code: 200, error: nil, timestamp: 10 },
              expect: { calculated_rate: 21.2 }
            },
            {
              response: { status_code: 200, error: nil, timestamp: 11 },
              expect: { calculated_rate: 36.4 }
            }
          ]

          # Have to run the method each time because there are no failures
          successes.each do |success|
            handle_with_retry([success], middleware_args)
          end
        end

        it 'verifies success and throttling behavior' do
          client_rate_limiter.instance_variable_set(:@last_throttle_time, 0)
          client_rate_limiter.instance_variable_set(:@last_tx_rate_bucket, 0)
          client_rate_limiter.instance_variable_set(:@last_max_rate, 0)

          def success(timestamp, measured_tx_rate, fill_rate)
            [{
              response: {
                status_code: 200, error: nil, timestamp: timestamp
              },
              expect: {
                fill_rate: fill_rate, measured_tx_rate: measured_tx_rate
              }
            }]
          end

          def throttle(timestamp, measured_tx_rate, fill_rate)
            [{
              response: {
                status_code: 429, error: error, timestamp: timestamp
              },
              expect: {
                fill_rate: fill_rate, measured_tx_rate: measured_tx_rate
              }
            }]
          end

          handle_with_retry success(0.2, 0.0, 0.5), middleware_args
          handle_with_retry success(0.4, 0.0, 0.5), middleware_args
          handle_with_retry success(0.6, 4.8, 0.5), middleware_args
          handle_with_retry success(0.8, 4.8, 0.5), middleware_args
          handle_with_retry success(1.0, 4.16, 0.5), middleware_args
          handle_with_retry success(1.2, 4.16, 0.69), middleware_args
          handle_with_retry success(1.4, 4.16, 1.10), middleware_args
          handle_with_retry success(1.6, 5.63, 1.63), middleware_args
          handle_with_retry success(1.8, 5.63, 2.33), middleware_args
          handle_with_retry throttle(2.0, 4.32, 3.02) +
                            success(2.2, 4.32, 3.48), middleware_args
          handle_with_retry success(2.4, 4.32, 3.82), middleware_args

          # The token bucket need additional capacity to fulfill this request
          client_rate_limiter.instance_variable_set(:@current_capacity, 10)
          handle_with_retry success(2.6, 5.66, 4.05), middleware_args
          handle_with_retry success(2.8, 5.66, 4.20), middleware_args
          handle_with_retry success(3.0, 4.33, 4.28), middleware_args
          handle_with_retry throttle(3.2, 4.33, 2.99) +
                            success(3.4, 4.32, 3.45), middleware_args
        end
      end
    end
  end
end
