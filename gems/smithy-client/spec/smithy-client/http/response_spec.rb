# frozen_string_literal: true

module Smithy
  module Client
    module HTTP
      describe Response do
        describe '#initialize' do
          it 'sets empty defaults' do
            response = Response.new
            expect(response.status).to eq(0)
            expect(response.fields).to be_a(Fields)
            expect(response.body).to be_a(StringIO)
          end
        end

        describe '#headers' do
          it 'allows setting of headers' do
            subject.headers['name'] = 'value'
            expect(subject.fields['name'].value).to eq('value')
            expect(subject.fields['name'].kind).to eq(:header)
          end

          it 'lets you get a hash of only the headers' do
            subject.headers['name'] = 'value'
            subject.trailers['trailer'] = 'trailer-value'
            expect(subject.headers.to_h).to eq('name' => 'value')
          end
        end

        describe '#trailers' do
          it 'allows setting of trailers' do
            subject.trailers['name'] = 'value'
            expect(subject.fields['name'].value).to eq('value')
            expect(subject.fields['name'].kind).to eq(:trailer)
          end

          it 'lets you get a hash of only the trailers' do
            subject.trailers['name'] = 'value'
            subject.headers['header'] = 'header-value'
            expect(subject.trailers.to_h).to eq('name' => 'value')
          end
        end

        describe '#reset' do
          it 'resets to defaults' do
            response = Response.new(
              status: 200,
              fields: Fields.new([Field.new('key', 'value')]),
              body: StringIO.new
            )
            response.body << 'foo bar' # frozen string literal, cannot pass in
            response.reset

            expect(response.status).to eq(0)
            expect(response.fields.size).to eq(0)
            response.body.rewind # ensure nothing is there when we read
            expect(response.body.read).to eq('')
          end
        end
      end
    end
  end
end
