# frozen_string_literal: true

module Smithy
  module Client
    module HTTP
      # Represents an HTTP Response.
      class Response < Client::Response
        # @param (see Smithy::Client::Response#initialize)
        # @option options [Integer] :status_code (0)
        # @option options [Fields] :fields (Fields.new)
        def initialize(options = {})
          @status_code = options[:status_code] || 0
          @fields = options[:fields] || Fields.new
          @headers = Fields::Proxy.new(@fields, :header)
          @trailers = Fields::Proxy.new(@fields, :trailer)
          super
        end

        # @return [Integer]
        attr_accessor :status_code

        # @return [Fields]
        attr_reader :fields

        # @return [Fields::Proxy]
        attr_reader :headers

        # @return [Fields::Proxy]
        attr_reader :trailers

        # Resets the HTTP response.
        # @return [Client::Response]
        def reset
          @status_code = 0
          @fields.clear
          super
        end
      end
    end
  end
end
