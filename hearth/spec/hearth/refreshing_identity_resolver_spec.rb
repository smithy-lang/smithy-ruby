# frozen_string_literal: true

module Hearth
  class TestIdentityResolver
    include RefreshingIdentityResolver

    def initialize(proc)
      @proc = proc
      @async_refresh = true
      super()
    end

    def refresh(properties = {})
      @identity = @proc.call(properties)
    end
  end

  describe RefreshingIdentityResolver do
    let(:refreshed_expiration) { Time.now + 3600 }
    let(:refreshed_expiration_identity) do
      Identities::Base.new(expiration: refreshed_expiration)
    end

    let(:properties) { { foo: 'bar' } }
    let(:proc) { ->(_properties) {} }

    subject { TestIdentityResolver.new(proc) }

    describe '#identity' do
      it 'initializes the identity' do
        expect(proc).to receive(:call)
          .with(properties).and_return(refreshed_expiration_identity)
        expect(subject).to receive(:refresh).with(properties).and_call_original

        expect(subject.instance_variable_get(:@identity)).to be_nil
        identity = subject.identity(properties)
        expect(identity).to eq(refreshed_expiration_identity)
        expect(subject.instance_variable_get(:@identity)).to eq(identity)
      end

      context 'near sync expiration' do
        let(:near_sync_expiration) { Time.now + 200 }
        let(:near_sync_expiration_identity) do
          Identities::Base.new(expiration: near_sync_expiration)
        end

        it 'refreshes synchronously' do
          expect(Thread).not_to receive(:new)
          expect(proc).to receive(:call)
            .with(properties).and_return(near_sync_expiration_identity)
          expect(proc).to receive(:call)
            .with(properties).and_return(refreshed_expiration_identity)

          identity = subject.identity(properties) # initialize
          expect(identity).to eq(near_sync_expiration_identity)
          identity = subject.identity(properties) # refreshing
          expect(identity).to eq(refreshed_expiration_identity)
        end
      end

      context 'near async expiration' do
        let(:near_async_expiration) { Time.now + 500 }
        let(:near_async_expiration_identity) do
          Identities::Base.new(expiration: near_async_expiration)
        end

        it 'refreshes asynchronously' do
          expect(Thread).to receive(:new).and_yield
          expect(proc).to receive(:call)
            .with(properties).and_return(near_async_expiration_identity)
          expect(proc).to receive(:call)
            .with(properties).and_return(refreshed_expiration_identity)

          identity = subject.identity(properties) # initialize
          expect(identity).to eq(near_async_expiration_identity)
          identity = subject.identity(properties) # refreshing
          expect(identity).to eq(refreshed_expiration_identity)
        end
      end
    end
  end
end
