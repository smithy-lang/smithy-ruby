# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Stubs

    # Operation Stubber for DefaultsTest
    class DefaultsTest
      def self.default(visited=[])
        {
          string: 'string',
          struct: Struct.default(visited),
          un_required_number: 1,
          un_required_bool: false,
          number: 1,
          bool: false,
          hello: 'hello',
          simple_enum: 'simple_enum',
          typed_enum: 'typed_enum',
          int_enum: 1,
          null_document: nil,
          string_document: nil,
          boolean_document: nil,
          numbers_document: nil,
          list_document: nil,
          map_document: nil,
          list_of_strings: ListOfStrings.default(visited),
          map_of_strings: MapOfStrings.default(visited),
          iso8601_timestamp: Time.now,
          epoch_timestamp: Time.now,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
      end
    end

    # Document Type Stubber for Document
    class Document
      def self.default(visited=[])
        return nil if visited.include?('Document')
        visited = visited + ['Document']
        { 'Document' => [0, 1, 2] }
      end

      def self.stub(stub = {})
        stub
      end
    end

    # Operation Stubber for EndpointOperation
    class EndpointOperation
      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for EndpointWithHostLabelOperation
    class EndpointWithHostLabelOperation
      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # List Stubber for Items
    class Items
      def self.default(visited=[])
        return nil if visited.include?('Items')
        visited = visited + ['Items']
        [
          'member'
        ]
      end

    end

    # Operation Stubber for KitchenSink
    class KitchenSink
      def self.default(visited=[])
        {
          string: 'string',
          simple_enum: 'simple_enum',
          typed_enum: 'typed_enum',
          struct: Struct.default(visited),
          document: nil,
          list_of_strings: ListOfStrings.default(visited),
          list_of_structs: ListOfStructs.default(visited),
          map_of_strings: MapOfStrings.default(visited),
          map_of_structs: MapOfStructs.default(visited),
          union: Union.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # List Stubber for ListOfStrings
    class ListOfStrings
      def self.default(visited=[])
        return nil if visited.include?('ListOfStrings')
        visited = visited + ['ListOfStrings']
        [
          'member'
        ]
      end

    end

    # List Stubber for ListOfStructs
    class ListOfStructs
      def self.default(visited=[])
        return nil if visited.include?('ListOfStructs')
        visited = visited + ['ListOfStructs']
        [
          Struct.default(visited)
        ]
      end

    end

    # Map Stubber for MapOfStrings
    class MapOfStrings
      def self.default(visited=[])
        return nil if visited.include?('MapOfStrings')
        visited = visited + ['MapOfStrings']
        {
          test_key: 'value'
        }
      end

    end

    # Map Stubber for MapOfStructs
    class MapOfStructs
      def self.default(visited=[])
        return nil if visited.include?('MapOfStructs')
        visited = visited + ['MapOfStructs']
        {
          test_key: Struct.default(visited)
        }
      end

    end

    # Operation Stubber for MixinTest
    class MixinTest
      def self.default(visited=[])
        {
          username: 'username',
          user_id: 'user_id',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
      end
    end

    # Operation Stubber for PaginatorsTest
    class PaginatorsTest
      def self.default(visited=[])
        {
          next_token: 'next_token',
          items: Items.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
      end
    end

    # Operation Stubber for PaginatorsTestWithItems
    class PaginatorsTestWithItems
      def self.default(visited=[])
        {
          next_token: 'next_token',
          items: Items.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
      end
    end

    # Structure Stubber for ResultWrapper
    class ResultWrapper
      def self.default(visited=[])
        return nil if visited.include?('ResultWrapper')
        visited = visited + ['ResultWrapper']
        {
          member___123next_token: 'member___123next_token',
        }
      end

    end

    # Operation Stubber for StreamingOperation
    class StreamingOperation
      def self.default(visited=[])
        {
          stream: 'stream',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        IO.copy_stream(stub[:stream], http_resp.body)
      end
    end

    # Operation Stubber for StreamingWithLength
    class StreamingWithLength
      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Structure Stubber for Struct
    class Struct
      def self.default(visited=[])
        return nil if visited.include?('Struct')
        visited = visited + ['Struct']
        {
          value: 'value',
        }
      end

    end

    # Union Stubber for Union
    class Union
      def self.default(visited=[])
        return nil if visited.include?('Union')
        visited = visited + ['Union']
        {
          string: 'string',
        }
      end

    end

    # Operation Stubber for WaitersTest
    class WaitersTest
      def self.default(visited=[])
        {
          status: 'status',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
      end
    end

    # Operation Stubber for __PaginatorsTestWithBadNames
    class Operation____PaginatorsTestWithBadNames
      def self.default(visited=[])
        {
          member___wrapper: ResultWrapper.default(visited),
          member___items: Items.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
      end
    end
  end
end
