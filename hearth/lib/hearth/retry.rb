# frozen_string_literal: true

require_relative 'retry/strategy'

require_relative 'retry/adaptive'
require_relative 'retry/client_rate_limiter'
require_relative 'retry/exponential_backoff'
require_relative 'retry/retry_quota'
require_relative 'retry/standard'

module Hearth
  module Retry
    Token = Struct.new(:retry_count, :retry_delay, keyword_init: true)
  end
end
