# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Waiters' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'WaiterService'

      let(:input) { { string_property: 'input_string' } }
      let(:client) { WaiterService::Client.new(stub_responses: true) }
      let(:no_such_waiter_error) { Smithy::Client::Waiters::NoSuchWaiterError }

      it 'returns nil when successful' do
        input = { string_property: 'input_string' }
        client.stub_responses(:get_operation, { string_property: 'success' })
        expect(client.wait_until(:success_matcher, input, max_wait_time: 60)).to be(nil)
      end

      it 'raises waiter failed error when unsuccessful' do
        client.stub_responses(:get_operation, StandardError)
        expect do
          client.wait_until(:success_matcher, { string_property: 'input_string' }, max_wait_time: 60)
        end.to raise_error(Smithy::Client::Waiters::WaiterFailed)
      end

      it 'raises an error for nonexistent waiters' do
        expect do
          client.wait_until(:nonexistent_waiter, { string_property: 'input_string' }, max_wait_time: 60)
        end.to raise_error(Smithy::Client::Waiters::NoSuchWaiterError)
      end
    end
  end
end
