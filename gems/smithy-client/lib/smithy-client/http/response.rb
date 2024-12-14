# frozen_string_literal: true

module Smithy
  module Client
    module HTTP
      # Represents an HTTP Response.
      class Response < Client::Response
        # @param (see Smithy::Client::Response#initialize)
        def initialize(options = {})
          @status = options[:status] || 0
          @fields = options[:fields] || Fields.new
          @headers = Fields::Proxy.new(@fields, :header)
          @trailers = Fields::Proxy.new(@fields, :trailer)
          super
        end

        # @return [Integer]
        attr_accessor :status

        # @return [Fields]
        attr_reader :fields

        # @return [Fields::Proxy]
        attr_reader :headers

        # @return [Fields::Proxy]
        attr_reader :trailers

        # Resets the HTTP response.
        # @return [Client::Response]
        def reset
          @status = 0
          @fields.clear
          super
        end
      end
    end
  end
end
