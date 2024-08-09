# frozen_string_literal: true

module Hearth
  module EventStream
    describe AsyncOutput do
      let(:response) { HTTP2::Response.new }
      let(:payload) { 'payload' }
      let(:encoder) { double(encode: payload) }
      let(:closed) { false }
      let(:state) { :open }
      let(:stream) { double(closed?: closed, state: state) }

      subject do
        AsyncOutput.new(
          response: response,
          encoder: encoder
        )
      end

      before(:each) do
        response.stream = stream if response
      end

      describe '#end_input_stream' do
        context 'stream closed' do
          let(:closed) { true }

          it 'does not send a frame' do
            expect(stream).not_to receive(:data)
            subject.end_input_stream
          end
        end

        context 'stream open' do
          let(:closed) { false }

          it 'encodes an empty message and sends end_stream' do
            expect(stream).to receive(:data).with(payload, end_stream: true)
            subject.end_input_stream
          end
        end
      end

      describe '#join' do
        context 'no response' do
          let(:response) { nil }

          it 'returns false immediately' do
            expect(subject.join).to be_falsey
          end
        end

        context 'stream closed' do
          let(:closed) { true }

          it 'returns false immediately' do
            expect(subject.join).to be_falsey
          end
        end

        context 'stream open' do
          let(:state) { :open }
          it 'closes the stream and waits for graceful service close' do
            expect(stream).to receive(:data).with(payload, end_stream: true)
            expect(response.sync_queue).to receive(:pop)

            expect(subject.join).to be_truthy
          end
        end

        context 'stream half_closed_remote' do
          let(:state) { :half_closed_remote }
          it 'closes the stream and waits for graceful service close' do
            expect(stream).to receive(:data).with(payload, end_stream: true)
            expect(response.sync_queue).to receive(:pop)

            expect(subject.join).to be_truthy
          end
        end

        context 'stream half_closed_local' do
          let(:state) { :half_closed_local }
          it 'waits for graceful service close' do
            expect(stream).not_to receive(:data)
            expect(response.sync_queue).to receive(:pop)

            expect(subject.join).to be_truthy
          end
        end
      end

      describe '#kill' do
        it 'closes the stream' do
          expect(stream).to receive(:close)

          subject.kill
        end
      end

      describe '#send_event' do
        context 'stream open' do
          it 'sends the encoded data' do
            expect(stream).to receive(:data).with(payload, end_stream: false)

            subject.send(:send_event, Message.new)
          end
        end

        context 'stream closed' do
          let(:closed) { true }

          it 'sends the encoded data' do
            expect(stream).not_to receive(:data)

            expect do
              subject.send(:send_event, Message.new)
            end.to raise_error(ArgumentError)
          end
        end
      end
    end
  end
end
