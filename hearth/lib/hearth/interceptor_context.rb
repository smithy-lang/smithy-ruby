# frozen_string_literal: true

module Hearth
  # Context provided to interceptor hook methods. Interceptors can use this
  # context to read and modify the input, request, response, and output.
  # Attributes can be used to pass additional data between interceptors.
  class InterceptorContext
    # @param [Hearth::Structure] input
    # @param [Hearth::Request] request
    # @param [Hearth::Response] response
    # @param [Hearth::Output] output
    # @param [Logger] logger
    def initialize(input:, request:, response:, output:, logger:)
      @input = input
      @request = request
      @response = response
      @output = output
      @logger = logger
      @attributes = {}
    end

    # @return [Struct] Modeled input, i.e. Types::<Operation>Input
    attr_reader :input

    # @return [Hearth::Request]
    attr_reader :request

    # @return [Hearth::Response]
    attr_reader :response

    # @return [Hearth::Output] Operation output
    attr_reader :output

    # @return [Logger] logger
    attr_reader :logger

    # @return [Hash] attributes Additional interceptor data
    attr_reader :attributes
  end
end
