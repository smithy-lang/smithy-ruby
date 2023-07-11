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

    # Params object, eg Params::<Operation>Input
    attr_reader :input

    # Hearth::Request (eg HTTPRequest)
    attr_reader :request

    # Hearth::Response (eg HTTPResponse)
    attr_reader :response

    # Hearth::Output output modeled output,
    # only available to hooks after transmit
    attr_reader :output

    # Hash[String,Object] attributes additional interceptor data
    attr_reader :attributes
  end
end
