# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe ServiceError do
      let(:context) { HandlerContext.new }
      let(:data) { double('Structure') }
      let(:code) { 'ServiceErrorCode' }

      subject { ServiceError.new(context, data) }

      before { ServiceError.code = code }

      it 'is a subclass of RuntimeError' do
        expect(ServiceError.superclass).to be(RuntimeError)
      end

      describe '#initialize' do
        it 'sets the code using the class accessor' do
          expect(subject.code).to be(ServiceError.code)
        end

        it 'sets the context' do
          expect(subject.context).to be(context)
        end

        it 'sets the data' do
          expect(subject.data).to be(data)
        end

        it 'parses a message from data' do
          data = double('Structure', message: 'message')
          subject = ServiceError.new(context, data)
          expect(subject.message).to be('message')
        end

        it 'defaults the message to the class name' do
          expect(subject.message).to include('ServiceError')
        end
      end

      describe '#data=' do
        it 'sets the data' do
          data = double('Structure')
          subject.data = data
          expect(subject.data).to eq(data)
        end
      end

      describe '.code' do
        it 'returns the code' do
          expect(ServiceError.code).to eq(code)
        end
      end

      describe '#retryable?' do
        it 'defaults to false' do
          expect(subject.retryable?).to be(false)
        end
      end

      describe '#throttling?' do
        it 'defaults to false' do
          expect(subject.throttling?).to be(false)
        end
      end
    end
  end
end
