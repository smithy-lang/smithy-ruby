require 'seahorse/http'

module Seahorse
  module HTTP
    describe Response do
      let(:status_code) { 242 }
      let(:headers) { Headers.new(headers: { 'key' => 'value' }) }
      let(:body) { 'body' }

      subject do
        Response.new(status_code: status_code, headers: headers, body: body)
      end

      describe '#initialize' do
        it 'sets empty defaults' do
          response = Response.new
          expect(response.status_code).to eq 200
          expect(response.headers).to be_a Headers
          expect(response.body).to be_a StringIO
        end
      end

      describe '#status_code' do
        it 'gets the status_code field' do
          expect(subject.status_code).to be status_code
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
    end
  end
end
