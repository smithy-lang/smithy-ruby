# frozen_string_literal: true

module Hearth
  module HTTP
    describe Request do
      let(:http_method) { :get }
      let(:uri) { URI('http://example.com') }
      let(:fields) { Fields.new({ 'key' => 'value' }) }
      let(:body) { 'body' }

      subject do
        Request.new(
          http_method: http_method,
          uri: uri,
          fields: fields,
          body: body
        )
      end

      describe '#initialize' do
        it 'sets empty defaults' do
          request = Request.new
          expect(request.http_method).to be_nil
          expect(request.fields).to be_a(Fields)
          expect(request.body).to be_a(StringIO)
          expect(request.uri).to be_a(URI)
        end
      end

      describe '#headers' do
        it 'allows setting of headers' do
          request = Request.new
          request.headers['name'] = 'value'
          expect(request.fields['name'].value).to eq('value')
          expect(request.fields['name'].kind).to eq(:header)
        end

        it 'allows appending to headers' do
          request = Request.new
          request.headers['name'] = 'value'
          request.headers['name'] << 'value2'
          expect(request.fields['name'].value).to eq('value,value2')
          expect(request.fields['name'].kind).to eq(:header)
        end

        it 'lets you get a hash of only the headers' do
          request = Request.new
          request.headers['name'] = 'value'
          request.trailers['trailer'] = 'trailer-value'
          expect(request.headers.to_h).to eq({'name' => 'value'})
        end
      end

      describe '#trailers' do
        it 'allows setting of trailers' do
          request = Request.new
          request.trailers['name'] = 'value'
          expect(request.fields['name'].value).to eq('value')
          expect(request.fields['name'].kind).to eq(:trailer)
        end
      end

      describe '#append_path' do
        it 'appends to the uri' do
          subject.append_path('test')
          expect(subject.uri.to_s).to eq('http://example.com/test')
        end

        it 'removes trailing slash' do
          subject.uri += '/'
          subject.append_path('test')
          expect(subject.uri.to_s).to eq('http://example.com/test')
        end

        it 'removes prefix slash' do
          subject.append_path('/test')
          expect(subject.uri.to_s).to eq('http://example.com/test')
        end
      end

      describe '#append_query_param' do
        it 'appends a single value' do
          subject.append_query_param('test')
          expect(subject.uri.to_s).to eq('http://example.com?test')
        end

        it 'appends a pair of values' do
          subject.append_query_param('test', 'value')
          expect(subject.uri.to_s).to eq('http://example.com?test=value')
        end

        it 'raises an ArgumentError for invalid number of arguments' do
          expect { subject.append_query_param('test', 'value', 'invalid') }
            .to raise_error(ArgumentError)
        end

        it 'appends to existing query params' do
          subject.append_query_param('test', 'value')
          subject.append_query_param('test2')
          expect(subject.uri.to_s).to eq('http://example.com?test=value&test2')
        end

        it 'uri escapes parameters and values' do
          subject.append_query_param('test space', 'test/value')
          expect(subject.uri.to_s)
            .to eq('http://example.com?test%20space=test%2Fvalue')
        end
      end

      describe '#append_query_param_list' do
        it 'appends a param list' do
          subject.append_query_param('original')
          params = Hearth::Query::ParamList.new
          params['key 1'] = nil
          params['key 2'] = ''
          params['key 3'] = 'value'
          params['key 4'] = %w[value value2]
          subject.append_query_param_list(params)
          expect(subject.uri.to_s)
            .to eq('http://example.com?original&key%201&key%202=&key%203=value&key%204=value&key%204=value2')
        end
      end

      describe '#prefix_host' do
        it 'prefixes the host' do
          subject.prefix_host('data.')
          expect(subject.uri.to_s).to eq('http://data.example.com')
        end
      end
    end
  end
end
