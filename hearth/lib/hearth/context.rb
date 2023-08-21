# frozen_string_literal: true

module Hearth
  # Stores request and response objects, and other useful things used by
  # multiple Middleware.
  # @api private
  class Context
    def initialize(options = {})
      @operation_name = options[:operation_name]
      @request = options[:request]
      @response = options[:response]
      @logger = options[:logger]
      @params = options[:params]
      @metadata = options[:metadata] || {}
      @interceptors = options[:interceptors] || InterceptorList.new
      @interceptor_attributes = {}
    end

    # @return [Symbol] Name of the API operation called.
    attr_reader :operation_name

    # @return [Hearth::HTTP::Request]
    attr_reader :request

    # @return [Hearth::HTTP::Response]
    attr_reader :response

    # @return [Logger] An instance of the logger configured for the Client.
    attr_reader :logger

    # @return [Hash] The hash of the original request parameters.
    attr_reader :params

    # @return [Hash]
    attr_reader :metadata

    # @return [Array] An ordered list of interceptors
    attr_reader :interceptors

    # @return [SelectedAuthScheme, nil] The auth scheme for the request.
    attr_accessor :auth_scheme

    # @api private
    def interceptor_context(input, output)
      Hearth::Interceptor::Context.new(
        input: input,
        request: request,
        response: response,
        output: output,
        attributes: @interceptor_attributes
      )
    end
  end
end
