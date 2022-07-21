# frozen_string_literal: true

module Hearth
  describe Context do
    let(:operation_name) { :operation }
    let(:request) { double('request') }
    let(:response) { double('response') }
    let(:logger) { Logger.new($stdout) }
    let(:params) { { key: 'value' } }
    let(:signer_params) { { region: 'region' } }
    let(:metadata) { { foo: 'bar' } }

    subject do
      Context.new(
        operation_name: operation_name,
        request: request,
        response: response,
        logger: logger,
        params: params,
        signer_params: signer_params,
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
        expect(context.signer_params).to eq({})
        expect(context.metadata).to eq({})
      end
    end

    describe '#signer_params' do
      it 'allows for signer params to be set' do
        subject.signer_params[:service] = 'service'
        expect(subject.signer_params).to include(service: 'service')
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
