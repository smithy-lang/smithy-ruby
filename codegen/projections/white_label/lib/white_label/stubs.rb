# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  # @api private
  module Stubs

    class ClientError
      def self.error_class
        Errors::ClientError
      end

      def self.params_class
        Params::ClientError
      end

      def self.default(visited=[])
        return nil if visited.include?('ClientError')
        visited = visited + ['ClientError']
        {
          message: 'message',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 400
      end
    end

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

    class Items
      def self.default(visited=[])
        return nil if visited.include?('Items')
        visited = visited + ['Items']
        [
          'member'
        ]
      end

    end

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

    class ListOfStrings
      def self.default(visited=[])
        return nil if visited.include?('ListOfStrings')
        visited = visited + ['ListOfStrings']
        [
          'member'
        ]
      end

    end

    class ListOfStructs
      def self.default(visited=[])
        return nil if visited.include?('ListOfStructs')
        visited = visited + ['ListOfStructs']
        [
          Struct.default(visited)
        ]
      end

    end

    class MapOfStrings
      def self.default(visited=[])
        return nil if visited.include?('MapOfStrings')
        visited = visited + ['MapOfStrings']
        {
          key: 'value'
        }
      end

    end

    class MapOfStructs
      def self.default(visited=[])
        return nil if visited.include?('MapOfStructs')
        visited = visited + ['MapOfStructs']
        {
          key: Struct.default(visited)
        }
      end

    end

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

    class ResultWrapper
      def self.default(visited=[])
        return nil if visited.include?('ResultWrapper')
        visited = visited + ['ResultWrapper']
        {
          member___123next_token: 'member___123next_token',
        }
      end

    end

    class ServerError
      def self.error_class
        Errors::ServerError
      end

      def self.params_class
        Params::ServerError
      end

      def self.default(visited=[])
        return nil if visited.include?('ServerError')
        visited = visited + ['ServerError']
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 500
      end
    end

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

    class Struct
      def self.default(visited=[])
        return nil if visited.include?('Struct')
        visited = visited + ['Struct']
        {
          value: 'value',
        }
      end

    end

    class Union
      def self.default(visited=[])
        return nil if visited.include?('Union')
        visited = visited + ['Union']
        {
          string: 'string',
        }
      end

    end

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
