# frozen_string_literal: true

module Hearth
  # Context provided to interceptor hook methods. Interceptors can use this
  # context to read and modify the input, request, response, and output.
  # Attributes can be used to pass additional data between interceptors.
  class InterceptorContext
    # @param [Structure] input
    # @param [Request] request
    # @param [Response] response
    # @param [Output] output
    # @param [Configuration] config
    def initialize(input:, request:, response:, output:, config:, tracer:)
      @input = input
      @request = request
      @response = response
      @output = output
      @config = config
      @tracer = tracer
      @attributes = {}
    end

    # @return [Struct] Modeled input, i.e. Types::<Operation>Input
    attr_reader :input

    # @return [Request]
    attr_reader :request

    # @return [Response]
    attr_reader :response

    # @return [Output] Operation output
    attr_reader :output

    # @return [Configuration] config
    attr_reader :config

    # @return [Tracer] tracer
    attr_reader :tracer

    # @return [Hash] attributes Additional interceptor data
    attr_reader :attributes
  end
end
