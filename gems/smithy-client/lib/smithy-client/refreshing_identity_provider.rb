# frozen_string_literal: true

module Smithy
  module Client
    # A module that can be included in a class to provide a #identity method.
    # The class must implement #refresh that sets @identity. The refresh
    # method will be called when #identity is called and the identity
    # is nil or near expiration.
    module RefreshingIdentityProvider
      SYNC_EXPIRATION_LENGTH = 300 # 5 minutes
      ASYNC_EXPIRATION_LENGTH = 600 # 10 minutes

      CLIENT_EXCLUDE_OPTIONS = Set.new([:before_refresh]).freeze

      # @param [Hash] options
      # @option options [Proc] :before_refresh A Proc called before credentials are refreshed.
      #   It accepts `self` as the only argument.
      def initialize(options = {})
        @mutex = Mutex.new
        @before_refresh = options.delete(:before_refresh) if options.is_a?(Hash)

        @before_refresh&.call(self)
        refresh
      end

      # @return [Identity]
      def identity
        refresh_if_near_expiration!
        @identity
      end

      # Refresh credentials.
      # @return [void]
      def refresh!
        @mutex.synchronize do
          @before_refresh&.call(self)

          refresh
        end
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
      def refresh_if_near_expiration!
        # NOTE: This check is an optimization. Rather than acquire the mutex on
        # every #refresh_if_near_expiration call, we check before doing so, and
        # then we check within the mutex to avoid a race condition.
        if near_expiration?(sync_expiration_length)
          sync_refresh
        elsif @async_refresh && near_expiration?(async_expiration_length)
          async_refresh
        end
      end

      def sync_refresh
        @mutex.synchronize do
          if near_expiration?(sync_expiration_length)
            @before_refresh&.call(self)
            refresh
          end
        end
      end

      def async_refresh
        return if @mutex.locked?

        Thread.new do
          @mutex.synchronize do
            if near_expiration?(async_expiration_length)
              @before_refresh&.call(self)
              refresh
            end
          end
        end
      end

      def near_expiration?(expiration_length)
        return false unless @expiration

        Time.now + expiration_length > @expiration
      end
    end
  end
end
