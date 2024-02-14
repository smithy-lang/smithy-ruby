# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  # @api private
  module Builders

    class CustomAuth
      def self.build(http_req, input:)
      end
    end

    class DataplaneOperation
      def self.build(http_req, input:)
      end
    end

    class DefaultsTest
      def self.build(http_req, input:)
      end
    end

    class EndpointOperation
      def self.build(http_req, input:)
      end
    end

    class EndpointOperationWithResource
      def self.build(http_req, input:)
      end
    end

    class EndpointWithHostLabelOperation
      def self.build(http_req, input:)
      end
    end

    class HttpApiKeyAuth
      def self.build(http_req, input:)
      end
    end

    class HttpBasicAuth
      def self.build(http_req, input:)
      end
    end

    class HttpBearerAuth
      def self.build(http_req, input:)
      end
    end

    class HttpDigestAuth
      def self.build(http_req, input:)
      end
    end

    class KitchenSink
      def self.build(http_req, input:)
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
      def self.build(http_req, input:)
      end
    end

    class NoAuth
      def self.build(http_req, input:)
      end
    end

    class OptionalAuth
      def self.build(http_req, input:)
      end
    end

    class OrderedAuth
      def self.build(http_req, input:)
      end
    end

    class PaginatorsTest
      def self.build(http_req, input:)
      end
    end

    class PaginatorsTestWithItems
      def self.build(http_req, input:)
      end
    end

    class RelativeMiddlewareOperation
      def self.build(http_req, input:)
      end
    end

    class RequestCompressionOperation
      def self.build(http_req, input:)
        http_req.body = StringIO.new(input[:body] || '')
      end
    end

    class RequestCompressionStreamingOperation
      def self.build(http_req, input:)
        http_req.body = input[:body]
        http_req.headers['Transfer-Encoding'] = 'chunked'
        http_req.headers['Content-Type'] = 'application/octet-stream'
      end
    end

    class StreamingOperation
      def self.build(http_req, input:)
        http_req.body = input[:stream]
        http_req.headers['Transfer-Encoding'] = 'chunked'
        http_req.headers['Content-Type'] = 'application/octet-stream'
      end
    end

    class StreamingWithLength
      def self.build(http_req, input:)
        http_req.body = input[:stream]
        http_req.headers['Content-Type'] = 'application/octet-stream'
      end
    end

    class Struct
    end

    class Union
    end

    class WaitersTest
      def self.build(http_req, input:)
      end
    end

    class Operation____PaginatorsTestWithBadNames
      def self.build(http_req, input:)
      end
    end
  end
end
