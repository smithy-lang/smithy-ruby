# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe RefreshingIdentityProvider do
      let(:identity) do
        Class.new do
          def initialize
            @credentials = 'secret'
          end

          attr_reader :credentials
        end
      end

      let(:identity_resolver) do
        Class.new do
          include IdentityProvider
          include RefreshingIdentityProvider

          def initialize(_options = {})
            @proc = options[:proc]
            @async_refresh = true
            super
          end

          def refresh
            @identity = @proc.call
          end
        end
      end

      let(:refreshed_expiration) { Time.now + 3600 }
      let(:refreshed_expiration_identity) do
        Identity.new(expiration: refreshed_expiration)
      end

      let(:properties) { { foo: 'bar' } }

      let(:proc) { -> { identity.new } }

      subject { identity_resolver.new(proc: proc) }

      describe '#initialize' do
        it 'calls refresh' do
          expect(proc).to receive(:call).and_call_original
          expect(subject.identity).to be_a(identity)
        end
      end

      describe '#identity' do
        context 'near sync expiration' do
          let(:near_sync_expiration) { Time.now + 200 }
          let(:near_sync_expiration_identity) do
            Identity.new(expiration: near_sync_expiration)
          end

          it 'refreshes synchronously' do
            expect(Thread).not_to receive(:new)
            expect(proc).to receive(:call).and_return(near_sync_expiration_identity)
            expect(proc).to receive(:call).and_return(refreshed_expiration_identity)

            identity = subject.identity # initialize
            expect(identity).to eq(near_sync_expiration_identity)
            identity = subject.identity # refreshing
            expect(identity).to eq(refreshed_expiration_identity)
          end
        end

        context 'near async expiration' do
          let(:near_async_expiration) { Time.now + 500 }
          let(:near_async_expiration_identity) do
            Identity.new(expiration: near_async_expiration)
          end

          it 'refreshes asynchronously' do
            expect(Thread).to receive(:new).and_yield
            expect(proc).to receive(:call)
              .and_return(near_async_expiration_identity)
            expect(proc).to receive(:call)
              .and_return(refreshed_expiration_identity)
            identity = subject.identity # initialize
            expect(identity).to eq(near_async_expiration_identity)
            identity = subject.identity # refreshing
            expect(identity).to eq(refreshed_expiration_identity)
          end
        end
      end
    end
  end
end
