
require_relative 'spec_helper'

module WhiteLabel
  describe Client do

    describe '#streaming_operation' do
      context 'block is provided' do
        let(:block_io) { double("BlockIO") }
        it 'creates and uses a blockIO as the body' do
          client = Client.new(stub_responses: true)

          expect(Hearth::BlockIO).to receive(:new).and_return(block_io)
          expect(block_io).to receive(:write).and_return(0)

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
          client = Client.new(stub_responses: true)

          expect(Hearth::HTTP::Response)
            .to receive(:new)
                  .with(hash_including(body: output_stream))
                  .and_call_original

          expect(output_stream).to receive(:write).and_return(0)
          client.streaming_operation({}, output_stream: output_stream)
        end
      end
    end
  end
end