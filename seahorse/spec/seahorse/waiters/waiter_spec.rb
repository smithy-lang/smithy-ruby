# frozen_string_literal: true

module Seahorse
  module Waiters
    describe Waiter do
      subject do
        Waiter.new(
          max_wait_time: 300,
          min_delay: 2,
          max_delay: 120,
          poller: poller
        )
      end

      let(:poller) { double('poller') }
      let(:client) { double('client') }

      let(:response_struct) { Struct.new(:member, keyword_init: true) }
      let(:response) { response_struct.new(member: 'foo') }

      let(:error) do
        Seahorse::ApiError.new(
          error_code: 'SomeError',
          message: 'error'
        )
      end

      describe '.initialize' do
        it 'raises without :max_wait_time' do
          expect { Waiter.new }.to raise_error(
            ArgumentError, 'Waiter must be initialized with `:max_wait_time`'
          )
        end
      end

      describe '#wait' do
        context 'poller returns retry' do
          it 'retries until max wait time exceeded' do
            allow(Kernel).to receive(:sleep)
            allow(poller).to receive(:call)
              .with(client, {}, {}).and_return([:retry, error])

            expect { subject.wait(client) }
              .to raise_error(Errors::MaxWaitTimeExceeded)
          end

          it 'retries polling using delay and backoff specification' do
            delays = [2, 3, 6, 6, 22, 62, 43, 24, 71, 42, 9, 6, 2]
            delays.each do |delay|
              expect(Kernel).to receive(:rand).and_return(delay)
              expect(Kernel).to receive(:sleep).with(delay)
            end

            expect(poller).to receive(:call)
              .with(client, {}, {}).and_return([:retry, error])
              .exactly(13 + 1).times

            expect { subject.wait(client) }
              .to raise_error(Errors::MaxWaitTimeExceeded)
          end

        end

        context 'poller returns success' do
          it 'returns true' do
            expect(poller).to receive(:call)
              .with(client, {}, {}).and_return([:success, response])

            expect(subject.wait(client)).to be true
          end
        end

        context 'poller returns failure' do
          context 'waiter expects response' do
            it 'raises with the response' do
              expect(poller).to receive(:call)
                .with(client, {}, {}).and_return([:failure, response])

              expect { subject.wait(client) }
                .to raise_error(Errors::FailureStateError, response.to_s)
            end
          end

          context 'waiter expects error' do
            it 'raises with the error' do
              expect(poller).to receive(:call)
                .with(client, {}, {}).and_return([:failure, error])

              expect { subject.wait(client) }
                .to raise_error(Errors::FailureStateError, error.to_s)
            end
          end
        end

        context 'poller returns error' do
          it 'raises an unexpected error' do
            expect(poller).to receive(:call)
              .with(client, {}, {}).and_return([:error, error])

            expect { subject.wait(client) }
              .to raise_error(Errors::UnexpectedError, error.to_s)
          end
        end
      end
    end
  end
end
