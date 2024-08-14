# frozen_string_literal: true

module Hearth
  module HTTP2
    describe Request do
      let(:keep_open) { true }

      subject do
        Request.new(
          keep_open: keep_open
        )
      end

      describe '#initialize' do
        it 'defaults keep_open to false' do
          request = Request.new
          expect(request.keep_open).to be_falsey
        end
      end

      describe '#keep_open' do
        it 'returns keep_open' do
          expect(subject.keep_open).to eq(keep_open)
        end
      end
    end
  end
end
