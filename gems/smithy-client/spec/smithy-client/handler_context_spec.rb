# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe HandlerContext do
      subject(:context) { HandlerContext.new }

      describe '#operation_name' do
        it 'defaults to nil' do
          expect(subject.operation_name).to be(nil)
        end

        it 'can be set in the constructor' do
          context = HandlerContext.new(operation_name: 'operation_name')
          expect(context.operation_name).to eq('operation_name')
        end
      end

      describe '#operation' do
        it 'defaults to nil' do
          expect(subject.operation).to be(nil)
        end

        it 'can be set in the constructor' do
          operation = Schema::Shapes::OperationShape.new
          context = HandlerContext.new(operation: operation)
          expect(context.operation).to be(operation)
        end
      end

      describe '#client' do
        it 'defaults to nil' do
          expect(subject.client).to be(nil)
        end

        it 'can be set in the constructor' do
          client = double('client')
          context = HandlerContext.new(client: client)
          expect(context.client).to be(client)
        end
      end

      describe '#params' do
        it 'defaults to an empty hash' do
          expect(subject.params).to eq({})
        end

        it 'can be set in the constructor' do
          params = { foo: 'bar' }
          context = HandlerContext.new(params: params)
          expect(context.params).to eq(params)
        end
      end

      describe '#config' do
        it 'defaults to nil' do
          expect(subject.config).to be(nil)
        end

        it 'can be set in the constructor' do
          config = Configuration.new.build!
          context = HandlerContext.new(config: config)
          expect(context.config).to be(config)
        end
      end

      describe '#http_request' do
        it 'defaults to Http::Request' do
          expect(subject.http_request).to be_a(Http::Request)
        end

        it 'can be set in the constructor' do
          http_request = double('http_request')
          context = HandlerContext.new(http_request: http_request)
          expect(context.http_request).to be(http_request)
        end
      end

      describe '#http_response' do
        it 'defaults to Http::Response' do
          expect(subject.http_response).to be_a(Http::Response)
        end

        it 'can be set in the constructor' do
          http_response = double('http_response')
          context = HandlerContext.new(http_response: http_response)
          expect(context.http_response).to be(http_response)
        end
      end

      describe '#retries' do
        it 'defaults to 0' do
          expect(subject.retries).to eq(0)
        end
      end

      context 'metadata' do
        it 'returns nil for non-set keys' do
          expect(subject[:color]).to be(nil)
        end

        it 'can be set via #[]=' do
          subject[:color] = 'red'
          expect(subject[:color]).to eq('red')
        end
      end
    end
  end
end
