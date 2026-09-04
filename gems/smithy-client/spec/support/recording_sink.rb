# frozen_string_literal: true

require 'timeout'

# A test sink that records the response lifecycle a transport pushes into it.
# Satisfies the sink side of the {Smithy::Client::Transport} contract
# (headers / data / done / error) and exposes the recorded values for
# assertions. Recorded-value readers use distinct names (received_*) so they do
# not collide with the sink methods themselves.
class RecordingSink
  def initialize
    @status = nil
    @received_headers = nil
    @chunks = []
    @terminal = nil
    @received_error = nil
  end

  attr_reader :status, :received_headers, :chunks, :terminal, :received_error

  # --- sink contract ---

  def headers(status_code, headers)
    @status = status_code
    @received_headers = headers
  end

  def data(chunk)
    @chunks << chunk
  end

  def done
    @terminal = :done
  end

  def error(error)
    @terminal = :error
    @received_error = error
  end

  # --- convenience accessors for assertions ---

  # @return [Hash, nil] the received response headers.
  def headers_hash
    @received_headers
  end

  # @return [StandardError, nil] the error passed to the error terminal.
  def error_value
    @received_error
  end

  # @return [String] the concatenated body chunks.
  def body
    @chunks.join
  end

  # Blocks until a terminal (#done or #error) has been recorded, for use with a
  # background exchange (transmit_background / drive_background) whose driving
  # thread pushes into this sink asynchronously. Raises Timeout::Error if no
  # terminal arrives within +timeout+ seconds so a hung exchange fails the
  # example instead of blocking the suite.
  # @param [Numeric] timeout Seconds to wait.
  # @return [Symbol] the terminal (+:done+ or +:error+).
  def wait_for_terminal(timeout: 5)
    Timeout.timeout(timeout) { sleep 0.01 until @terminal }
    @terminal
  end
end
