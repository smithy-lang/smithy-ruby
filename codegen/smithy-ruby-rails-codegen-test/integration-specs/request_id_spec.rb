# frozen_string_literal: true

require 'rails_json'

module RailsJson
  describe Client do
    let(:endpoint) { 'http://127.0.0.1' }
    let(:client) { Client.new(stub_responses: true, endpoint: endpoint) }

    context 'success' do
      it 'puts request_id onto output metadata' do
        middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
          response = context.response
          response.status = 200
          response.headers = Hearth::HTTP::Headers.new(headers: { 'x-request-id' => '123' })
          response.body = StringIO.new('{}')
          Hearth::Output.new
        end
        middleware.remove_send.remove_build
        output = client.empty_operation({}, middleware: middleware)
        expect(output.metadata[:request_id]).to eq('123')
      end
    end

    context 'error' do
      it 'puts request_id onto error metadata' do
        middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
          response = context.response
          response.status = 400
          response.headers = Hearth::HTTP::Headers.new(
            headers: { 'x-smithy-rails-error' => 'InvalidGreeting', 'x-request-id' => '123' }
          )
          response.body = StringIO.new('{}')
          Hearth::Output.new
        end
        middleware.remove_send.remove_build
        begin
          client.greeting_with_errors({}, middleware: middleware)
        rescue Errors::InvalidGreeting => e
          expect(e.metadata[:request_id]).to eq('123')
        end
      end
    end

  end
end
