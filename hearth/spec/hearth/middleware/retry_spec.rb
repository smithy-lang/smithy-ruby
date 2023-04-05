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
    apply_expectations(subject, test_cases[i - 1]) if i > 0

    # Setup the next response
    output = setup_next_response(context, test_cases[i])

    i += 1
    # The app needs to return the output
    output
  end

  subject = Hearth::Middleware::Retry.new(
    app,
    retry_mode: middleware_args[:retry_mode],
    max_attempts: middleware_args[:max_attempts],
    adaptive_retry_wait_to_fill: middleware_args[:adaptive_retry_wait_to_fill],
    error_inspector_class: Hearth::Retry::ErrorInspector,
    retry_quota: retry_quota,
    client_rate_limiter: client_rate_limiter
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
      let(:retry_quota) { Hearth::Retry::RetryQuota.new }
      let(:client_rate_limiter) { Hearth::Retry::ClientRateLimiter.new }

      let(:input) { double('Type::OperationInput') }
      let(:error) do
        Hearth::ApiError.new(
          error_code: 'error_code',
          metadata: {}
        )
      end

      let(:request) do
        Hearth::HTTP::Request.new(
          uri: URI('https://example.com'),
          body: StringIO.new
        )
      end
      let(:response) { Hearth::HTTP::Response.new(body: StringIO.new) }
      let(:context) do
        Hearth::Context.new(
          request: request,
          response: response
        )
      end

      context 'standard mode' do
        let(:middleware_args) do
          {
            retry_mode: 'standard',
            max_attempts: 3,
            adaptive_retry_wait_to_fill: true
          }
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

          handle_with_retry(test_cases, middleware_args.merge(max_attempts: 5))
        end

        it 'does not exceed the max backoff time' do
          stub_const('Hearth::Middleware::Retry::MAX_BACKOFF', 3)

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

          handle_with_retry(test_cases, middleware_args.merge(max_attempts: 5))
        end
      end

      context 'adaptive mode' do
        let(:middleware_args) do
          {
            retry_mode: 'adaptive',
            max_attempts: 3,
            adaptive_retry_wait_to_fill: true
          }
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
