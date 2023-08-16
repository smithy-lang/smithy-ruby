# frozen_string_literal: true

module Hearth
  # Resolves an identity from identity properties.
  module RefreshingIdentity
    SYNC_EXPIRATION_LENGTH = 300 # 5 minutes
    ASYNC_EXPIRATION_LENGTH = 600 # 10 minutes

    def initialize
      @mutex = Mutex.new
    end

    # @return [Identity]
    def identity(properties = {})
      refresh_if_near_expiration!(properties)
      @identity
    end

    private

    def sync_expiration_length
      self.class::SYNC_EXPIRATION_LENGTH
    end

    def async_expiration_length
      self.class::ASYNC_EXPIRATION_LENGTH
    end

    # Refreshes identity asynchronously and synchronously.
    # If we are near to expiration, block while refreshing the identity.
    # Otherwise, if we're approaching expiration, use the existing identity
    # but attempt a refresh in the background.
    def refresh_if_near_expiration!(properties)
      # NOTE: This check is an optimization. Rather than acquire the mutex on
      # every #refresh_if_near_expiration call, we check before doing so, and
      # then we check within the mutex to avoid a race condition.
      if near_expiration?(sync_expiration_length)
        @mutex.synchronize do
          refresh(properties) if near_expiration?(sync_expiration_length)
        end
      elsif @async_refresh && near_expiration?(async_expiration_length)
        unless @mutex.locked?
          Thread.new do
            @mutex.synchronize do
              refresh(properties) if near_expiration?(async_expiration_length)
            end
          end
        end
      end
    end

    def near_expiration?(expiration_length)
      if (expiration = @identity.expiration)
        # Are we within expiration?
        (Time.now.to_i + expiration_length) > expiration.to_i
      else
        true
      end
    end
  end
end