# frozen_string_literal: false

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

      describe '#replace' do
        it 'replaces the response' do
          response = Response.new(
            body: StringIO.new('foo'),
            reason: 'Because',
            status: 200,
            fields: Fields.new([Field.new('key', 'value')])
          )
          other = Response.new(
            body: StringIO.new('bar'),
            reason: 'Because I said so',
            status: 400,
            fields: Fields.new([Field.new('key2', 'value2')])
          )

          response.replace(other)
          expect(response.status).to eq(400)
          expect(response.headers['key']).to be_nil
          expect(response.headers['key2']).to eq('value2')
          expect(response.reason).to eq('Because I said so')
          expect(response.body.read).to eq('bar')
        end
      end

      describe '#reset' do
        it 'resets to defaults' do
          response = Response.new(
            reason: 'Because',
            status: 200,
            fields: Fields.new([Field.new('key', 'value')])
          )
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
