# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
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

    # Operation Parser for DefaultsTest
    class DefaultsTest
      def self.parse(http_resp)
        data = Types::DefaultsTestOutput.new
        data
      end
    end

    # Operation Parser for EndpointOperation
    class EndpointOperation
      def self.parse(http_resp)
        data = Types::EndpointOperationOutput.new
        data
      end
    end

    # Operation Parser for EndpointWithHostLabelOperation
    class EndpointWithHostLabelOperation
      def self.parse(http_resp)
        data = Types::EndpointWithHostLabelOperationOutput.new
        data
      end
    end

    # Operation Parser for HttpApiKeyAuth
    class HttpApiKeyAuth
      def self.parse(http_resp)
        data = Types::HttpApiKeyAuthOutput.new
        data
      end
    end

    # Operation Parser for HttpBasicAuth
    class HttpBasicAuth
      def self.parse(http_resp)
        data = Types::HttpBasicAuthOutput.new
        data
      end
    end

    # Operation Parser for HttpBearerAuth
    class HttpBearerAuth
      def self.parse(http_resp)
        data = Types::HttpBearerAuthOutput.new
        data
      end
    end

    # Operation Parser for HttpDigestAuth
    class HttpDigestAuth
      def self.parse(http_resp)
        data = Types::HttpDigestAuthOutput.new
        data
      end
    end

    class Items
    end

    # Operation Parser for KitchenSink
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

    # Operation Parser for MixinTest
    class MixinTest
      def self.parse(http_resp)
        data = Types::MixinTestOutput.new
        data
      end
    end

    # Operation Parser for NoAuth
    class NoAuth
      def self.parse(http_resp)
        data = Types::NoAuthOutput.new
        data
      end
    end

    # Operation Parser for OptionalAuth
    class OptionalAuth
      def self.parse(http_resp)
        data = Types::OptionalAuthOutput.new
        data
      end
    end

    # Operation Parser for OrderedAuth
    class OrderedAuth
      def self.parse(http_resp)
        data = Types::OrderedAuthOutput.new
        data
      end
    end

    # Operation Parser for PaginatorsTest
    class PaginatorsTest
      def self.parse(http_resp)
        data = Types::PaginatorsTestOperationOutput.new
        data
      end
    end

    # Operation Parser for PaginatorsTestWithItems
    class PaginatorsTestWithItems
      def self.parse(http_resp)
        data = Types::PaginatorsTestWithItemsOutput.new
        data
      end
    end

    # Operation Parser for RelativeMiddlewareOperation
    class RelativeMiddlewareOperation
      def self.parse(http_resp)
        data = Types::RelativeMiddlewareOperationOutput.new
        data
      end
    end

    # Operation Parser for RequestCompressionOperation
    class RequestCompressionOperation
      def self.parse(http_resp)
        data = Types::RequestCompressionOperationOutput.new
        data
      end
    end

    # Operation Parser for RequestCompressionStreamingOperation
    class RequestCompressionStreamingOperation
      def self.parse(http_resp)
        data = Types::RequestCompressionStreamingOperationOutput.new
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

    # Operation Parser for StreamingOperation
    class StreamingOperation
      def self.parse(http_resp)
        data = Types::StreamingOperationOutput.new
        data.stream = http_resp.body
        data
      end
    end

    # Operation Parser for StreamingWithLength
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

    # Operation Parser for WaitersTest
    class WaitersTest
      def self.parse(http_resp)
        data = Types::WaitersTestOutput.new
        data
      end
    end

    # Operation Parser for __PaginatorsTestWithBadNames
    class Operation____PaginatorsTestWithBadNames
      def self.parse(http_resp)
        data = Types::Struct____PaginatorsTestWithBadNamesOutput.new
        data
      end
    end
  end
end
