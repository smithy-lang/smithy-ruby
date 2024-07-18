# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'stringio'

module CborEventStreams
  # @api private
  module Builders

    class EventA
      def self.build(input)
        data = {}
        data['message'] = input[:message] unless input[:message].nil?
        data
      end
    end

    class EventB
      def self.build(input)
        data = {}
        data['nested'] = NestedEvent.build(input[:nested]) unless input[:nested].nil?
        data
      end
    end

    class EventValues
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class InitialStructure
      def self.build(input)
        data = {}
        data['message'] = input[:message] unless input[:message].nil?
        data
      end
    end

    class NestedEvent
      def self.build(input)
        data = {}
        data['values'] = EventValues.build(input[:member_values]) unless input[:member_values].nil?
        data
      end
    end

    class NonStreamingOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/CborEventStreams/operation/NonStreamingOperation')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        data = {}
        data['inputValue'] = input[:input_value] unless input[:input_value].nil?
        http_req.headers['Content-Type'] = 'application/cbor'
        http_req.body = ::StringIO.new(Hearth::CBOR.encode(data))
      end
    end

    class StartEventStream
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/CborEventStreams/operation/StartEventStream')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        http_req.headers['Content-Type'] = 'application/vnd.amazon.eventstream'
        http_req.headers['Accept'] = 'application/vnd.amazon.eventstream'
        data = {}
        data['initialStructure'] = InitialStructure.build(input[:initial_structure]) unless input[:initial_structure].nil?
        message = Hearth::EventStream::Message.new
        message.headers[':message-type'] = Hearth::EventStream::HeaderValue.new(value: 'event', type: 'string')
        message.headers[':event-type'] = Hearth::EventStream::HeaderValue.new(value: 'initial-request', type: 'string')
        message.headers[':event-type'] = Hearth::EventStream::HeaderValue.new(value: 'initial-request', type: 'string')
        message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/cbor', type: 'string')
        message.payload = ::StringIO.new(Hearth::CBOR.encode(data))
        http_req.body = message
      end
    end

    module EventStream
      class EventA
        def self.build(input:)
          message = Hearth::EventStream::Message.new
          message.headers[':message-type'] = Hearth::EventStream::HeaderValue.new(value: 'event', type: 'string')
          message.headers[':event-type'] = Hearth::EventStream::HeaderValue.new(value: 'EventA', type: 'string')
          message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/cbor', type: 'string')
          payload_input = input
          message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/cbor', type: 'string')
          data = {}
          data['message'] = payload_input[:message] unless payload_input[:message].nil?
          message.payload = ::StringIO.new(Hearth::CBOR.encode(data))
          message
        end
      end
      class EventB
        def self.build(input:)
          message = Hearth::EventStream::Message.new
          message.headers[':message-type'] = Hearth::EventStream::HeaderValue.new(value: 'event', type: 'string')
          message.headers[':event-type'] = Hearth::EventStream::HeaderValue.new(value: 'EventB', type: 'string')
          message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/cbor', type: 'string')
          payload_input = input
          message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/cbor', type: 'string')
          data = {}
          data['nested'] = NestedEvent.build(payload_input[:nested]) unless payload_input[:nested].nil?
          message.payload = ::StringIO.new(Hearth::CBOR.encode(data))
          message
        end
      end
    end
  end
end
