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
  subject = nil
  # this has to be @app
  app = proc do |input, context|
    apply_expectations(subject, test_cases[i - 1]) if i > 0

    # Setup the next response
    output = setup_next_response(context, test_cases[i])

    i += 1
    # the app needs to return the output
    output
  end

  subject = Hearth::Middleware::Retry.new(
    app,
    max_attempts: middleware_args[:max_attempts],
    retry_mode: middleware_args[:retry_mode],
    adaptive_retry_wait_to_fill: middleware_args[:adaptive_retry_wait_to_fill],
    error_inspector_class: Hearth::Retry::ErrorInspector
  )
  subject.call(input, context)



  expect(i).to(
    eq(test_cases.size),
    "Wrong number of retries. Handler was called #{i} times "\
    "but #{test_cases.size} test cases were defined."
  )

  # Handle has finished called.  Apply final expectations.
  apply_expectations(subject, test_cases[i - 1])
end

def apply_expectations(retry_middleware, test_case)
  expected = test_case[:expect]
  retry_quota = retry_middleware.instance_variable_get(:@retry_quota)

  # if expected[:delay]
  #   expect(Kernel).to receive(:sleep).with(expected[:delay])
  # end

  if expected[:available_capacity]
    expect(
      retry_quota.instance_variable_get(
        :@available_capacity
      )
    ).to eq(expected[:available_capacity])
  end

  if expected[:retries]
    expect(retry_middleware.instance_variable_get(:@retries)).to eq(expected[:retries])
  end

  if expected[:calculated_rate]
    expect(
      retry_middleware.instance_variable_get(:@client_rate_limiter).instance_variable_get(
        :@calculated_rate
      )
    ).to be_within(0.2).of(expected[:calculated_rate])
  end
  if expected[:measured_tx_rate]
    expect(
      retry_middleware.instance_variable_get(:@client_rate_limiter).instance_variable_get(
        :@measured_tx_rate
      )
    ).to be_within(0.1).of(expected[:measured_tx_rate])
  end
  if expected[:fill_rate]
    expect(
      retry_middleware.instance_variable_get(:@client_rate_limiter).instance_variable_get(
        :@fill_rate
      )
    ).to be_within(0.1).of(expected[:fill_rate])
  end
end

def setup_next_response(context, test_case)
  response = test_case[:response]
  if response[:timestamp]
    Allow(Process).to receive(:clock_gettime)
                        .with(Process::CLOCK_MONOTONIC).and_return(response[:timestamp])
  end
  context.response.status = response[:status_code]
  Hearth::Output.new(error: response[:error])
end


