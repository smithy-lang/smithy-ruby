# frozen_string_literal: true

module Hearth
  module Retry
    describe RetryQuota do
      describe '#checkout_capacity' do
        let(:error) { double('ErrorInspector', networking?: false) }

        it 'returns the requested capacity when available' do
          initial_capacity = subject.instance_variable_get(:@available_capacity)

          checked_out_capacity = subject.checkout_capacity(error)
          expect(checked_out_capacity).to eq(Retry::RetryQuota::RETRY_COST)

          expect(subject.instance_variable_get(:@available_capacity))
            .to eq(initial_capacity - checked_out_capacity)
        end

        it 'checks out the timeout cost when the error is a networking error' do
          error = double('ErrorInspector', networking?: true)

          checked_out_capacity = subject.checkout_capacity(error)
          expect(checked_out_capacity)
            .to eq(Retry::RetryQuota::TIMEOUT_RETRY_COST)
        end

        it 'returns 0 when there is insufficient capacity' do
          subject.instance_variable_set(:@available_capacity, 1)

          expect(subject.checkout_capacity(error)).to eq(0)
        end
      end

      describe '#release' do
        it 'releases the capacity back to available capacity' do
          subject.instance_variable_set(:@available_capacity, 0)

          subject.release(1)

          expect(subject.instance_variable_get(:@available_capacity)).to be 1
        end

        it 'releases NO_RETRY_INCREMENT back to available capacity when '\
           'capacity_amount is not set' do
          subject.instance_variable_set(:@available_capacity, 0)

          subject.release(nil)

          expect(subject.instance_variable_get(:@available_capacity))
            .to be Retry::RetryQuota::NO_RETRY_INCREMENT
        end

        it 'does not increase available_capacity above max_capacity' do
          subject.instance_variable_set(
            :@available_capacity,
            subject.instance_variable_get(:@max_capacity) - 1
          )

          subject.release(2)

          expect(subject.instance_variable_get(:@available_capacity))
            .to be subject.instance_variable_get(:@max_capacity)
        end
      end
    end
  end
end
