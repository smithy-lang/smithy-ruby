# frozen_string_literal: true

require_relative 'spec_helper'

$LOAD_PATH << '../codegen/projections/cbor_event_streams/lib'

require 'cbor_event_streams'
require 'timeout'

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
            if !message.headers.empty? || !message.payload.empty?
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

    while !sock.closed? && !(sock.eof? rescue true) # rubocop:disable Style/RescueModifier
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

  let(:event_a_message) { 'event_a_message' }

  it 'sends and receives event streams' do
    # unless ENV['EVENT_STREAM_INTEGRATION_TEST']
    #   skip('Skipping integration test, set EVENT_STREAM_INTEGRATION_TEST to enable')
    # end

    server, server_thread = start_mirror_event_server(port)
    Timeout.timeout(5) do
      client = CborEventStreams::Client.new(endpoint: "http://localhost:#{port}")

      handler = CborEventStreams::EventStream::StartEventStreamHandler.new

      event_a_queue = Thread::Queue.new
      handler.on_event_a do |event|
        puts "EventA Handler.  Event: #{event.inspect}"
        event_a_queue << event
      end

      handler.on_event_b do |event|
        puts "EventB Handler.  Event: #{event.inspect}"
      end

      handler.on_initial_response do |event|
        puts "INITIAL_RESPONSE  Event: #{event.inspect}"
      end

      handler.on_headers do |headers|
        puts "Received headers: #{headers.to_h}"
      end

      handler.on_unknown_event do |message|
        puts "UNKNOWN: #{message.payload.read}"
      end

      puts 'Starting request'
      stream = client.start_event_stream(
        { initial_structure: { message: 'ME FIRST!' } }, event_stream_handler: handler
      )
      stream.signal_event_a(message: event_a_message)
      stream.signal_event_b(nested: { member_values: %w[a b c] })

      # What to test:
      # we get the initial response, it has the same message
      # we get headers
      # we get eventA
      # we get eventB
      # we do NOT get any unknown events

      # How to test that we got events. the events come in another thread
      stream.join
      stream.kill

      event_a = event_a_queue.pop
      expect(event_a).to be_a(CborEventStreams::Types::EventA)
      expect(event_a.message).to eq(event_a_message)
    end
  rescue Timeout::Error
    raise 'Event Stream integration test timed out. This likely means one or more expected events were not sent or received correctly.'
  ensure
    server_thread.kill
    server&.close
  end
end
