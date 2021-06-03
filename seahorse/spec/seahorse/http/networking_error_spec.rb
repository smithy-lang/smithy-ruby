# frozen_string_literal: true

module Seahorse
  module HTTP
    describe NetworkingError do
      let(:original_message) { 'ORIG-MESSAGE' }
      let(:original_error) { StandardError.new(original_message) }

      subject { NetworkingError.new(original_error) }

      it 'subclasses StandardError' do
        expect(subject).to be_a StandardError
      end

      it 'adds to the original errors message' do
        expect(subject.message).to include(original_message)
      end
    end
  end
end
