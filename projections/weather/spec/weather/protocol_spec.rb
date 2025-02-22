# frozen_string_literal: true

# This is generated code!

require_relative '../spec_helper'

module Weather
  # TODO: Can be replaced by stub_responses config once implemented
  class StubSend < Smithy::Client::Plugin
    option(:stub_response)
    handle(step: :send) do |context|
      if (stub_response = context.config.stub_response)
        resp = context.response
        resp.signal_headers(stub_response[:status_code], stub_response.fetch(:headers, {}))
        resp.signal_data(stub_response[:body]) if stub_response[:body]
        resp.signal_done
      end
      Smithy::Client::Output.new(context: context)
    end
  end

  describe Client do
    before(:all) { Client.add_plugin(StubSend) }
    after(:all) { Client.remove_plugin(StubSend) }

    let(:client_options) do
      {
        # stub_responses: true,
        # validate_input: false,
        endpoint: 'http://127.0.0.1'
        # retry_strategy: # disable?
      }
    end

    let(:client) { Client.new(client_options) }
  end
end
