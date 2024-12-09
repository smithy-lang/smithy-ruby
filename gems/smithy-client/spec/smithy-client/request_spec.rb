# frozen_string_literal: true

require 'stringio'
require 'uri'

module Smithy
  module Client
    describe Request do
      let(:endpoint) { 'https://example.com' }
      let(:body) { 'body' }

      subject { Request.new(endpoint: endpoint, body: body) }

      describe '#initialize' do
        it 'sets the endpoint as a uri' do
          expect(subject.endpoint).to be_a(URI)
        end

        it 'sets the body as a StringIO' do
          expect(subject.body).to be_a(StringIO)
        end
      end

      describe '#endpoint=' do
        it 'sets a uri as the endpoint' do
          uri = URI('https://example.com')
          subject.endpoint = uri
          expect(subject.endpoint).to eq(uri)
        end

        it 'sets a string endpoint' do
          subject.endpoint = 'https://example.com'
          expect(subject.endpoint).to eq(URI.parse(endpoint))
        end

        it 'raises when endpoint is not a uri' do
          expect { subject.endpoint = 'generic' }
            .to raise_error(ArgumentError)
        end
      end

      describe '#body=' do
        it 'sets a string body as a StringIO' do
          subject.body = 'string'
          expect(subject.body.string).to eq('string')
        end

        it 'sets a nil body as a StringIO' do
          subject.body = nil
          expect(subject.body.string).to eq('')
        end

        it 'sets anything else to the body' do
          io = StringIO.new('body')
          subject.body = io
          expect(subject.body.string).to eq('body')
        end
      end
    end
  end
end