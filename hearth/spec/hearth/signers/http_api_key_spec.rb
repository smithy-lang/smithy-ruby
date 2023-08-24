# frozen_string_literal: true

module Hearth
  module Signers
    describe HTTPApiKey do
      let(:request) { HTTP::Request.new }
      let(:identity) { Identities::HTTPApiKey.new(key: key) }
      let(:key) { 'key' }

      describe '#sign' do
        context 'header' do
          let(:properties) do
            { name: 'X-Api-Key', in: 'header', scheme: 'OAuth' }
          end

          it 'signs the request' do
            expect(request.headers['x-api-key']).to be_nil
            subject.sign(
              request: request,
              identity: identity,
              properties: properties
            )
            expect(request.headers['x-api-key']).to eq("OAuth #{key}")
          end
        end

        context 'query' do
          let(:properties) do
            { name: 'api_key', in: 'query' }
          end

          it 'signs the request' do
            expect(request.uri.query).to be_nil
            subject.sign(
              request: request,
              identity: identity,
              properties: properties
            )
            expect(request.uri.query).to eq("api_key=#{key}")
          end
        end
      end

      describe '#reset' do
        context 'header' do
          let(:properties) do
            { name: 'X-Api-Key', in: 'header', scheme: 'OAuth' }
          end

          it 'resets the request' do
            request.headers['x-api-key'] = 'OAuth key'
            subject.reset(request: request, properties: properties)
            expect(request.headers['x-api-key']).to be_nil
          end
        end

        context 'query' do
          let(:properties) do
            { name: 'api_key', in: 'query' }
          end

          it 'resets the request' do
            request.uri.query = 'api_key=key'
            subject.reset(request: request, properties: properties)
            expect(request.uri.query).to eq('')
          end
        end
      end
    end
  end
end
