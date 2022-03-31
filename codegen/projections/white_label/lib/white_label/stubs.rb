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
          boxed_number: 1,
          default_number: 1,
          default_bool: false,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
      end
    end

    # Operation Stubber for KitchenSink
    class KitchenSink
      def self.default(visited=[])
        {
          string: 'string',
          simple_enum: 'simple_enum',
          typed_enum: 'typed_enum',
          struct: Stubs::Struct.default(visited),
          document: nil,
          list_of_strings: Stubs::ListOfStrings.default(visited),
          list_of_structs: Stubs::ListOfStructs.default(visited),
          map_of_strings: Stubs::MapOfStrings.default(visited),
          map_of_structs: Stubs::MapOfStructs.default(visited),
          set_of_strings: Stubs::SetOfStrings.default(visited),
          union: Stubs::Union.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
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

    # Set Stubber for SetOfStrings
    class SetOfStrings
      def self.default(visited=[])
        return nil if visited.include?('SetOfStrings')
        visited = visited + ['SetOfStrings']
        [
          'member'
        ]
      end

    end

    # Map Stubber for MapOfStructs
    class MapOfStructs
      def self.default(visited=[])
        return nil if visited.include?('MapOfStructs')
        visited = visited + ['MapOfStructs']
        {
          test_key: Stubs::Struct.default(visited)
        }
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

    # List Stubber for ListOfStructs
    class ListOfStructs
      def self.default(visited=[])
        return nil if visited.include?('ListOfStructs')
        visited = visited + ['ListOfStructs']
        [
          Stubs::Struct.default(visited)
        ]
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

    # Operation Stubber for PaginatorsTest
    class PaginatorsTest
      def self.default(visited=[])
        {
          next_token: 'next_token',
          items: Stubs::Items.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
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

    # Operation Stubber for PaginatorsTestWithItems
    class PaginatorsTestWithItems
      def self.default(visited=[])
        {
          next_token: 'next_token',
          items: Stubs::Items.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
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
          member___wrapper: Stubs::ResultWrapper.default(visited),
          member___items: Stubs::Items.default(visited),
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
  end
end
