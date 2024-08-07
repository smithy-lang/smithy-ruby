# frozen_string_literal: true

module Hearth
  module Middleware
    describe EventStreams do
      let(:app) { double('app', call: output) }

      let(:request_events) { false }
      let(:response_events) { false }
      let(:async_output_class) { double }
      let(:event_handler) { double }
      let(:message_encoding_module) { double }

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
        let(:output) { double('output') }
        let(:request) { double('request') }
        let(:response) { double('response') }
        let(:logger) { Logger.new(IO::NULL) }
        let(:config) { double('config', logger: logger) }
        let(:context) do
          Context.new(request: request, response: response, config: config)
        end

        context 'request_events' do
          let(:request_events) { true }

          it 'sets up the request encoder and handler' do
          end
        end
      end
    end
  end
end
