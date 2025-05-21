# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Waiters' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'WaiterService'

      let(:client) { WaiterService::Client.new(stub_responses: true) }
      let(:no_such_waiter_error) { Smithy::Client::Waiters::NoSuchWaiterError }

      it 'returns nil when successful' do
        expect(client.wait_until(:success_matcher, {}, max_wait_time: 60)).to be(nil)
      end

      it 'raises waiter failed error when unsuccessful' do
        client.stub_responses(:get_operation, StandardError)
        expect do
          client.wait_until(:success_matcher, {}, max_wait_time: 60)
        end.to raise_error(Smithy::Client::Waiters::WaiterFailed)
      end

      it 'raises an error for nonexistent waiters' do
        expect do
          client.wait_until(:nonexistent_waiter)
        end.to raise_error(Smithy::Client::Waiters::NoSuchWaiterError)
      end
    end
  end
end
