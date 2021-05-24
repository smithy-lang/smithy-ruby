# frozen_string_literal: true

module Seahorse
  describe Context do
    let(:params) { { key: 'value' } }
    let(:logger) { Logger.new($stdout) }
    let(:request) { double('request') }
    let(:response) { double('response') }
    let(:metadata) { { foo: 'bar' } }

    subject do
      Context.new(
        metadata.merge({
                         request: request,
                         response: response,
                         params: params,
                         logger: logger
                       })
      )
    end

    describe '#initialize' do
      it 'sets empty defaults' do
        context = Context.new
        expect(context.params).to be_nil
        expect(context.logger).to be_nil
        expect(context.request).to be_nil
        expect(context.response).to be_nil
      end
    end

    describe '#request' do
      it 'gets the request' do
        expect(subject.request).to be request
      end
    end

    describe '#response' do
      it 'gets the response' do
        expect(subject.response).to be response
      end
    end

    describe '#params' do
      it 'gets the params field' do
        expect(subject.params).to be params
      end
    end

    describe '#logger' do
      it 'gets the logger field' do
        expect(subject.logger).to be logger
      end
    end

    describe '#metadata' do
      it 'gets the metadat field' do
        expect(subject.metadata).to eq metadata
      end
    end
  end

end
