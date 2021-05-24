# frozen_string_literal: true

module Seahorse
  module HTTP

    describe Response do
      let(:status) { 242 }
      let(:headers) { Headers.new(headers: { 'key' => 'value' }) }
      let(:body) { 'body' }

      subject do
        Response.new(status: status, headers: headers, body: body)
      end

      describe '#initialize' do
        it 'sets empty defaults' do
          response = Response.new
          expect(response.status).to eq 200
          expect(response.headers).to be_a Headers
          expect(response.body).to be_a StringIO
        end
      end
    end

  end
end
