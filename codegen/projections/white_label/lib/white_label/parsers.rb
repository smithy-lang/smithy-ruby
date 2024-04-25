# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  # @api private
  module Parsers

    # Error Parser for ClientError
    class ClientError
      def self.parse(http_resp)
        data = Types::ClientError.new
        data
      end
    end

    class CustomAuth
      def self.parse(http_resp)
        data = Types::CustomAuthOutput.new
        data
      end
    end

    class DataplaneEndpoint
      def self.parse(http_resp)
        data = Types::DataplaneEndpointOutput.new
        data
      end
    end

    class DefaultsTest
      def self.parse(http_resp)
        data = Types::DefaultsTestOutput.new
        data
      end
    end

    class Endpoint
      def self.parse(http_resp)
        data = Types::EndpointOutput.new
        data
      end
    end

    class HostLabelEndpoint
      def self.parse(http_resp)
        data = Types::HostLabelEndpointOutput.new
        data
      end
    end

    class HttpApiKeyAuth
      def self.parse(http_resp)
        data = Types::HttpApiKeyAuthOutput.new
        data
      end
    end

    class HttpBasicAuth
      def self.parse(http_resp)
        data = Types::HttpBasicAuthOutput.new
        data
      end
    end

    class HttpBearerAuth
      def self.parse(http_resp)
        data = Types::HttpBearerAuthOutput.new
        data
      end
    end

    class HttpDigestAuth
      def self.parse(http_resp)
        data = Types::HttpDigestAuthOutput.new
        data
      end
    end

    class Items
    end

    class KitchenSink
      def self.parse(http_resp)
        data = Types::KitchenSinkOutput.new
        data
      end
    end

    class ListOfStrings
    end

    class ListOfStructs
    end

    class MapOfStrings
    end

    class MapOfStructs
    end

    class MixinTest
      def self.parse(http_resp)
        data = Types::MixinTestOutput.new
        data
      end
    end

    class NoAuth
      def self.parse(http_resp)
        data = Types::NoAuthOutput.new
        data
      end
    end

    class OptionalAuth
      def self.parse(http_resp)
        data = Types::OptionalAuthOutput.new
        data
      end
    end

    class OrderedAuth
      def self.parse(http_resp)
        data = Types::OrderedAuthOutput.new
        data
      end
    end

    class PaginatorsTest
      def self.parse(http_resp)
        data = Types::PaginatorsTestOperationOutput.new
        data
      end
    end

    class PaginatorsTestWithItems
      def self.parse(http_resp)
        data = Types::PaginatorsTestWithItemsOutput.new
        data
      end
    end

    class RelativeMiddleware
      def self.parse(http_resp)
        data = Types::RelativeMiddlewareOutput.new
        data
      end
    end

    class RequestCompression
      def self.parse(http_resp)
        data = Types::RequestCompressionOutput.new
        data
      end
    end

    class RequestCompressionStreaming
      def self.parse(http_resp)
        data = Types::RequestCompressionStreamingOutput.new
        data
      end
    end

    class ResourceEndpoint
      def self.parse(http_resp)
        data = Types::ResourceEndpointOutput.new
        data
      end
    end

    class ResultWrapper
    end

    # Error Parser for ServerError
    class ServerError
      def self.parse(http_resp)
        data = Types::ServerError.new
        data
      end
    end

    class Streaming
      def self.parse(http_resp)
        data = Types::StreamingOutput.new
        data.stream = http_resp.body
        data
      end
    end

    class StreamingWithLength
      def self.parse(http_resp)
        data = Types::StreamingWithLengthOutput.new
        data
      end
    end

    class Struct
    end

    class Union
    end

    class WaitersTest
      def self.parse(http_resp)
        data = Types::WaitersTestOutput.new
        data
      end
    end

    class Operation____PaginatorsTestWithBadNames
      def self.parse(http_resp)
        data = Types::Struct____PaginatorsTestWithBadNamesOutput.new
        data
      end
    end
  end
end
