# frozen_string_literal: true

# Sets up the handler to run retry tests by calling either the send_handler or passed block.
# `subject` and `output` must be defined outside this helper
def handle(send_handler = nil, &block)
  allow(Kernel).to receive(:sleep)
  subject.handler = send_handler || block
  subject.call(output.context)
end

# A helper method to test Standard and Adaptive tests
# Expects a test case defined as a Hash with response and expect keys.
# response: Hash with status_code and error
# expect: delay, available_capacity, retries, calculated_rate, measured_tx_rate, fill_rate
def handle_with_retry(test_cases)
  i = 0
  handle do |_context|
    apply_delay(test_cases[i])
    apply_expectations(test_cases[i - 1]) if i.positive?

    setup_next_response(test_cases[i])

    i += 1
    output
  end

  expect(i).to(
    eq(test_cases.size),
    "Wrong number of retries. Handler was called #{i} times but " \
    "#{test_cases.size} test cases were defined."
  )

  apply_expectations(test_cases[i - 1])
end

# Reset the request context for a subsequent call
def reset_request
  output.context.retries = 0
end

# apply a delay to the current test case
# See handle_with_retry for test case definition
def apply_delay(test_case)
  expected = test_case[:expect]
  return unless expected[:delay]

  expect(Kernel).to receive(:sleep).with(expected[:delay])
end

# apply the expectations from a previous test case
# See handle_with_retry for test case definition
def apply_expectations(test_case)
  expected = test_case[:expect]
  if expected[:available_capacity]
    expect(quota.instance_variable_get(:@available_capacity))
      .to eq(expected[:available_capacity])
  end

  expect(output.context.retries).to eq(expected[:retries]) if expected[:retries]

  if expected[:calculated_rate]
    expect(client_rate_limiter.instance_variable_get(:@calculated_rate))
      .to be_within(0.2).of(expected[:calculated_rate])
  end
  if expected[:measured_tx_rate]
    expect(client_rate_limiter.instance_variable_get(:@measured_tx_rate))
      .to be_within(0.1).of(expected[:measured_tx_rate])
  end
  return unless expected[:fill_rate]

  expect(client_rate_limiter.instance_variable_get(:@fill_rate))
    .to be_within(0.1).of(expected[:fill_rate])
end

# See handle_with_retry for test case definition
def setup_next_response(test_case)
  response = test_case[:response]
  output.context.http_response.status_code = response[:status_code]
  output.error = response[:error]

  allow(Process).to receive(:clock_gettime).and_return(response[:timestamp]) if response[:timestamp]
end
