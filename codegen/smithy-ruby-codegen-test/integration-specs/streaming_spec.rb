
require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    let(:config) { Config.new(stub_responses: true) }
    let(:client) { Client.new(config) }

    describe '#streaming_operation' do
      let(:output) { 'test' }

      before do
        client.stub_responses(:streaming_operation, { stream: output } )
      end

      context 'block is provided' do
        let(:block_io) { double("BlockIO") }

        it 'creates and uses a blockIO as the body' do
          expect(Hearth::BlockIO).to receive(:new).and_return(block_io)
          expect(block_io).to receive(:write).with(output).and_return(0)

          expect(Hearth::HTTP::Response)
            .to receive(:new)
                  .with(hash_including(body: block_io))
                  .and_call_original

          client.streaming_operation { |resp| resp }
        end
      end

      context 'output_stream is set' do
        let(:output_stream) { double("OutputStream") }

        it 'uses the output_stream as the body' do
          expect(Hearth::HTTP::Response)
            .to receive(:new)
                  .with(hash_including(body: output_stream))
                  .and_call_original

          expect(output_stream).to receive(:write).with(output).and_return(0)
          client.streaming_operation({}, output_stream: output_stream)
        end
      end

      context 'parsers' do
        let(:output_stream) { double("OutputStream") }

        before do
          expect(output_stream).to receive(:write).and_return(0)
        end

        it 'does not read the body' do
          expect(output_stream).not_to receive(:read)
          client.streaming_operation({}, output_stream: output_stream)
        end

        it 'sets the field on the output' do
          resp = client.streaming_operation({}, output_stream: output_stream)
          expect(resp.data.stream).to be(output_stream)
        end
      end

      context 'stubs' do
        let(:output_stream) { double("OutputStream") }

        it 'copies the stub to the output stream' do
          middleware = Hearth::MiddlewareBuilder.after_send do |_, context|
            expect(context.response.body).to be(output_stream)
          end
          expect(output_stream).to receive(:write).with(output).and_return(0)
          client.streaming_operation({}, output_stream: output_stream, middleware: middleware)
        end

        context('nil stub value') do
          let(:output) { nil }

          it 'streams an empty body' do
            expect(output_stream).not_to receive(:write)
            client.streaming_operation({}, output_stream: output_stream)
          end
        end
      end

      context 'builders' do
        it 'sets the body to the streaming member' do
          streaming_input = StringIO.new("test")
          middleware = Hearth::MiddlewareBuilder.before_send do |_, context|
            expect(context.request.body).to be(streaming_input)
          end
          expect(streaming_input).not_to receive(:read)
          client.streaming_operation({stream: streaming_input}, middleware: middleware)
        end

        it 'sets Transfer-Encoding and does not set content length' do
          streaming_input = StringIO.new("test")
          middleware = Hearth::MiddlewareBuilder.before_send do |_, context|
            expect(context.request.fields['Transfer-Encoding'].value).to eq('chunked')
            expect(context.request.fields.key?('Content-Length')).to eq(false)
          end
          expect(streaming_input).not_to receive(:size)
          client.streaming_operation({stream: streaming_input}, middleware: middleware)
        end
      end
    end

    describe '#streaming_with_length' do
      let(:data) { 'test' }

      it 'sets content-length and does not set Transfer-Encoding' do
        middleware = Hearth::MiddlewareBuilder.before_send do |_, context|
          expect(context.request.fields['Content-Length'].value).to eq(data.length.to_s)
          expect(context.request.fields.key?('Transfer-Encoding')).to eq(false)
        end
        client.streaming_with_length({stream: data}, middleware: middleware)
      end
    end
  end
end