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

    def dup
      InterceptorList.new(self)
    end

    def each(&block)
      @interceptors.each(&block)
    end

    private

    def valid_interceptor?(interceptor)
      Interceptor::Hooks.implements_interceptor?(interceptor)
    end
  end
end
