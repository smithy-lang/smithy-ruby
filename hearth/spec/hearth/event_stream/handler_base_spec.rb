# frozen_string_literal: true

module Hearth
  module EventStream
    describe HandlerBase do
      let(:handler_1) { proc {} }
      let(:handler_2) { proc {} }
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
        headers.each do |k,v|
          headers[k] = HeaderValue.new(value: v, type: 'string')
        end

        Message.new(
          headers: headers
        )
      end

      subject do
        Class.new(HandlerBase) do
          def parse_event(_, _); end
        end.new
      end

      describe '#emit_headers' do
        let(:headers) { {} }

        it 'calls registered header handlers' do
          subject.on_headers(&handler_1)
          subject.on_headers(&handler_2)
          expect(handler_1).to receive(:call).with(headers)
          expect(handler_2).to receive(:call).with(headers)

          subject.emit_headers(headers)
        end
      end

      describe '#emit' do
        context 'raised exception' do
          let(:exception) { StandardError.new }
          it 'calls registered error handlers' do

            allow(subject).to receive(:parse_event)
                                .and_raise(exception)

            subject.on_error(&handler_1)
            subject.on_error(&handler_2)
            expect(handler_1).to receive(:call).with(exception)
            expect(handler_2).to receive(:call).with(exception)

            subject.emit(message)
          end
        end

        context 'error event' do
          let(:message_type) { 'error' }
          let(:error_code) { 'error_code' }
          let(:error_message) { 'error_message' }

          it 'calls registered error_event handlers' do
            subject.on_error_event(&handler_1)
            subject.on_error_event(&handler_2)
            expect(handler_1).to receive(:call).with(error_code, error_message)
            expect(handler_2).to receive(:call).with(error_code, error_message)

            subject.emit(message)
          end
        end

        context 'exception event' do
          let(:message_type) { 'exception' }
          let(:exception_type) { 'MyException' }
          let(:exception_class) { Class.new }
          let(:exception_event) { exception_class.new }

          # TODO: Exception event handling is ALL MESSED UP!
          it 'calls registered MyException handlers' do
            subject.send(:on, exception_class, handler_1)
            expect(subject).to receive(:parse_event)
                                 .with(exception_type, message)
                                 .and_return(exception_event)
            expect(handler_1).to receive(:call).with(exception_event)


            subject.emit(message)
          end
        end
      end
    end
  end
end
