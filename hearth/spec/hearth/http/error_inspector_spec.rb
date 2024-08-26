# frozen_string_literal: true

module Hearth
  module HTTP
    describe ErrorInspector do
      subject { ErrorInspector.new(error, http_resp) }

      let(:http_status) { 404 }
      let(:http_resp) do
        Hearth::HTTP::Response.new(status: http_status)
      end
      let(:message) { 'message' }

      let(:error) do
        Hearth::ApiError.new(
          error_code: 'error_code',
          metadata: {},
          message: message
        )
      end

      describe '#retryable?' do
        it 'does not retry basic errors' do
          expect(subject.retryable?).to be false
        end

        context 'error is a server error' do
          let(:http_status) { 500 }

          it 'returns true' do
            expect(subject.retryable?).to be true
          end
        end

        context 'error is modeled as retryable' do
          before { allow(error).to receive(:retryable?).and_return(true) }

          it 'returns true' do
            expect(subject.retryable?).to be true
          end
        end

        context 'error has 429 status code' do
          let(:http_status) { 429 }

          it 'returns true' do
            expect(subject.retryable?).to be true
          end
        end

        context 'error is modeled as throttling' do
          before do
            allow(error).to receive(:retryable?).and_return(true)
            allow(error).to receive(:throttling?).and_return(true)
          end

          it 'returns true' do
            expect(subject.retryable?).to be true
          end
        end

        context 'error is transient' do
          let(:error) { Hearth::HTTP::NetworkingError.new(StandardError.new) }

          it 'returns true' do
            expect(subject.retryable?).to be true
          end
        end
      end

      describe '#error_type' do
        context 'transient error' do
          let(:error) { Hearth::HTTP::NetworkingError.new(StandardError.new) }

          it 'returns Transient' do
            expect(subject.error_type).to eq 'Transient'
          end
        end

        context 'throttling error' do
          context 'error has 429 status code' do
            let(:http_status) { 429 }

            it 'returns Throttling' do
              expect(subject.error_type).to eq 'Throttling'
            end
          end

          context 'error is modeled as throttling' do
            before do
              allow(error).to receive(:retryable?).and_return(true)
              allow(error).to receive(:throttling?).and_return(true)
            end

            it 'returns Throttling' do
              expect(subject.error_type).to eq 'Throttling'
            end
          end
        end

        context 'server error' do
          let(:http_status) { 500 }

          it 'returns ServerError' do
            expect(subject.error_type).to eq 'ServerError'
          end
        end

        context 'client error' do
          let(:http_status) { 404 }

          it 'returns ServerError' do
            expect(subject.error_type).to eq 'ClientError'
          end
        end

        context 'unknown type error' do
          let(:http_status) { 307 }

          it 'returns ServerError' do
            expect(subject.error_type).to eq 'Unknown'
          end
        end
      end

      describe '#hints' do
        context 'retry_after_hint' do
          context 'header is an integer' do
            it 'hint returns an integer delay' do
              http_resp.headers['retry-after'] = '123'
              expect(subject.hints[:retry_after]).to eq(123)
            end
          end

          context 'header is a date' do
            let(:time) { Time.new(2023, 1, 24) }
            let(:retry_after_time) { (time + 123).httpdate }

            it 'hint returns an integer delay' do
              http_resp.headers['retry-after'] = retry_after_time
              allow(Time).to receive(:now).and_return(time)
              expect(subject.hints[:retry_after]).to eq(123)
            end
          end

          context 'header is nil' do
            it 'no hint' do
              http_resp.headers['retry-after'] = nil
              expect(subject.hints.key?(:retry_after)).to eq(false)
            end
          end

          context 'header is an empty string' do
            it 'no hint' do
              http_resp.headers['retry-after'] = ''
              expect(subject.hints.key?(:retry_after)).to eq(false)
            end
          end
        end
      end
    end
  end
end
