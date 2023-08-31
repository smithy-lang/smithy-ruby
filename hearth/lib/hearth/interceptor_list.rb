# frozen_string_literal: true

module Hearth
  # A list of {Interceptor}s.
  class InterceptorList
    include Enumerable

    # @param [Array<Interceptor>] interceptors ([])
    def initialize(interceptors = [])
      @interceptors = []
      interceptors.each { |i| append(i) }
    end

    # @param [Interceptor] interceptor
    def append(interceptor)
      unless interceptor.is_a?(Interceptor)
        raise ArgumentError, "Expected #{interceptor} to be an Interceptor"
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

    def dup
      InterceptorList.new(self)
    end

    def each(&block)
      @interceptors.each(&block)
    end
  end
end
