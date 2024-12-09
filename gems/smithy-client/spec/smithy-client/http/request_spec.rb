# frozen_string_literal: true

module Smithy
  module Client
    module HTTP
      describe Request do
        subject { Request.new }

        describe '#initialize' do
          it 'sets empty defaults' do
            request = Request.new
            expect(request.http_method).to eq('GET')
            expect(request.fields).to be_a(Fields)
            expect(request.body).to be_a(StringIO)
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
      end
    end
  end
end
