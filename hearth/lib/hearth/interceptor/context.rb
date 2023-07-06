# frozen_string_literal: true

module Hearth
  module Interceptor
    # Context provided to interceptor hooks methods.
    class Context
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

      # Hearth::Output
      attr_reader :output

      # Hash[String,Object]
      attr_reader :attributes
    end
  end
end
