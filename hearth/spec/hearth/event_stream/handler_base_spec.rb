# frozen_string_literal: true

module Hearth
  module EventStream
    describe HandlerBase do
      let(:handler1) { proc {} }
      let(:handler2) { proc {} }
      let(:message_type) { 'event' }
      let(:error_code) { nil }
      let(:error_message) { nil }
      let(:event_type) { nil }
      let(:exception_type) { nil }

      let(:message) do
        headers = {}
        headers[':message-type'] = message_type if message_type
        headers[':error-code'] = error_code if error_code
        headers[':error-message'] = error_message if error_message
        headers[':event-type'] = event_type if event_type
        headers[':exception-type'] = exception_type if exception_type
        headers.each do |k, v|
          headers[k] = HeaderValue.new(value: v, type: 'string')
        end

        Message.new(
          headers: headers
        )
      end

      subject do
        Class.new(HandlerBase) do
          def parse_event(_, _); end
          def parse_error_event(_); end
        end.new
      end

      describe '#emit_headers' do
        let(:headers) { {} }

        it 'calls registered header handlers' do
          subject.on_headers(&handler1)
          subject.on_headers(&handler2)
          expect(handler1).to receive(:call).with(headers)
          expect(handler2).to receive(:call).with(headers)

          subject.emit_headers(headers)
        end
      end

      describe '#emit' do
        context 'raised exception' do
          let(:exception) { StandardError.new }
          it 'calls registered error handlers' do
            allow(subject).to receive(:parse_event)
              .and_raise(exception)

            subject.on_error(&handler1)
            subject.on_error(&handler2)
            expect(handler1).to receive(:call).with(exception)
            expect(handler2).to receive(:call).with(exception)

            subject.emit(message)
          end
        end

        context 'error event' do
          let(:message_type) { 'error' }
          let(:error_code) { 'error_code' }
          let(:error_message) { 'error_message' }
          let(:error) { double }

          it 'calls registered error_event handlers' do
            subject.on_error(&handler1)
            subject.on_error(&handler2)
            expect(handler1).to receive(:call).with(error)
            expect(handler2).to receive(:call).with(error)

            expect(subject).to receive(:parse_error_event)
              .with(message).and_return(error)
            subject.emit(message)
          end
        end

        context 'exception event' do
          let(:message_type) { 'exception' }
          let(:exception_type) { 'MyException' }
          let(:exception_class) { Class.new }
          let(:exception_event) { exception_class.new }

          it 'calls registered MyException handlers' do
            subject.send(:on, exception_class, handler1)
            expect(subject).to receive(:parse_event)
              .with(exception_type, message)
              .and_return(exception_event)
            expect(handler1).to receive(:call).with(exception_event)

            subject.emit(message)
          end
        end

        context 'regular event' do
          let(:message_type) { 'event' }
          let(:event_type) { 'MyEvent' }
          let(:event_class) { Class.new }
          let(:event) { event_class.new }

          it 'calls registered MyEvent handlers' do
            subject.send(:on, event_class, handler1)
            expect(subject).to receive(:parse_event)
              .with(event_type, message)
              .and_return(event)
            expect(handler1).to receive(:call).with(event)

            subject.emit(message)
          end

          it 'calls raw message handlers' do
            subject.on_raw_event(&handler1)
            expect(subject).to receive(:parse_event)
              .with(event_type, message)
              .and_return(event)
            expect(handler1).to receive(:call).with(message)

            subject.emit(message)
          end
        end
      end
    end
  end
end
