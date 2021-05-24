# frozen_string_literal: true

module Seahorse
  class Context

    def initialize(options = {})
      @operation_name = options[:operation_name]
      @request = options[:request]
      @response = options[:response]
      @logger = options[:logger]
      @params = options[:params]
      @metadata = options[:metadata] || {}
    end

    # @return [Symbol] Name of the API operation called.
    attr_reader :operation_name

    # @return [Seahorse::HTTP::Request]
    attr_reader :request

    # @return [Seahorse::HTTP::Response]
    attr_reader :response

    # @return [Logger] An instance of the logger configured for the Client.
    attr_reader :logger

    # @return [Hash] The hash of the original request parameters.
    attr_accessor :params

    # @return [Hash]
    attr_reader :metadata

  end
end
