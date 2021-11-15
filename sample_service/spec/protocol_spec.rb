# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'sample_service'

module SampleService
  describe Client do
    let(:endpoint) { 'http://127.0.0.1' }
    let(:client) { Client.new(stub_responses: true, endpoint: endpoint) }

    describe '#create_high_score' do

    end
    describe '#delete_high_score' do

    end
    describe '#get_high_score' do
      describe 'requests' do

        # Serializes http labels
        it 'sample_service_serializes_http_label' do
          middleware = Seahorse::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/high_scores/1')
            expect(request.headers.keys).to include(*['Content-Length'])
            Seahorse::Output.new
          end
          client.get_high_score({id: '1'}, middleware: middleware)
        end
      end

      describe 'responses' do
        # Parses string shapes
        it 'sample_service_parses_string_shapes' do
          middleware = Seahorse::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Seahorse::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"id":"string-value"}')
            Seahorse::Output.new
          end
          middleware.remove_send.remove_build
          output = client.get_high_score({}, middleware: middleware)
          expect(output.to_h).to eq({high_score: {id: 'string-value'}})
        end
      end
    end
    describe '#list_high_scores' do

    end
    describe '#update_high_score' do

    end
  end
end
