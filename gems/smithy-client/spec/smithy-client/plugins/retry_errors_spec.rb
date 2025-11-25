# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../support/retry_errors_helper'

module Smithy
  module Client
    module Plugins
      describe RetryErrors do
        let(:sample_client) { ClientHelper.sample_client }
        let(:client_class) { sample_client.const_get(:Client) }
        let(:client) { client_class.new(stub_responses: true) }

        it 'adds a :retry_strategy option to config' do
          expect(client.config).to respond_to(:retry_strategy)
        end

        it 'adds a :retry_max_attempts option to config' do
          expect(client.config).to respond_to(:retry_max_attempts)
        end

        it 'adds a :retry_backoff option to config' do
          expect(client.config).to respond_to(:retry_backoff)
        end

        it 'adds an :adaptive_retry_wait_to_fill option to config' do
          expect(client.config).to respond_to(:adaptive_retry_wait_to_fill)
        end

        it 'creates a Standard retry strategy from a string' do
          client = client_class.new(retry_strategy: 'standard')
          expect(client.config.retry_strategy).to be_a(Retry::Standard)
        end

        it 'creates an Adaptive retry strategy from a string' do
          client = client_class.new(retry_strategy: 'adaptive')
          expect(client.config.retry_strategy).to be_a(Retry::Adaptive)
        end

        it 'uses a custom retry strategy' do
          retry_strategy = double('CustomRetryStrategy')
          client = client_class.new(retry_strategy: retry_strategy)
          expect(client.config.retry_strategy).to be(retry_strategy)
        end

        it 'passes flat options to the standard retry strategy class' do
          client = client_class.new(
            retry_strategy: 'standard',
            retry_max_attempts: 5,
            retry_backoff: 2
          )
          expect(client.config.retry_max_attempts).to eq(5)
          expect(client.config.retry_backoff).to eq(2)
          retry_strategy = client.config.retry_strategy
          expect(retry_strategy.max_attempts).to eq(5)
          expect(retry_strategy.backoff).to eq(2)
        end

        it 'passes flat options to the adaptive retry strategy class' do
          client = client_class.new(
            retry_strategy: 'adaptive',
            retry_max_attempts: 5,
            retry_backoff: 2,
            adaptive_retry_wait_to_fill: 5
          )
          expect(client.config.retry_max_attempts).to eq(5)
          expect(client.config.retry_backoff).to eq(2)
          expect(client.config.adaptive_retry_wait_to_fill).to eq(5)
          retry_strategy = client.config.retry_strategy
          expect(retry_strategy.max_attempts).to eq(5)
          expect(retry_strategy.backoff).to eq(2)
          expect(retry_strategy.wait_to_fill).to eq(5)
        end

        it 'adds the handler by default' do
          client = client_class.new
          expect(client.handlers).to include(RetryErrors::Handler)
        end

        it 'does not add the handler if :stub_responses is enabled' do
          expect(client.handlers).not_to include(RetryErrors::Handler)
        end

        describe RetryErrors::Handler, rbs_test: :skip do
          let(:config) do
            config = Smithy::Client::Configuration.new
            config.add_option(:service)
            Plugins::RetryErrors.new.add_options(config)
            config.build!
          end

          let(:context) { HandlerContext.new(config: config) }
          let(:response) { Response.new(context: context) }
          let(:service_error) { ServiceError.new(context, Schema::EmptyStructure.new) }

          let(:retry_strategy) { config.retry_strategy }
          let(:quota) { retry_strategy.instance_variable_get(:@quota) }
          let(:client_rate_limiter) { retry_strategy.instance_variable_get(:@client_rate_limiter) }

          subject { RetryErrors::Handler.new }

          context 'standard mode' do
            before(:each) do
              config.retry_strategy = Retry::Standard.new
              allow(Kernel).to receive(:rand).and_return(1)
            end

            it 'retry eventually succeeds' do
              test_case_def = [
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 495, retries: 1, delay: 1 }
                },
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 490, retries: 2, delay: 2 }
                },
                {
                  response: { status_code: 200, error: nil },
                  expect: { available_capacity: 495, retries: 2 }
                } # success
              ]

              handle_with_retry(test_case_def)
            end

            it 'fails due to max attempts reached' do
              test_case_def = [
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 495, retries: 1, delay: 1 }
                },
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 490, retries: 2, delay: 2 }
                },
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 490, retries: 2 }
                } # failure
              ]

              handle_with_retry(test_case_def)
            end

            it 'fails due to retry quota reached after a single retry' do
              quota.instance_variable_set(:@available_capacity, 5)

              test_case_def = [
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 0, retries: 1, delay: 1 }
                },
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 0, retries: 1 }
                }
              ]

              handle_with_retry(test_case_def)
            end

            it 'does not retry if the retry quota is 0' do
              quota.instance_variable_set(:@available_capacity, 0)

              test_case_def = [
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 0, retries: 0 }
                }
              ]

              handle_with_retry(test_case_def)
            end

            it 'uses exponential backoff timing' do
              retry_strategy.instance_variable_set(:@max_attempts, 5)

              test_case_def = [
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 495, retries: 1, delay: 1 }
                },
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 490, retries: 2, delay: 2 }
                },
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 485, retries: 3, delay: 4 }
                },
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 480, retries: 4, delay: 8 }
                },
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 480, retries: 4 }
                }
              ]

              handle_with_retry(test_case_def)
            end

            it 'does not exceed the max backoff time' do
              config.retry_strategy = Retry::Standard.new(max_delay: 3)
              retry_strategy.instance_variable_set(:@max_attempts, 5)

              test_case_def = [
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 495, retries: 1, delay: 1 }
                },
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 490, retries: 2, delay: 2 }
                },
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 485, retries: 3, delay: 3 }
                },
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 480, retries: 4, delay: 3 }
                },
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 480, retries: 4 }
                }
              ]

              handle_with_retry(test_case_def)
            end

            it 'fails due to retry quota bucket exhaustion' do
              config.retry_max_attempts = 5
              quota.instance_variable_set(:@available_capacity, 10)

              test_case_def = [
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 5, retries: 1, delay: 1 }
                },
                {
                  response: { status_code: 502, error: service_error },
                  expect: { available_capacity: 0, retries: 2, delay: 2 }
                },
                {
                  response: { status_code: 503, error: service_error },
                  expect: { available_capacity: 0, retries: 2 }
                }
              ]

              handle_with_retry(test_case_def)
            end

            it 'recovers after successful responses' do
              config.retry_max_attempts = 5
              quota.instance_variable_set(:@available_capacity, 15)

              test_case_def = [
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 10, retries: 1, delay: 1 }
                },
                {
                  response: { status_code: 502, error: service_error },
                  expect: { available_capacity: 5, retries: 2, delay: 2 }
                },
                {
                  response: { status_code: 200, error: nil },
                  expect: { available_capacity: 10, retries: 2 }
                }
              ]
              handle_with_retry(test_case_def)

              test_case_post_success = [
                {
                  response: { status_code: 500, error: service_error },
                  expect: { available_capacity: 5, retries: 1, delay: 1 }
                },
                {
                  response: { status_code: 200, error: nil },
                  expect: { available_capacity: 10, retries: 1 }
                }
              ]
              reset_request
              handle_with_retry(test_case_post_success)
            end
          end

          context 'adaptive mode' do
            before(:each) do
              config.retry_strategy = Retry::Adaptive.new
              client_rate_limiter.instance_variable_set(:@last_throttle_time, 5)
              # Needs to be smaller than 't' in the iterations
              client_rate_limiter.instance_variable_set(:@last_tx_rate_bucket, 4.5)
              client_rate_limiter.instance_variable_set(:@last_max_rate, 10)
            end

            it 'verifies cubic calculations for successes' do
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
              successes.each { |success| handle_with_retry([success]) }
            end

            it 'verifies success and throttling behavior' do
              client_rate_limiter.instance_variable_set(:@last_throttle_time, 0)
              # Needs to be smaller than 't' in the iterations
              client_rate_limiter.instance_variable_set(:@last_tx_rate_bucket, 0)
              client_rate_limiter.instance_variable_set(:@last_max_rate, 0)

              def success(timestamp, measured_tx_rate, fill_rate)
                [{
                  response: { status_code: 200, error: nil, timestamp: timestamp },
                  expect: { fill_rate: fill_rate, measured_tx_rate: measured_tx_rate }
                }]
              end

              def throttle(timestamp, measured_tx_rate, fill_rate)
                [{
                  response: { status_code: 429, error: service_error, timestamp: timestamp },
                  expect: { fill_rate: fill_rate, measured_tx_rate: measured_tx_rate }
                }]
              end

              handle_with_retry success(0.2, 0.0, 0.5)
              handle_with_retry success(0.4, 0.0, 0.5)
              handle_with_retry success(0.6, 4.8, 0.5)
              handle_with_retry success(0.8, 4.8, 0.5)
              handle_with_retry success(1.0, 4.16, 0.5)
              handle_with_retry success(1.2, 4.16, 0.69)
              handle_with_retry success(1.4, 4.16, 1.10)
              handle_with_retry success(1.6, 5.63, 1.63)
              handle_with_retry success(1.8, 5.63, 2.33)

              handle_with_retry throttle(2.0, 4.32, 3.02) +
                                success(2.2, 4.32, 3.48)

              handle_with_retry success(2.4, 4.32, 3.82)

              # the token bucket need additional capacity to fulfill this request
              client_rate_limiter.instance_variable_set(:@current_capacity, 10)
              handle_with_retry success(2.6, 5.66, 4.05)

              handle_with_retry success(2.8, 5.66, 4.20)
              handle_with_retry success(3.0, 4.33, 4.28)

              handle_with_retry throttle(3.2, 4.33, 2.99) +
                                success(3.4, 4.32, 3.45)
            end
          end
        end
      end
    end
  end
end
