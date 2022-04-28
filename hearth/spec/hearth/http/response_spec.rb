# frozen_string_literal: true

module Hearth
  module HTTP
    describe Response do
      describe '#initialize' do
        it 'sets empty defaults' do
          response = Response.new
          expect(response.status).to eq(0)
          expect(response.headers).to be_a(Headers)
          expect(response.body).to be_a(StringIO)
        end
      end

      describe '#reset' do
        it 'resets to defaults' do
          response = Response.new(
            status: 200,
            headers: Headers.new(headers: { 'key' => 'value' })
          )
          response.body << 'foo bar' # frozen string literal, cannot pass in
          response.reset
          expect(response.status).to eq(0)
          expect(response.headers.size).to eq(0)
          response.body.rewind # ensure nothing is there when we read
          expect(response.body.read).to eq('')
        end
      end
    end
  end
end
