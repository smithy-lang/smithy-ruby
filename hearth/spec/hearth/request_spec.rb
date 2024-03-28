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
  end
end
