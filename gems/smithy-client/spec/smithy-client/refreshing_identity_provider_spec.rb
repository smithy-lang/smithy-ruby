# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe RefreshingIdentityProvider do
      let(:identity_provider) do
        Class.new do
          include IdentityProvider
          include RefreshingIdentityProvider

          def initialize(options = {})
            @proc = options[:proc]
            @async_refresh = true
            super
          end

          attr_accessor :expiration

          private

          def refresh
            @identity = @proc.call
            @expiration = Time.now + 3600
          end
        end
      end

      let(:time) { Time.now }
      before do
        allow(Time).to receive(:now).and_return(time)
      end
      let(:near_sync_expiration) { time + 200 }
      let(:near_async_expiration) { time + 500 }
      let(:refreshed_expiration) { time + 3600 }

      let(:identity) { double('identity') }
      let(:proc) { -> { identity } }

      subject { identity_provider.new(proc: proc) }

      describe '#initialize' do
        it 'calls refresh' do
          expect_any_instance_of(identity_provider).to receive(:refresh).and_call_original
          expect(subject.identity).to eq(identity)
          expect(subject.expiration).to eq(refreshed_expiration)
        end
      end

      describe '#identity' do
        it 'refreshes synchronously' do
          subject.expiration = near_sync_expiration
          expect(subject).to receive(:refresh).and_call_original
          subject.identity # force refresh
          expect(subject.expiration).to eq(refreshed_expiration)
          expect(subject).not_to receive(:refresh)
          subject.identity # no refresh
        end

        it 'refreshes asynchronously' do
          expect(Thread).to receive(:new).and_yield
          expect(subject).to receive(:refresh).and_call_original
          subject.expiration = near_async_expiration
          subject.identity # force refresh
          expect(subject.expiration).to eq(refreshed_expiration)
          expect(subject).not_to receive(:refresh)
          subject.identity # no refresh
        end
      end
    end
  end
end
