# frozen_string_literal: true

require 'seahorse/middleware/retry'

module Seahorse
  module Middleware
    describe Retry do
      let(:app) { double('app') }
      let(:max_attempts) { 4 }
      let(:max_delay) { 10 }

      subject do
        Retry.new(
          app,
          max_attempts: max_attempts,
          max_delay: max_delay
        )
      end

      describe '#call' do
        let(:request) { Seahorse::HTTP::Request.new }
        let(:response) { Seahorse::HTTP::Response.new }
        let(:context) { {} }
        let(:output) { Seahorse::Output.new }

        it 'calls the next middleware' do
          expect(app).to receive(:call).with(
            request: request,
            response: response,
            context: context
          )

          subject.call(
            request: request,
            response: response,
            context: context
          )
        end

        context 'middleware raises NetworkingError' do
          let(:error) { Seahorse::HTTP::NetworkingError.new(StandardError.new) }

          it 'retries with exponential backoff and jitter' do
            expect(app).to receive(:call).with(
              request: request,
              response: response,
              context: context
            ).and_raise(error).exactly(4).times
            allow(Kernel).to receive(:rand).and_return(1)
            expect(Kernel).to receive(:sleep).with(1)
            expect(Kernel).to receive(:sleep).with(2)
            expect(Kernel).to receive(:sleep).with(4)

            expect do
              subject.call(
                request: request,
                response: response,
                context: context
              )
            end.to raise_error(error)
          end

          it 'retries up to max_attempts times' do
            expect(app).to receive(:call).with(
              request: request,
              response: response,
              context: context
            ).and_raise(error).exactly(4).times
            allow(Kernel).to receive(:sleep)

            expect do
              subject.call(
                request: request,
                response: response,
                context: context
              )
            end.to raise_error(error)
          end

          context 'max_delay' do
            let(:max_delay) { 1 }

            it 'backoff is bounded by max_delay' do
              expect(app).to receive(:call).with(
                request: request,
                response: response,
                context: context
              ).and_raise(error).exactly(4).times
              allow(Kernel).to receive(:rand).and_return(1)
              expect(Kernel).to receive(:sleep).with(1).exactly(3).times

              expect do
                subject.call(
                  request: request,
                  response: response,
                  context: context
                )
              end.to raise_error(error)
            end
          end
        end
      end
    end
  end
end
