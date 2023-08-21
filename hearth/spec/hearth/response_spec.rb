# frozen_string_literal: false

module Hearth
  describe Response do
    describe '#initialize' do
      it 'sets empty defaults' do
        response = Response.new
        expect(response.body).to be_a(StringIO)
      end
    end

    describe '#reset' do
      it 'resets the body' do
        response = Response.new
        response.body.write('foo')
        response.reset
        expect(response.body.string).to eq('')
      end
    end
  end
end
