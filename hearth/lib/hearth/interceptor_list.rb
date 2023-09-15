# frozen_string_literal: true

module Hearth
  # A list of {Hearth::Interceptor}s or classes that respond to Interceptor
  # hook methods.
  class InterceptorList
    include Enumerable

    # @param [Array<Interceptor>] interceptors ([])
    def initialize(interceptors = [])
      unless interceptors.respond_to?(:each)
        raise ArgumentError, 'Interceptors must be an enumerable'
      end

      @interceptors = []
      interceptors.each { |i| append(i) }
    end

    # @param [Interceptor] interceptor
    def append(interceptor)
      unless valid_interceptor?(interceptor)
        raise ArgumentError,
              'Invalid interceptor - must respond to any of: ' \
              "#{Interceptor.hooks.join(', ')}"
      end

      @interceptors << interceptor
    end
    alias << append

    # @param [InterceptorList] other
    # @return [InterceptorList] self
    def concat(other)
      other.each { |i| append(i) }
      self
    end

    def each(&block)
      @interceptors.each(&block)
    end

    private

    def valid_interceptor?(interceptor)
      !(interceptor.methods & Interceptor.hooks).empty?
    end
  end
end
