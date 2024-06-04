# frozen_string_literal: true

module Hearth
  describe Context do
    let(:uuid) { 'uuid' }
    let(:operation_name) { :operation }
    let(:request) { double('request') }
    let(:response) { double('response') }
    let(:config) { double('config') }
    let(:metadata) { { foo: 'bar' } }

    subject do
      Context.new(
        operation_name: operation_name,
        request: request,
        response: response,
        config: config,
        metadata: metadata
      )
    end

    describe '#initialize' do
      before do
        expect(SecureRandom).to receive(:uuid).and_return(uuid)
      end

      it 'sets defaults' do
        context = Context.new
        expect(context.invocation_id).to eq(uuid)
        expect(context.operation_name).to be_nil
        expect(context.request).to be_nil
        expect(context.response).to be_nil
        expect(context.config).to be_nil
        expect(context.auth).to be_nil
        expect(context.metadata).to eq({})
      end

      it 'sets member values' do
        expect(subject.invocation_id).to eq(uuid)
        expect(subject.operation_name).to eq(operation_name)
        expect(subject.request).to eq(request)
        expect(subject.response).to eq(response)
        expect(subject.config).to eq(config)
        expect(subject.auth).to be_nil
        expect(subject.metadata).to eq(metadata)
      end
    end

    describe '#auth' do
      it 'allows for auth to be set' do
        resolved_auth = Hearth::Middleware::Auth::ResolvedAuth.new
        subject.auth = resolved_auth
        expect(subject.auth).to eq(resolved_auth)
      end
    end

    describe '#metadata' do
      it 'returns metadata' do
        expect(subject.metadata).to eq(metadata)
      end
    end

    describe '#[]' do
      it 'returns the metadata for the given key' do
        expect(subject[:foo]).to eq('bar')
      end
    end

    describe '#[]=' do
      it 'sets the metadata for the given key' do
        subject[:foo] = 'baz'
        expect(subject[:foo]).to eq('baz')
      end
    end
  end
end
