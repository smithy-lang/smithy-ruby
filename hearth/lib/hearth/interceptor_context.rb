# frozen_string_literal: true

module Hearth
  # Context provided to interceptor hook methods.
  class InterceptorContext
    # @param input modeled input
    # @param [Hearth::Request] request
    # @param [Hearth::Response] response
    # @param [Hearth::Output]
    # @param [Hash] attributes additional interceptor data
    def initialize(input:, request:,
                   response:, output:, attributes: {})
      @input = input
      @request = request
      @response = response
      @output = output
      @attributes = attributes
    end

    # @return Params object, eg Params::<Operation>Input
    attr_reader :input

    # @return [Hearth::Request]
    attr_reader :request

    # @return [Hearth::Response]
    attr_reader :response

    # @return [Hearth::Output] only available to hooks after transmit
    attr_reader :output

    # @return [Hash] attributes additional interceptor data
    attr_reader :attributes
  end
end
