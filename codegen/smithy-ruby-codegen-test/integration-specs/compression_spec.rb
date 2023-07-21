# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Config do
    context 'disable_request_compression' do
      it 'raises error when given an invalid input' do
        expect { Config.new(disable_request_compression: 'string') }
          .to raise_error(
            ArgumentError,
            'Expected config[:disable_request_compression] to be in [TrueClass, FalseClass], got String.'
          )
      end
    end

    context 'request_min_compression_size_bytes' do
      it 'raises error when given invalid integer' do
        # TODO after we implement constraints on configs
      end
    end
  end

  describe Client do
    let(:config) { Config.new(stub_responses: true) }
    let(:client) { Client.new(config) }

    let(:before_send) do
      Class.new do
        def initialize(&block)
          @block = block
        end

        def read_before_transmit(context)
          @block.call(context)
        end
      end
    end

    context '#request_compression_operation' do
      it 'compresses the body and sets the Content-Encoding header' do
        input_body = 'a' * 10_241
        interceptor = before_send.new do |context|
          uncompressed = Zlib::GzipReader.new(context.request.body)
          expect(uncompressed.read).to eq(input_body)
          expect(context.request.headers['Content-Encoding']).to eq('gzip')
        end
        client.request_compression_operation( { body: input_body }, interceptors: [interceptor])

      end

      it 'does not compress when body does not meet the minimum' do
        input_body = 'Hello World'
        interceptor = before_send.new do |context|
          expect(context.request.body.read).to eq(input_body)
          expect(context.request.headers['Content-Encoding']).to be_nil
        end
        client.request_compression_operation( { body: input_body }, interceptors: [interceptor])
      end

    end

    context '#request_compression_streaming_operation' do
      it 'compresses the streaming body and sets the Content-Encoding header' do
        streaming_input = StringIO.new('Hello World')
        interceptor = before_send.new do |context|
          expect(context.request.headers['Content-Encoding']). to eq('gzip')
          # capture the body by reading it into a new IO object
          body = StringIO.new
          # IO.copy_stream is the same method used by Net::Http to write our body to the socket
          IO.copy_stream(context.request.body, body)
          body.rewind
          streaming_input.rewind
          uncompressed = Zlib::GzipReader.new(body)
          expect(uncompressed.read).to eq(streaming_input.read)
        end
        client.request_compression_streaming_operation( { body: streaming_input }, interceptors: [interceptor])
      end
    end

  end

end