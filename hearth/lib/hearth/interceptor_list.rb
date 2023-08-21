# frozen_string_literal: true

module Hearth
  # A list of Interceptors.
  class InterceptorList
    include Enumerable

    # Initialize an InterceptorList.
    #
    # @param [Array] interceptors ([]) A list of interceptors.
    def initialize(interceptors = [])
      unless interceptors.respond_to?(:each)
        raise ArgumentError, 'Interceptors must be an enumerable'
      end

      @interceptors = []
      interceptors.each { |i| add(i) }
    end

    # Add an interceptor.
    #
    # @param [Object] interceptor
    def add(interceptor)
      if interceptor.respond_to?(:each)
        interceptor.each { |i| add(i) }
      else
        unless valid_interceptor?(interceptor)
          raise ArgumentError,
                'Invalid Interceptor - must implement at least one hook method.'
        end

        @interceptors << interceptor
      end
    end

    alias << add

    # Apply all interceptors that implement the given hook
    # @param [Symbol] hook the specific hook to apply for
    # @param input operation input
    # @param [Hearth::Context] context
    # @param [Hearth::Output] output may be nil if unavailable
    # @param [Boolean] aggregate_errors if true all interceptors are run and
    #   only the last error is returned.  If false, returns immediately if an
    #   error is encountered.
    # @return nil if successful, an exception otherwise
    def apply(hook:, input:, context:, output:, aggregate_errors: false)
      ictx = context.interceptor_context(input, output)
      last_error = nil
      @interceptors.each do |i|
        next unless i.respond_to?(hook)

        begin
          i.send(hook, ictx)
        rescue StandardError => e
          context.logger.error(last_error) if last_error
          last_error = e
          break unless aggregate_errors
        end
      end

      set_output_error(last_error, context, output)

      last_error
    end

    def dup
      InterceptorList.new(self)
    end

    def each(&block)
      @interceptors.each(&block)
    end

    private

    def set_output_error(last_error, context, output)
      return unless last_error && output

      context.logger.error(output.error) if output.error
      output.error = last_error
    end

    def valid_interceptor?(interceptor)
      Interceptor::Hooks.implements_interceptor?(interceptor)
    end
  end
end
