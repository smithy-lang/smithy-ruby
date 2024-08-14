# frozen_string_literal: true

module Hearth
  module Middleware
    describe EventStreams do
      let(:app) { double('app', call: output) }

      let(:request_events) { false }
      let(:response_events) { false }
      let(:async_output) { double }
      let(:async_output_class) { double(new: async_output) }
      let(:event_handler) { double }
      let(:message_encoding_module) { EventStream::Binary }

      subject do
        EventStreams.new(
          app,
          request_events: request_events,
          response_events: response_events,
          async_output_class: async_output_class,
          event_handler: event_handler,
          message_encoding_module: message_encoding_module
        )
      end

      describe '#call' do
        let(:input) { double('input') }
        let(:error) { nil }
        let(:metadata) { {} }
        let(:output) { double('output', error: error, metadata: metadata) }
        let(:request) { HTTP2::Request.new }
        let(:response) { HTTP2::Response.new }
        let(:logger) { Logger.new(IO::NULL) }
        let(:config) { double('config', logger: logger) }
        let(:context) do
          Context.new(request: request, response: response, config: config)
        end

        context 'request_events' do
          let(:request_events) { true }

          it 'sets up the request encoder and output' do
            expect(async_output_class).to receive(:new).with(
              response: response,
              encoder: instance_of(EventStream::Encoder),
              metadata: metadata
            )
                                                       .and_return(async_output)

            resp = subject.call(input, context)

            expect(resp).to eq(async_output)
            expect(request.body).to be_a(EventStream::Encoder)
            expect(request.keep_open).to be_truthy
          end

          context 'initial response body' do
            let(:message) { EventStream::Message.new }
            let(:request) { HTTP2::Request.new(body: message) }

            it 'sets up the encoder with the initial message' do
              expect(async_output_class).to receive(:new)
              expect(EventStream::EncoderWithInitialMessage)
                .to receive(:new).with(
                  message_encoder:
                    instance_of(EventStream::Binary::MessageEncoder),
                  initial_event: message
                ).and_call_original

              subject.call(input, context)

              expect(request.body)
                .to be_a(EventStream::EncoderWithInitialMessage)
            end
          end
        end

        context 'response_events' do
          let(:response_events) { true }

          it 'sets up the response decoder' do
            expect(EventStream::Decoder).to receive(:new)
              .with(
                message_decoder:
                  instance_of(EventStream::Binary::MessageDecoder),
                event_handler: event_handler
              ).and_call_original
            subject.call(input, context)

            expect(response.body).to be_a(EventStream::Decoder)
          end
        end
      end
    end
  end
end
