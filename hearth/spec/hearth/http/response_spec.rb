# frozen_string_literal: true

module Hearth
  module HTTP
    describe Response do
      describe '#initialize' do
        it 'sets empty defaults' do
          response = Response.new
          expect(response.status).to eq 0
          expect(response.headers).to be_a Headers
          expect(response.body).to be_a StringIO
        end
      end
    end
  end
end
