require 'seahorse/http/networking_error'

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

      describe '#original_error' do
        it 'gets the original_error field' do
          expect(subject.original_error).to be original_error
        end
      end
    end
  end
end
