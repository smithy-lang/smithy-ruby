require 'seahorse/http'

module Seahorse
  module HTTP
    describe Request do
      let(:http_method) { :get }
      let(:url) { 'http://example.com' }
      let(:headers) { Headers.new(headers: { 'key' => 'value' }) }
      let(:body) { 'body' }

      subject do
        Request.new(
          http_method: http_method,
          url: url,
          headers: headers,
          body: body
        )
      end

      describe '#initialize' do
        it 'sets empty defaults' do
          request = Request.new
          expect(request.http_method).to be_nil
          expect(request.url).to be_nil
          expect(request.headers).to be_a Headers
          expect(request.body).to be_a StringIO
        end
      end

      describe '#http_method' do
        it 'gets the http_method field' do
          expect(subject.http_method).to be http_method
        end
      end

      describe '#url' do
        it 'gets the url field' do
          expect(subject.url).to be url
        end
      end

      describe '#headers' do
        it 'gets the headers field' do
          expect(subject.headers).to be headers
        end
      end

      describe '#body' do
        it 'gets the body field' do
          expect(subject.body).to be body
        end
      end

      describe '#append_path' do
        it 'appends to the url' do
          subject.append_path('test')
          expect(subject.url).to eq('http://example.com/test')
        end

        it 'removes trailing slash' do
          subject.url += '/'
          subject.append_path('test')
          expect(subject.url).to eq('http://example.com/test')
        end

        it 'removes prefix slash' do
          subject.append_path('/test')
          expect(subject.url).to eq('http://example.com/test')
        end
      end

      describe '#append_query_param' do
        it 'appends a single value' do
          subject.append_query_param('test')
          expect(subject.url).to eq('http://example.com?test')
        end

        it 'appends a pair of values' do
          subject.append_query_param('test', 'value')
          expect(subject.url).to eq('http://example.com?test=value')
        end

        it 'raises an ArgumentError for invalid number of arguments' do
          expect { subject.append_query_param('test', 'value', 'invlaid') }
            .to raise_error(ArgumentError)
        end

        it 'appends to existing query params' do
          subject.append_query_param('test', 'value')
          subject.append_query_param('test2')
          expect(subject.url).to eq('http://example.com?test=value&test2')
        end

        it 'url escapes parameters and values' do
          subject.append_query_param('test space', 'test/value')
          expect(subject.url)
            .to eq('http://example.com?test%20space=test%2Fvalue')
        end
      end

      describe '#prefix_host' do
        it 'prefixes the host' do
          subject.prefix_host('data.')
          expect(subject.url).to eq('http://data.example.com')
        end
      end
    end
  end
end
