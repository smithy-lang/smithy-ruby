# frozen_string_literal: true

# TODO: Move this into the codegen project + add tasks
# it is currently in hearth to make running/debugging quicker/easier
# during development.

require_relative 'spec_helper'

$LOAD_PATH << File.join(
  __dir__,
  '../../codegen/projections/cbor_event_streams/lib'
)
require 'cbor_event_streams'
require 'timeout'

def sock_eof?(sock)
  sock.eof?
rescue StandardError
  true
end

# rubocop:disable Metrics
def start_mirror_event_server(port)
  require 'socket'
  require 'openssl'
  require 'uri'
  require 'http/2'

  server = TCPServer.new(port)

  Logger.new($stdout)
  $stdout.sync = true

  server_thread = Thread.new do
    sock = server.accept
    sock.setsockopt(:SOCKET, :RCVBUF, 2048)
    conn = HTTP2::Server.new

    conn.on(:frame) do |bytes|
      sock.write(bytes) unless sock.closed?
    end

    conn.on(:goaway) do
      sock.close
    end

    conn.on(:stream) do |stream|
      message_decoder = Hearth::EventStream::Binary::MessageDecoder.new
      message_encoder = Hearth::EventStream::Binary::MessageEncoder.new

      stream.on(:headers) do |_h|
        # send a response back
        stream.headers({
                         ':status' => '200',
                         'content-type' => 'application/vnd.amazon.eventstream'
                       }, end_stream: false)
      end

      stream.on(:data) do |chunk|
        loop do
          message, empty = message_decoder.decode(chunk)
          chunk = nil
          if message
            type = message.headers[':event-type']&.value
            if type == 'initial-request'
              message.headers[':event-type'] =
                Hearth::EventStream::HeaderValue.new(value: 'initial-response',
                                                     type: 'string')
            end

            # an empty message means close stream, don't mirror it
            # rubocop:disable Style/ZeroLengthPredicate
            if !message.headers.empty? || message.payload.size > 0
              # rubocop:enable Style/ZeroLengthPredicate
              # mirror the message back
              payload = message_encoder.encode(message)
              stream.data(payload, end_stream: false)
            end
          end
          break if empty
        end
      end

      stream.on(:half_close) do
        stream.close
      end
    end

    while !sock.closed? && !sock_eof?(sock)
      data = sock.readpartial(16_384)

      begin
        conn << data
      rescue StandardError => e
        puts "#{e.class} exception: #{e.message} - closing socket."
        puts e.backtrace
        sock.close
      end
    end
  ensure
    sock&.close
  end
  [server, server_thread]
end

describe CborEventStreams do
  let(:port) { 9041 }

  let(:event_message) { 'event_message' }
  let(:initial_message) { 'initial_message' }
  let(:complex_data) { {values: %w[a b c] } }

  it 'sends and receives event streams' do
    # unless ENV['EVENT_STREAM_INTEGRATION_TEST']
    #   msg = 'Skipping integration test, set EVENT_STREAM_INTEGRATION_TEST '\
    #     'to enable'
    #   skip(msg)
    # end

    server, server_thread = start_mirror_event_server(port)
    Timeout.timeout(5) do
      client = CborEventStreams::Client.new(
        endpoint: "http://localhost:#{port}"
      )

      handler = CborEventStreams::EventStream::StartEventStreamHandler.new

      event_queue = Thread::Queue.new

      handler.on_initial_response do |event|
        event_queue << event
      end

      handler.on_simple_event do |event|
        event_queue << event
      end

      handler.on_nested_event do |event|
        event_queue << event
      end

      handler.on_explicit_payload_event do |event|
        event_queue << event
      end

      unknown_events = Thread::Queue.new
      handler.on_unknown_event do |message|
        unknown_events << message
      end

      stream = client.start_event_stream(
        { initial_structure: { message: initial_message, nested: complex_data } },
        event_stream_handler: handler
      )
      initial_event = event_queue.pop
      expect(initial_event).to be_a(CborEventStreams::Types::StartEventStreamOutput)
      expect(initial_event.initial_structure.message).to eq(initial_message)

      stream.signal_simple_event(message: event_message)
      simple_event = event_queue.pop
      expect(simple_event).to be_a(CborEventStreams::Types::SimpleEvent)
      expect(simple_event.message).to eq(event_message)

      stream.signal_nested_event(nested: complex_data)
      nested_event = event_queue.pop
      expect(nested_event).to be_a(CborEventStreams::Types::NestedEvent)
      expect(nested_event.nested.to_h).to eq(complex_data)

      stream.signal_explicit_payload_event(
        header_a: event_message, payload: complex_data)
      event = event_queue.pop
      expect(event).to be_a(CborEventStreams::Types::ExplicitPayloadEvent)
      expect(event.header_a).to eq(event_message)
      expect(event.payload.to_h).to eq(complex_data)

      stream.join
      stream.kill

      # no unknown events received
      expect(unknown_events.size).to eq(0)
    end
  rescue Timeout::Error
    raise 'Event Stream integration test timed out. ' \
          'This likely means one or more expected events were not ' \
          'sent or received correctly.'
  ensure
    server_thread.kill
    server&.close
  end
end
# rubocop:enable Metrics
