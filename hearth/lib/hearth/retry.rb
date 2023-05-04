# frozen_string_literal: true

require_relative 'retry/retry_backoff_strategy'
require_relative 'retry/retry_quota'
require_relative 'retry/client_rate_limiter'
require_relative 'retry/standard_retry_strategy'
require_relative 'retry/adaptive_retry_strategy'

module Hearth
  module Retry
    RetryToken = Struct.new(:retry_count, :retry_delay, keyword_init: true)
  end
end
