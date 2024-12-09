# frozen_string_literal: true

module Smithy
  module Client
    module HTTP
      # Represents an HTTP request.
      class Request < Client::Request
        # @option options [String] :http_method ('GET')
        # @option options [Fields] :fields (Fields.new)
        # @param (see Smithy::Client::Request#initialize)
        def initialize(options = {})
          @http_method = options[:http_method] || 'GET'
          @fields = options[:fields] || Fields.new
          @headers = Fields::Proxy.new(@fields, :header)
          @trailers = Fields::Proxy.new(@fields, :trailer)
          super
        end

        # @return [String]
        attr_accessor :http_method

        # @return [Fields]
        attr_reader :fields

        # @return [Fields::Proxy]
        attr_reader :headers

        # @return [Fields::Proxy]
        attr_reader :trailers
      end
    end
  end
end
