require_relative './spec_helper'

module SampleService
  describe Client do
    let(:endpoint) { 'http://127.0.0.1' }
    let(:client) { Client.new(endpoint: endpoint, stub_responses: true) }


    describe '#create_high_score' do
    end
    describe '#delete_high_score' do
    end
    describe '#get_high_score' do

      describe 'requests' do
        it 'serializes_http_label' do
          middleware = Seahorse::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(context.request.url)
            expect(request.headers).to include('Content-Length')
            expect(request_uri.path).to eq('/high_scores/1')
          end
          client.get_high_score(params = {id: '1'}, middleware: middleware)
        end
      end

      describe 'responses' do
        it 'parses_string_shapes' do
          middleware = Seahorse::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.body = StringIO.new("{\"id\":\"string-value\"}")
            response.headers = {'Content-Type' => 'application/json'}

            # skip the app.call to skip real send

            Seahorse::Output.new
          end
          middleware
            .remove_send
            .remove_build # required since we don't have a required param (id)
          output = client.get_high_score(params = {}, middleware: middleware)
          expect(output.high_score.id).to eq('string-value')
        end
      end
    end
    describe '#list_high_scores' do
    end
    describe '#update_high_score' do
    end
  end
end
