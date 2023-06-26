# frozen_string_literal: true

module Hearth
  describe Response do
    describe '#initialize' do
      it 'sets empty defaults' do
        response = Response.new
        expect(response.body).to be_a(StringIO)
      end
    end
  end
end
