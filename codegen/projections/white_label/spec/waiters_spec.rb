# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  module Waiters
    describe ResourceExists do
      let(:client) { double('Client') }
      let(:resource_waiter) { ResourceExists.new(client, max_wait_time: 9001) }

      it 'initializes a Hearth::Waiters::Waiter with min and max delays' do
        waiter = resource_waiter.instance_variable_get(:@waiter)
        expect(waiter).to be_a(Hearth::Waiters::Waiter)
        expect(waiter.max_wait_time).to eq(9001)
        # modeled min and max delay
        expect(waiter.min_delay).to eq(10)
        expect(waiter.max_delay).to eq(100)
      end

      it 'initializes a Hearth::Waiters::Poller with operation and acceptors' do
        waiter = resource_waiter.instance_variable_get(:@waiter)
        poller = waiter.instance_variable_get(:@poller)
        expect(poller).to be_a(Hearth::Waiters::Poller)
        operation_name = poller.instance_variable_get(:@operation_name)
        # modeled operation name
        expect(operation_name).to eq(:waiters_test)
        acceptors = poller.instance_variable_get(:@acceptors)
        # modeled acceptors
        expect(acceptors).to eq(
          [
            { state: 'success', matcher: { success: true } },
            { state: 'retry', matcher: { errorType: 'NotFound' } },
            {
              state: 'failure',
              matcher: {
                output: {
                  path: '"status"', comparator: "stringEquals", expected: "failed"
                }
              }
            },
            {
              state: 'failure',
              matcher: {
                inputOutput: {
                  path: '("input"."status" == `"failed"` || "output"."status" == `"failed"`)',
                  comparator: "booleanEquals",
                  expected: "true"
                }
              }
            }
          ]
        )
      end

      it 'is taggable' do
        expect(resource_waiter.tags).to eq(["waiter", "test"])
      end

      it 'has a wait method that uses the waiter' do
        params = { foo: 'bar' }
        options = { stub_responses: true }
        waiter = resource_waiter.instance_variable_get(:@waiter)
        expect(waiter).to receive(:wait).with(client, params, options)
        resource_waiter.wait(params, options)
      end
    end
  end
end
