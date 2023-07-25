# frozen_string_literal: true

require 'rails_json'

module RailsJson
  describe Client do
    let(:endpoint) { 'http://127.0.0.1' }
    let(:config) { Config.new(stub_responses: true, endpoint: endpoint) }
    let(:client) { Client.new(config) }

    context 'success' do
      it 'puts request_id onto output metadata' do
        response = Hearth::HTTP::Response.new
        response.status = 200
        response.headers['x-request-id'] = '123'
        response.body = StringIO.new('{}')
        client.stub_responses(:empty_operation, response)
        allow(Builders::EmptyOperation).to receive(:build)
        output = client.empty_operation
        expect(output.metadata[:request_id]).to eq('123')
      end
    end

    context 'error' do
      it 'puts request_id onto error metadata' do
        response = Hearth::HTTP::Response.new
        response.status = 400
        response.headers['x-smithy-rails-error'] = 'InvalidGreeting'
        response.headers['x-request-id'] = '123'
        response.body = StringIO.new('{}')
        client.stub_responses(:greeting_with_errors, response)
        allow(Builders::GreetingWithErrors).to receive(:build)

        begin
          client.greeting_with_errors
        rescue Errors::InvalidGreeting => e
          expect(e.metadata[:request_id]).to eq('123')
        end
      end
    end
  end
end
