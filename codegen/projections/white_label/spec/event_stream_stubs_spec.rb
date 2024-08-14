# frozen_string_literal: true

require_relative 'spec_helper'


describe WhiteLabel do

  let(:event_message) { 'event_message' }
  let(:event_header) { 'event_header' }
  let(:initial_message) { 'initial_message' }
  let(:complex_data) { { values: %w[a b c] } }

  it 'allows stubbing' do
    client = WhiteLabel::Client.new(stub_responses: true)
    headers = {
      ':message-type' => 'event',
      ':event-type' => 'SimpleEvent',
    }
    headers.each do |k, v|
      headers[k] = Hearth::EventStream::HeaderValue.new(value: v, type: 'string')
    end

    client.stub_responses(:start_event_stream, {
      events: [
        Hearth::EventStream::Message.new(
          headers: headers,
          payload: StringIO.new('{"message":"event_message"}')
        ),
        WhiteLabel::Types::NestedEvent.new(
          header_a: event_header,
          message: event_message,
          nested: complex_data
        ),
        WhiteLabel::Types::ExplicitPayloadEvent.new(
          header_a: event_header,
          payload: complex_data
        )
      ]
    })

    handler = WhiteLabel::EventStream::StartEventStreamHandler.new
    handler.on_raw_event do |message|
      puts "Raw Message: #{message.inspect}"
    end
    handler.on_simple_event do |event|
      puts event.inspect
    end
    handler.on_nested_event do |event|
      puts event.inspect
    end
    handler.on_explicit_payload_event do |event|
      puts event.inspect
    end

    stream = double(closed?: false, state: :open)
    proc = proc do |context|
      context.response.stream = stream

    end
    interceptor = Hearth::Interceptor.new(modify_before_completion: proc)

    output = client.start_event_stream(
      {
        initial_structure: {
          message: initial_message,
          nested: complex_data
        }
      },
      event_stream_handler: handler,
      interceptors: [interceptor]
    )

    expect(stream).to receive(:data) do |chunk|
      puts "Got chunk: #{chunk}"
      expect(chunk).to include(event_message)
    end
    output.signal_simple_event(message: event_message)


  end
end
# rubocop:enable Metrics
