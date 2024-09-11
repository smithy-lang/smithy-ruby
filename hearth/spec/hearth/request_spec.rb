# frozen_string_literal: true

module Hearth
  describe Request do
    describe '#initialize' do
      it 'sets empty defaults' do
        request = Request.new
        expect(request.body).to be_a(StringIO)
        expect(request.uri).to be_a(URI)
      end
    end

    describe '#span_attributes' do
      it 'returns empty hash' do
        request = Request.new
        expect(request.span_attributes).to be_empty
      end
    end
  end
end
