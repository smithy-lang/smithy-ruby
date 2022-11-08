# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Parsers

    # Operation Parser for DefaultKitchenSink
    class DefaultKitchenSink
      def self.parse(http_resp)
        data = Types::DefaultKitchenSinkOutput.new
        data
      end
    end

    class MapOfStrings
    end

    class ListOfStrings
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

    # Operation Parser for KitchenSink
    class KitchenSink
      def self.parse(http_resp)
        data = Types::KitchenSinkOutput.new
        data
      end
    end

    class Union
    end

    class Struct
    end

    class MapOfStructs
    end

    class ListOfStructs
    end

    # Error Parser for ClientError
    class ClientError
      def self.parse(http_resp)
        data = Types::ClientError.new
        data
      end
    end

    # Error Parser for ServerError
    class ServerError
      def self.parse(http_resp)
        data = Types::ServerError.new
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

    class Items
    end

    # Operation Parser for PaginatorsTestWithItems
    class PaginatorsTestWithItems
      def self.parse(http_resp)
        data = Types::PaginatorsTestWithItemsOutput.new
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

    class ResultWrapper
    end
  end
end