module Hearth
  module Middleware
    # class RetryTest
    #   def initialize(test_cases)
    #     @test_cases = test_cases
    #     @i = 0
    #   end
    #
    #   attr_reader :i
    #
    #   attr_accessor :retry_middleware
    #
    #   def call(_input, context)
    #     apply_expectations(@test_cases[@i - 1]) if @i > 0
    #
    #     # Setup the next response
    #     output = setup_next_response(context, @test_cases[@i])
    #
    #     @i += 1
    #
    #     # return the output
    #     output
    #   end
    #
    #   private
    #
    #   def apply_expectations(test_case)
    #     expected = test_case[:expect]
    #
    #     if expected[:delay]
    #       expect(Kernel).to receive(:sleep).with(expected[:delay])
    #     end
    #
    #     if expected[:available_capacity]
    #       expect(
    #         @retry_quota.instance_variable_get(
    #           :@available_capacity
    #         )
    #       ).to eq(expected[:available_capacity])
    #     end
    #
    #     if expected[:retries]
    #       expect(retry_middleware.instance_variable_get(:@retries)).to eq(expected[:retries])
    #     end
    #
    #     if expected[:calculated_rate]
    #       expect(
    #         retry_middleware.instance_variable_get(:@client_rate_limiter).instance_variable_get(
    #           :@calculated_rate
    #         )
    #       ).to be_within(0.2).of(expected[:calculated_rate])
    #     end
    #     if expected[:measured_tx_rate]
    #       expect(
    #         retry_middleware.instance_variable_get(:@client_rate_limiter).instance_variable_get(
    #           :@measured_tx_rate
    #         )
    #       ).to be_within(0.1).of(expected[:measured_tx_rate])
    #     end
    #     if expected[:fill_rate]
    #       expect(
    #         retry_middleware.instance_variable_get(:@client_rate_limiter).instance_variable_get(
    #           :@fill_rate
    #         )
    #       ).to be_within(0.1).of(expected[:fill_rate])
    #     end
    #   end
    #
    #   def setup_next_response(context, test_case)
    #     response = test_case[:response]
    #     if response[:timestamp]
    #       Allow(Process).to receive(:clock_gettime)
    #         .with(Process::CLOCK_MONOTONIC).and_return(response[:timestamp])
    #     end
    #     context.response.status = response[:status_code]
    #     Hearth::Output.new(error: response[:error])
    #   end
    # end

    describe Retry do
      # let(:app) { double('app', call: output) }

      let(:max_attempts) { 4 }
      let(:adaptive_retry_wait_to_fill) { true }

      let(:input) { double('Type::OperationInput') }
      let(:error) do
        Hearth::ApiError.new(
          error_code: 'error_code',
          metadata: {}
        )
      end
      let(:request) { Hearth::HTTP::Request.new }
      let(:response) { Hearth::HTTP::Response.new }
      let(:context) do
        Hearth::Context.new(
          request: request,
          response: response
        )
      end

      context 'standard mode' do
        let(:retry_mode) { 'standard' }
        let(:middleware_args) do
          {
            max_attempts: max_attempts,
            retry_mode: retry_mode,
            adaptive_retry_wait_to_fill: adaptive_retry_wait_to_fill
          }
        end

        before(:each) do
          allow(Kernel).to receive(:rand).and_return(1)
        end

        it 'retry eventually succeeds' do
          test_case_def = [
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

          handle_with_retry(
            test_case_def,
            middleware_args
          )
        end

        it 'fails due to max attempts reached' do
          test_case_def = [
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

          handle_with_retry(
            test_case_def,
            middleware_args.merge(max_attempts: 3)
          )
        end

        it 'fails due to retry quota reached after a single retry' do
          subject.instance_variable_get(:@retry_quota)
                 .instance_variable_set(:@available_capacity, 5)
          # config.retry_quota.instance_variable_set(:@available_capacity, 5)

          test_case_def = [
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 0, retries: 1, delay: 1 }
            },
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 0, retries: 1 }
            }
          ]

          handle_with_retry(test_case_def)
        end

        it 'does not retry if the retry quota is 0' do
          config.retry_quota.instance_variable_set(:@available_capacity, 0)

          test_case_def = [
            {
              response: { status_code: 500, error: error },
              expect: { available_capacity: 0, retries: 0 }
            }
          ]

          handle_with_retry(test_case_def)
        end

        it 'uses exponential backoff timing' do
          config.max_attempts = 5

          test_case_def = [
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

          handle_with_retry(test_case_def)
        end

        it 'does not exceed the max backoff time' do
          config.max_attempts = 5
          stub_const('Aws::Plugins::RetryErrors::Handler::MAX_BACKOFF', 3)

          test_case_def = [
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

          handle_with_retry(test_case_def)
        end
      end

      context 'adaptive mode' do
        before(:each) do
          config.retry_mode = 'adaptive'

          client_rate_limiter = config.client_rate_limiter
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
          client_rate_limiter = config.client_rate_limiter
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


# module Hearth
#   module Middleware
#     describe Retry do
#       let(:app) { double('app', call: output) }
#       let(:max_attempts) { 4 }
#       let(:max_delay) { 10 }
#
#       subject do
#         Retry.new(
#           app,
#           max_attempts: max_attempts,
#           max_delay: max_delay
#         )
#       end
#
#       describe '#call' do
#         let(:input) { double('Type::OperationInput') }
#         let(:output) { double('output', error: error) }
#         let(:error) { nil }
#         let(:request) { Hearth::HTTP::Request.new }
#         let(:response) { Hearth::HTTP::Response.new }
#         let(:context) do
#           Hearth::Context.new(
#             request: request,
#             response: response
#           )
#         end
#
#         it 'calls the next middleware' do
#           expect(app).to receive(:call)
#             .with(input, context).and_return(output)
#
#           subject.call(input, context)
#         end
#
#         context 'middleware raises NetworkingError' do
#           let(:error) { Hearth::HTTP::NetworkingError.new(StandardError.new) }
#
#           it 'retries with exponential backoff and jitter' do
#             expect(app).to receive(:call).with(
#               input, context
#             ).and_raise(error).exactly(4).times
#             allow(Kernel).to receive(:rand).and_return(1)
#             expect(Kernel).to receive(:sleep).with(1)
#             expect(Kernel).to receive(:sleep).with(2)
#             expect(Kernel).to receive(:sleep).with(4)
#
#             expect do
#               subject.call(input, context)
#             end.to raise_error(error)
#           end
#
#           it 'retries up to max_attempts times' do
#             expect(app).to receive(:call).with(
#               input, context
#             ).and_raise(error).exactly(4).times
#             allow(Kernel).to receive(:sleep)
#
#             expect do
#               subject.call(input, context)
#             end.to raise_error(error)
#           end
#
#           context 'max_delay' do
#             let(:max_delay) { 1 }
#
#             it 'backoff is bounded by max_delay' do
#               expect(app).to receive(:call).with(
#                 input, context
#               ).and_raise(error).exactly(4).times
#               allow(Kernel).to receive(:rand).and_return(1)
#               expect(Kernel).to receive(:sleep).with(1).exactly(3).times
#
#               expect do
#                 subject.call(input, context)
#               end.to raise_error(error)
#             end
#           end
#         end
#
#         context 'middleware returns output with ApiError' do
#           let(:error) do
#             Hearth::ApiError.new(
#               error_code: 'error_code',
#               metadata: {}
#             )
#           end
#
#           context 'error is not retryable' do
#             it 'returns output' do
#               expect(app).to receive(:call)
#                 .with(input, context).and_return(output)
#
#               resp = subject.call(input, context)
#               expect(resp).to eq(output)
#             end
#           end
#
#           context 'error is retryable' do
#             before do
#               allow(error).to receive(:retryable?).and_return(true)
#             end
#
#             it 'retries up to max_attempts times' do
#               expect(app).to receive(:call).with(
#                 input, context
#               ).and_return(output).exactly(4).times
#               allow(Kernel).to receive(:sleep)
#
#               resp = subject.call(input, context)
#               expect(resp).to eq(output)
#             end
#
#             it 'retries with exponential backoff and jitter' do
#               expect(app).to receive(:call).with(
#                 input, context
#               ).and_return(output).exactly(4).times
#               allow(Kernel).to receive(:rand).and_return(1)
#               expect(Kernel).to receive(:sleep).with(1)
#               expect(Kernel).to receive(:sleep).with(2)
#               expect(Kernel).to receive(:sleep).with(4)
#
#               resp = subject.call(input, context)
#               expect(resp).to eq(output)
#             end
#
#             context 'max_delay' do
#               let(:max_delay) { 1 }
#
#               it 'backoff is bounded by max_delay' do
#                 expect(app).to receive(:call).with(
#                   input, context
#                 ).and_return(output).exactly(4).times
#                 allow(Kernel).to receive(:rand).and_return(1)
#                 expect(Kernel).to receive(:sleep).with(1).exactly(3).times
#
#                 resp = subject.call(input, context)
#                 expect(resp).to eq(output)
#               end
#             end
#           end
#         end
#       end
#     end
#   end
# end