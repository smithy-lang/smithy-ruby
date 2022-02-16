# frozen_string_literal: true

module Hearth
  describe Context do
    let(:operation_name) { :operation }
    let(:request) { double('request') }
    let(:response) { double('response') }
    let(:logger) { Logger.new($stdout) }
    let(:params) { { key: 'value' } }
    let(:metadata) { { foo: 'bar' } }

    subject do
      Context.new(
        operation_name: operation_name,
        request: request,
        response: response,
        logger: logger,
        params: params,
        metadata: metadata
      )
    end

    describe '#initialize' do
      it 'sets empty defaults' do
        context = Context.new
        expect(context.operation_name).to be_nil
        expect(context.request).to be_nil
        expect(context.response).to be_nil
        expect(context.logger).to be_nil
        expect(context.params).to be_nil
        expect(context.metadata).to eq({})
      end
    end

    describe '#metadata' do
      it 'allows for metadata to be set' do
        subject.metadata[:bar] = 'baz'
        expect(subject.metadata).to include(bar: 'baz')
      end
    end
  end
end
