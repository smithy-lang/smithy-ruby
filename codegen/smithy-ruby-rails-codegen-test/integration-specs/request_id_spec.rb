# frozen_string_literal: true

require 'rails_json'

module RailsJson
  describe Client do
    let(:endpoint) { 'http://127.0.0.1' }
    let(:client) { Client.new(stub_responses: true, endpoint: endpoint) }

    context 'success' do
      it 'puts request_id onto output metadata' do
        response = Hearth::HTTP::Response.new
        response.status = 200
        response.headers['x-request-id'] = '123'
        response.body = StringIO.new('{}')
        client.stub_responses(:empty_input_and_empty_output, response)
        allow(Builders::EmptyInputAndEmptyOutput).to receive(:build)
        output = client.empty_input_and_empty_output
        expect(output.metadata[:request_id]).to eq('123')
      end
    end

    context 'error' do
      it 'puts request_id onto error metadata' do
        response = Hearth::HTTP::Response.new
        response.status = 400
        response.headers['X-Amzn-Errortype'] = 'InvalidGreeting'
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
