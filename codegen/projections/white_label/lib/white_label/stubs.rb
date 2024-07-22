# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  # @api private
  module Stubs

    class ClientError
      def self.build(params, context:)
        Params::ClientError.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ClientError.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          message: 'message',
        }
      end

    end

    class CustomAuth
      def self.build(params, context:)
        Params::CustomAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::CustomAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class DataplaneEndpoint
      def self.build(params, context:)
        Params::DataplaneEndpointOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::DataplaneEndpointOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class DefaultsTest
      def self.build(params, context:)
        Params::DefaultsTestOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::DefaultsTestOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          string: 'string',
          struct: Struct.default(visited),
          un_required_number: 1,
          un_required_bool: false,
          number: 1,
          bool: false,
          hello: 'hello',
          simple_enum: 'simple_enum',
          valued_enum: 'valued_enum',
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
        http_resp.status = 200
      end
    end

    class Document
      def self.default(visited = [])
        return nil if visited.include?('Document')
        visited = visited + ['Document']
        { 'Document' => [0, 1, 2] }
      end

      def self.stub(stub = {})
        stub
      end
    end

    class EndpointOperation
      def self.build(params, context:)
        Params::EndpointOperationOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::EndpointOperationOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class EndpointWithHostLabelOperation
      def self.build(params, context:)
        Params::EndpointWithHostLabelOperationOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::EndpointWithHostLabelOperationOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class HttpApiKeyAuth
      def self.build(params, context:)
        Params::HttpApiKeyAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpApiKeyAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class HttpBasicAuth
      def self.build(params, context:)
        Params::HttpBasicAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpBasicAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class HttpBearerAuth
      def self.build(params, context:)
        Params::HttpBearerAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpBearerAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class HttpDigestAuth
      def self.build(params, context:)
        Params::HttpDigestAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpDigestAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class Items
      def self.default(visited = [])
        return nil if visited.include?('Items')
        visited = visited + ['Items']
        [
          'member'
        ]
      end

    end

    class KitchenSink
      def self.build(params, context:)
        Params::KitchenSinkOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::KitchenSinkOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          string: 'string',
          simple_enum: 'simple_enum',
          valued_enum: 'valued_enum',
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
      def self.default(visited = [])
        return nil if visited.include?('ListOfStrings')
        visited = visited + ['ListOfStrings']
        [
          'member'
        ]
      end

    end

    class ListOfStructs
      def self.default(visited = [])
        return nil if visited.include?('ListOfStructs')
        visited = visited + ['ListOfStructs']
        [
          Struct.default(visited)
        ]
      end

    end

    class MapOfStrings
      def self.default(visited = [])
        return nil if visited.include?('MapOfStrings')
        visited = visited + ['MapOfStrings']
        {
          'key' => 'value'
        }
      end

    end

    class MapOfStructs
      def self.default(visited = [])
        return nil if visited.include?('MapOfStructs')
        visited = visited + ['MapOfStructs']
        {
          'key' => Struct.default(visited)
        }
      end

    end

    class MixinTest
      def self.build(params, context:)
        Params::MixinTestOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::MixinTestOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          username: 'username',
          user_id: 'user_id',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class NoAuth
      def self.build(params, context:)
        Params::NoAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::NoAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class OptionalAuth
      def self.build(params, context:)
        Params::OptionalAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::OptionalAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class OrderedAuth
      def self.build(params, context:)
        Params::OrderedAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::OrderedAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class PaginatorsTest
      def self.build(params, context:)
        Params::PaginatorsTestOperationOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::PaginatorsTestOperationOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          next_token: 'next_token',
          items: Items.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class PaginatorsTestWithItems
      def self.build(params, context:)
        Params::PaginatorsTestWithItemsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::PaginatorsTestWithItemsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          next_token: 'next_token',
          items: Items.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class RelativeMiddleware
      def self.build(params, context:)
        Params::RelativeMiddlewareOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::RelativeMiddlewareOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class RequestCompression
      def self.build(params, context:)
        Params::RequestCompressionOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::RequestCompressionOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class RequestCompressionStreaming
      def self.build(params, context:)
        Params::RequestCompressionStreamingOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::RequestCompressionStreamingOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class ResourceEndpoint
      def self.build(params, context:)
        Params::ResourceEndpointOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ResourceEndpointOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class ResultWrapper
      def self.default(visited = [])
        return nil if visited.include?('ResultWrapper')
        visited = visited + ['ResultWrapper']
        {
          member___123next_token: 'member___123next_token',
        }
      end

    end

    class ServerError
      def self.build(params, context:)
        Params::ServerError.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ServerError.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

    end

    class Streaming
      def self.build(params, context:)
        Params::StreamingOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::StreamingOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          stream: 'stream',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        IO.copy_stream(stub.stream, http_resp.body)
      end
    end

    class StreamingWithLength
      def self.build(params, context:)
        Params::StreamingWithLengthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::StreamingWithLengthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class Struct
      def self.default(visited = [])
        return nil if visited.include?('Struct')
        visited = visited + ['Struct']
        {
          value: 'value',
        }
      end

    end

    class TelemetryTest
      def self.build(params, context:)
        Params::TelemetryTestOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::TelemetryTestOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          body: 'body',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class Union
      def self.default(visited = [])
        return nil if visited.include?('Union')
        visited = visited + ['Union']
        {
          string: 'string',
        }
      end

    end

    class WaitersTest
      def self.build(params, context:)
        Params::WaitersTestOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::WaitersTestOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          status: 'status',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class Operation____PaginatorsTestWithBadNames
      def self.build(params, context:)
        Params::Struct____PaginatorsTestWithBadNamesOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::Struct____PaginatorsTestWithBadNamesOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          member___wrapper: ResultWrapper.default(visited),
          member___items: Items.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end
  end
end
