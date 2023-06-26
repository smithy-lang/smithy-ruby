# frozen_string_literal: true

module Hearth
  module Retry
    # Interface for retry strategies.
    class Strategy
      def acquire_initial_retry_token(_token_scope = nil)
        raise NotImplementedError
      end

      def refresh_retry_token(_retry_token, _error_info)
        raise NotImplementedError
      end

      def record_success(_retry_token)
        raise NotImplementedError
      end
    end
  end
end
