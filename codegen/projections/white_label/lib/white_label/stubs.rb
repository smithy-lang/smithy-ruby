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
      ERROR_CLASS = Errors::ClientError
      PARAMS_CLASS = Params::ClientError

      def self.default(visited = Set.new)
        return nil if visited.include?('ClientError')
        visited.add('ClientError')
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
      PARAMS_CLASS = Params::DefaultsTestOutput

      def self.default(visited = Set.new)
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
      def self.default(visited = Set.new)
        return nil if visited.include?('Document')
        visited.add('Document')
        { 'Document' => [0, 1, 2] }
      end

      def self.stub(stub = {})
        stub
      end
    end

    class EndpointOperation
      PARAMS_CLASS = Params::EndpointOperationOutput

      def self.default(visited = Set.new)
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class EndpointWithHostLabelOperation
      PARAMS_CLASS = Params::EndpointWithHostLabelOperationOutput

      def self.default(visited = Set.new)
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class Items
      def self.default(visited = Set.new)
        return nil if visited.include?('Items')
        visited.add('Items')
        [
          'member'
        ]
      end

    end

    class KitchenSink
      PARAMS_CLASS = Params::KitchenSinkOutput

      def self.default(visited = Set.new)
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
      def self.default(visited = Set.new)
        return nil if visited.include?('ListOfStrings')
        visited.add('ListOfStrings')
        [
          'member'
        ]
      end

    end

    class ListOfStructs
      def self.default(visited = Set.new)
        return nil if visited.include?('ListOfStructs')
        visited.add('ListOfStructs')
        [
          Struct.default(visited)
        ]
      end

    end

    class MapOfStrings
      def self.default(visited = Set.new)
        return nil if visited.include?('MapOfStrings')
        visited.add('MapOfStrings')
        {
          key: 'value'
        }
      end

    end

    class MapOfStructs
      def self.default(visited = Set.new)
        return nil if visited.include?('MapOfStructs')
        visited.add('MapOfStructs')
        {
          key: Struct.default(visited)
        }
      end

    end

    class MixinTest
      PARAMS_CLASS = Params::MixinTestOutput

      def self.default(visited = Set.new)
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
      PARAMS_CLASS = Params::PaginatorsTestOperationOutput

      def self.default(visited = Set.new)
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
      PARAMS_CLASS = Params::PaginatorsTestWithItemsOutput

      def self.default(visited = Set.new)
        {
          next_token: 'next_token',
          items: Items.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
      end
    end

    class RequestCompressionOperation
      PARAMS_CLASS = Params::RequestCompressionOperationOutput

      def self.default(visited = Set.new)
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class RequestCompressionStreamingOperation
      PARAMS_CLASS = Params::RequestCompressionStreamingOperationOutput

      def self.default(visited = Set.new)
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class ResultWrapper
      def self.default(visited = Set.new)
        return nil if visited.include?('ResultWrapper')
        visited.add('ResultWrapper')
        {
          member___123next_token: 'member___123next_token',
        }
      end

    end

    class ServerError
      ERROR_CLASS = Errors::ServerError
      PARAMS_CLASS = Params::ServerError

      def self.default(visited = Set.new)
        return nil if visited.include?('ServerError')
        visited.add('ServerError')
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 500
      end
    end

    class StreamingOperation
      PARAMS_CLASS = Params::StreamingOperationOutput

      def self.default(visited = Set.new)
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
      PARAMS_CLASS = Params::StreamingWithLengthOutput

      def self.default(visited = Set.new)
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class Struct
      def self.default(visited = Set.new)
        return nil if visited.include?('Struct')
        visited.add('Struct')
        {
          value: 'value',
        }
      end

    end

    class Union
      def self.default(visited = Set.new)
        return nil if visited.include?('Union')
        visited.add('Union')
        {
          string: 'string',
        }
      end

    end

    class WaitersTest
      PARAMS_CLASS = Params::WaitersTestOutput

      def self.default(visited = Set.new)
        {
          status: 'status',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
      end
    end

    class Operation____PaginatorsTestWithBadNames
      PARAMS_CLASS = Params::Struct____PaginatorsTestWithBadNamesOutput

      def self.default(visited = Set.new)
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
