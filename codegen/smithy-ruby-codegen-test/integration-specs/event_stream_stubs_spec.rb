# frozen_string_literal: true

require_relative 'spec_helper'

describe WhiteLabel do
  let(:event_message) { 'event_message' }
  let(:event_header) { 'event_header' }
  let(:initial_message) { 'initial_message' }
  let(:complex_data) { { values: %w[a b c] } }
  let(:event_handler) { WhiteLabel::EventStream::StartEventStreamHandler.new }
  let(:handler) { proc {} }

  subject do
    WhiteLabel::Client.new(stub_responses: true)
  end

  context 'event stub Message' do
    let(:message) do
      headers = {
        ':message-type' => 'event',
        ':event-type' => 'SimpleEvent'
      }
      headers.each do |k, v|
        headers[k] =
          Hearth::EventStream::HeaderValue.new(value: v, type: 'string')
      end
      Hearth::EventStream::Message.new(
        headers: headers,
        payload: StringIO.new('{"message":"event_message"}')
      )
    end

    it 'signals the stubbed event' do
      subject.stub_responses(:start_event_stream, {
                               events: [message]
                             })

      event_handler.on_simple_event(&handler)

      expect(handler).to receive(:call) do |event|
        expect(event)
          .to be_a(WhiteLabel::Types::Events::SimpleEvent)
        expect(event.message).to eq(event_message)
      end

      subject.start_event_stream({}, event_stream_handler: event_handler)
    end
  end

  context 'error event stub Message' do
    let(:error_code) { 'error_code' }
    let(:error_message) { 'error_message' }
    let(:message) do
      headers = {
        ':message-type' => 'error',
        ':error-code' => error_code,
        ':error-message' => error_message
      }
      headers.each do |k, v|
        headers[k] =
          Hearth::EventStream::HeaderValue.new(value: v, type: 'string')
      end
      Hearth::EventStream::Message.new(
        headers: headers
      )
    end

    it 'signals the stubbed error' do
      subject.stub_responses(:start_event_stream, {
                               events: [message]
                             })

      event_handler.on_error_event(&handler)

      expect(handler).to receive(:call) do |code, message|
        expect(code).to eq(error_code)
        expect(message).to eq(error_message)
      end

      subject.start_event_stream({}, event_stream_handler: event_handler)
    end
  end

  context 'SimpleEvent Type stub' do
    let(:event) do
      WhiteLabel::Types::SimpleEvent.new(
        message: event_message
      )
    end

    it 'signals the stubbed event' do
      subject.stub_responses(:start_event_stream, {
                               events: [event]
                             })

      event_handler.on_simple_event(&handler)

      expect(handler).to receive(:call) do |event|
        expect(event)
          .to be_a(WhiteLabel::Types::Events::SimpleEvent)
        expect(event.message).to eq(event_message)
      end

      subject.start_event_stream({}, event_stream_handler: event_handler)
    end
  end

  context 'multiple events' do
    let(:simple_event) do
      WhiteLabel::Types::SimpleEvent.new(
        message: event_message
      )
    end

    let(:nested_event) do
      WhiteLabel::Params::NestedEvent.build(
        {
          nested: complex_data,
          header_a: event_header,
          message: event_message
        },
        context: 'stub'
      )
    end

    let(:explicit_payload_event) do
      WhiteLabel::Params::ExplicitPayloadEvent.build(
        {
          header_a: event_header,
          payload: complex_data
        },
        context: 'stub'
      )
    end

    it 'signals the stubbed events' do
      subject.stub_responses(:start_event_stream,
                             {
                               events: [
                                 simple_event,
                                 nested_event,
                                 explicit_payload_event
                               ]
                             })

      event_handler.on_simple_event(&handler)
      event_handler.on_nested_event(&handler)
      event_handler.on_explicit_payload_event(&handler)

      expect(handler).to receive(:call) do |event|
        expect(event)
          .to be_a(WhiteLabel::Types::Events::SimpleEvent)
        expect(event.message).to eq(event_message)
      end

      expect(handler).to receive(:call) do |event|
        expect(event)
          .to be_a(WhiteLabel::Types::Events::NestedEvent)
        expect(event.message).to eq(event_message)
      end

      expect(handler).to receive(:call) do |event|
        expect(event)
          .to be_a(WhiteLabel::Types::Events::ExplicitPayloadEvent)
        expect(event.header_a).to eq(event_header)
      end

      subject.start_event_stream({}, event_stream_handler: event_handler)
    end
  end

  context 'initial response structure' do
    it 'stubs the initial response' do
      subject.stub_responses(
        :start_event_stream,
        {
          initial_response: WhiteLabel::Types::StartEventStreamOutput.new(
            initial_structure: WhiteLabel::Types::InitialStructure.new(
              message: initial_message
            )
          )
        }
      )

      event_handler.on_initial_response(&handler)

      expect(handler).to receive(:call) do |event|
        expect(event).to be_a(WhiteLabel::Types::StartEventStreamOutput)
        expect(event.initial_structure.message).to eq(initial_message)
      end

      subject.start_event_stream({}, event_stream_handler: event_handler)
    end
  end

  context 'initial response hash' do
    it 'stubs the initial response' do
      subject.stub_responses(:start_event_stream, {
                               initial_response: {
                                 initial_structure: {
                                   message: initial_message
                                 }
                               }
                             })

      event_handler.on_initial_response(&handler)

      expect(handler).to receive(:call) do |event|
        expect(event).to be_a(WhiteLabel::Types::StartEventStreamOutput)
        expect(event.initial_structure.message).to eq(initial_message)
      end

      subject.start_event_stream({}, event_stream_handler: event_handler)
    end
  end

  context 'initial response object' do
    let(:initial_response) do
      headers = {
        ':message-type' => 'event',
        ':event-type' => 'initial-response',
        ':content-type' => 'application/json'
      }
      headers.each do |k, v|
        headers[k] =
          Hearth::EventStream::HeaderValue.new(value: v, type: 'string')
      end
      Hearth::HTTP2::Response.new(
        status: 200,
        body: Hearth::EventStream::Message.new(
          headers: headers,
          payload: StringIO.new('{"message":"initial_message"}')
        )
      )
    end
    it 'stubs the initial response' do
      subject.stub_responses(
        :start_event_stream,
        {
          initial_response: initial_response
        }
      )

      event_handler.on_initial_response(&handler)

      expect(handler).to receive(:call) do |event|
        expect(event).to be_a(WhiteLabel::Types::StartEventStreamOutput)
        expect(event.initial_structure.message).to eq(initial_message)
      end

      subject.start_event_stream({}, event_stream_handler: event_handler)
    end
  end

  context 'error response' do
    it 'raises the error' do
      subject.stub_responses(:start_event_stream,
                             Hearth::HTTP2::ConnectionClosedError.new(
                               StandardError.new
                             ))
      expect do
        subject.start_event_stream({}, event_stream_handler: event_handler)
      end.to raise_error(Hearth::HTTP2::ConnectionClosedError)
    end
  end

  context 'API error response' do
    it 'signals the error' do
      subject.stub_responses(:start_event_stream,
                             WhiteLabel::Errors::ClientError.new(
                               http_resp: Hearth::HTTP2::Response.new,
                               error_code: 'ClientError'
                             ))

      event_handler.on_error(&handler)

      expect(handler).to receive(:call) do |error|
        expect(error).to be_a(WhiteLabel::Errors::ClientError)
      end

      subject.start_event_stream({}, event_stream_handler: event_handler)
    end
  end

  context 'default stubs' do
    let(:default_message) { 'message' }
    it 'stubs a default initial response and event' do
      event_handler.on_initial_response(&handler)
      event_handler.on_simple_event(&handler)

      expect(handler).to receive(:call) do |event|
        expect(event).to be_a(WhiteLabel::Types::StartEventStreamOutput)
        expect(event.initial_structure.message).to eq(default_message)
      end

      expect(handler).to receive(:call) do |event|
        expect(event)
          .to be_a(WhiteLabel::Types::Events::SimpleEvent)
        expect(event.message).to eq(default_message)
      end

      subject.start_event_stream({}, event_stream_handler: event_handler)
    end
  end
end
