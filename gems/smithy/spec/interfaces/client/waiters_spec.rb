# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Waiters' do
  let(:input) { { string_property: 'input_string' } }
  let(:client) { WaiterService::Client.new(stub_responses: true) }
  let(:no_such_waiter_error) { Smithy::Client::Errors::NoSuchWaiterError }

  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'WaiterService'

      it 'returns when successful' do
        client.stub_responses(:get_operation, {})
        expect do
          client.wait_until(:success_matcher, input, max_wait_time: 60)
        end.to_not raise_error
      end

      it 'returns output when successful' do
        client.stub_responses(:get_operation, { string_property: 'success' })
        resp = client.wait_until(:success_matcher, input, max_wait_time: 60)
        expect(resp[:string_property]).to eq('success')
      end

      it 'raises an error when unsuccessful' do
        client.stub_responses(:get_operation, StandardError)
        expect do
          client.wait_until(:success_matcher, input, max_wait_time: 60)
        end.to raise_error(Smithy::Client::Errors::UnexpectedError)
      end

      it 'raises an error for nonexistent waiters' do
        expect do
          client.wait_until(:nonexistent_waiter, input, max_wait_time: 60)
        end.to raise_error(no_such_waiter_error)
      end

      it 'does not allow custom waiters' do
        custom_waiter = {
          'CustomWaiterMatcher' => {
            'acceptors' => [
              {
                'state' => 'success',
                'matcher' => {
                  'success' => false
                }
              }
            ]
          }
        }
        client.config.service.operations[:get_operation].traits['smithy.waiters#waitable'].merge!(custom_waiter)
        expect do
          client.wait_until(:custom_waiter_matcher, input, max_wait_time: 60)
        end.to raise_error(no_such_waiter_error)
      end
    end
  end
end
