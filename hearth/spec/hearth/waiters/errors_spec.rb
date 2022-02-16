# frozen_string_literal: true

module Hearth
  module Waiters
    module Errors
      describe WaiterFailed do
        it 'subclasses StandardError' do
          expect(WaiterFailed.new).to be_a StandardError
        end
      end

      describe FailureStateError do
        it 'subclasses StandardError' do
          expect(FailureStateError.new).to be_a StandardError
        end
      end

      describe UnexpectedError do
        it 'subclasses StandardError' do
          expect(UnexpectedError.new).to be_a StandardError
        end
      end

      describe MaxWaitTimeExceeded do
        it 'subclasses StandardError' do
          expect(MaxWaitTimeExceeded.new).to be_a StandardError
        end
      end
    end
  end
end
