# frozen_string_literal: true

module Smithy
  module Client
    describe Signer do
      it 'defines the interface' do
        expect { subject.sign }.to raise_error(NotImplementedError)
        expect { subject.reset }.to raise_error(NotImplementedError)
      end
    end
  end
end
