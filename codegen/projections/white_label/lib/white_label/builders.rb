# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Builders

    # Operation Builder for DefaultsTest
    class DefaultsTest
      def self.build(http_req, input:)
      end
    end

    # Operation Builder for EndpointOperation
    class EndpointOperation
      def self.build(http_req, input:)
      end
    end

    # Operation Builder for EndpointWithHostLabelOperation
    class EndpointWithHostLabelOperation
      def self.build(http_req, input:)
      end
    end

    # Operation Builder for KitchenSink
    class KitchenSink
      def self.build(http_req, input:)
      end
    end

    # List Builder for ListOfStrings
    class ListOfStrings
    end

    # List Builder for ListOfStructs
    class ListOfStructs
    end

    # Map Builder for MapOfStrings
    class MapOfStrings
    end

    # Map Builder for MapOfStructs
    class MapOfStructs
    end

    # Operation Builder for MixinTest
    class MixinTest
      def self.build(http_req, input:)
      end
    end

    # Operation Builder for PaginatorsTest
    class PaginatorsTest
      def self.build(http_req, input:)
      end
    end

    # Operation Builder for PaginatorsTestWithItems
    class PaginatorsTestWithItems
      def self.build(http_req, input:)
      end
    end

    # Operation Builder for StreamingOperation
    class StreamingOperation
      def self.build(http_req, input:)
        http_req.body = input[:stream]
        http_req.fields['Transfer-Encoding'] = 'chunked'
        http_req.fields['Content-Type'] = 'application/octet-stream'
      end
    end

    # Operation Builder for StreamingWithLength
    class StreamingWithLength
      def self.build(http_req, input:)
        http_req.body = input[:stream]
        http_req.fields['Content-Type'] = 'application/octet-stream'
      end
    end

    # Structure Builder for Struct
    class Struct
    end

    # Structure Builder for Union
    class Union
    end

    # Operation Builder for WaitersTest
    class WaitersTest
      def self.build(http_req, input:)
      end
    end

    # Operation Builder for __PaginatorsTestWithBadNames
    class Operation____PaginatorsTestWithBadNames
      def self.build(http_req, input:)
      end
    end
  end
end
