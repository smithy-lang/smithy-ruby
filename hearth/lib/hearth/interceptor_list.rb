# frozen_string_literal: true

module Hearth
  # A list of Interceptors.
  class InterceptorList
    include Enumerable

    # Initialize an InterceptorList.
    #
    # @param [Array] ([]) interceptors A list of interceptors
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
      if interceptor.is_a?(InterceptorList)
        interceptor.each { |i| add(i) }
      else
        unless valid_interceptor?(interceptor)
          raise ArgumentError,
                'Invalid Interceptor'
        end

        @interceptors << interceptor
      end
    end

    alias << add

    # TODO: Documentation
    # if an exception is thrown AND output is not nil,
    # the output will be modified to include the error
    # @return nil if successful, an exception otherwise
    def apply(hook:, input:, context:, output:, aggregate_errors: false)
      ictx = context.interceptor_context(input, output)
      last_error = nil
      @interceptors.each do |i|
        next unless i.respond_to?(hook)

        begin
          i.send(hook, ictx)
        rescue StandardError => e
          context.logger.error(e) if last_error
          last_error = e
          break unless aggregate_errors
        end
      end

      set_output_error(last_error, output)

      last_error
    end

    def dup
      InterceptorList.new(self)
    end

    def each(&block)
      @interceptors.each(&block)
    end

    private

    def set_output_error(last_error, output)
      return unless last_error && output

      output.data = nil
      output.error = last_error
    end

    # TODO: What makes a valid interceptor? Options:
    # 1. Check for responds_to for all known hooks
    # 2. Require all interceptors to include an Interceptor module
    #   (but currently there is not shared behavior)
    def valid_interceptor?(_interceptor)
      true # TODO
    end
  end
end
