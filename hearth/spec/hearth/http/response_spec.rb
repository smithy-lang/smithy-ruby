# frozen_string_literal: true

module Hearth
  module HTTP
    describe Response do
      describe '#initialize' do
        it 'sets empty defaults' do
          response = Response.new
          expect(response.body).to be_a(StringIO)
          expect(response.status).to eq(0)
          expect(response.fields).to be_a(Fields)
          expect(response.body).to be_a(StringIO)
        end
      end

      describe '#reset' do
        it 'resets to defaults' do
          response = Response.new(
            reason: 'Because',
            status: 200,
            fields: Fields.new([Field.new('key', 'value')])
          )
          response.headers['key'] = 'value'
          response.body << 'foo bar' # frozen string literal, cannot pass in
          response.reset
          expect(response.status).to eq(0)
          expect(response.fields.size).to eq(0)
          expect(response.reason).to be_nil
          response.body.rewind # ensure nothing is there when we read
          expect(response.body.read).to eq('')
        end
      end
    end
  end
end
