# frozen_string_literal: true

module Hearth
  module Retry
    describe ErrorInspector do
      subject { ErrorInspector.new(error, http_status) }

      let(:http_status) { 404 }
      let(:http_fields) { Hearth::HTTP::Fields.new }
      let(:http_resp) do
        Hearth::HTTP::Response.new(
          status: http_status,
          fields: http_fields
        )
      end
      let(:message) { 'message' }

      let(:error) do
        Hearth::HTTP::ApiError.new(
          http_resp: http_resp,
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

        context 'error is networking' do
          let(:error) { Hearth::HTTP::NetworkingError.new(StandardError.new) }

          it 'returns true' do
            expect(subject.retryable?).to be true
          end
        end
      end

      describe '#error_type' do
        context 'networking error' do
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
    end
  end
end
