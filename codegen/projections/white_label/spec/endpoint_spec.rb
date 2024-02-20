# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'white_label'

module WhiteLabel
  module Endpoint
    describe Provider do
      subject { Provider.new }

      context 'Endpoint override is used' do
        let(:expected) do
          {
            url: 'https://custom-endpoint.com',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointProvider' do
          params = Params.new(endpoint: "https://custom-endpoint.com")
          endpoint = subject.resolve_endpoint(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end

        it 'produces the correct output from the client when calling endpoint_operation' do
          config = {}
          config[:stub_responses] = true
          config[:endpoint] = nil
          config[:endpoint] = "https://custom-endpoint.com"

          client = Client.new(config)
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc do |context|
            expected_uri = URI.parse(expected[:url])
            request_uri = context.request.uri
            expect(request_uri.hostname).to end_with(expected_uri.hostname)
            expect(request_uri.scheme).to eq(expected_uri.scheme)
            expect(request_uri.path).to start_with(expected_uri.path)
            expected[:headers].each do |k,v|
              expect(context.request.headers[k]).to eq(Hearth::HTTP::Field.new(k, v).value)
            end
          end)
          client.endpoint_operation({}, interceptors: [interceptor])
        end
      end

      context 'Endpoint override is used when other parameters are set' do
        let(:expected) do
          {
            url: 'https://custom-endpoint.com',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointProvider' do
          params = Params.new(endpoint: "https://custom-endpoint.com", stage: "prod", dataplane: true, resource_url: "https://resource")
          endpoint = subject.resolve_endpoint(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context 'Stage is used' do
        let(:expected) do
          {
            url: 'https://beta.whitelabel.dev',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointProvider' do
          params = Params.new(stage: "beta")
          endpoint = subject.resolve_endpoint(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end

        it 'produces the correct output from the client when calling endpoint_operation' do
          config = {stage: 'beta'}
          config[:stub_responses] = true
          config[:endpoint] = nil

          client = Client.new(config)
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc do |context|
            expected_uri = URI.parse(expected[:url])
            request_uri = context.request.uri
            expect(request_uri.hostname).to end_with(expected_uri.hostname)
            expect(request_uri.scheme).to eq(expected_uri.scheme)
            expect(request_uri.path).to start_with(expected_uri.path)
            expected[:headers].each do |k,v|
              expect(context.request.headers[k]).to eq(Hearth::HTTP::Field.new(k, v).value)
            end
          end)
          client.endpoint_operation({}, interceptors: [interceptor])
        end
      end

      context 'ResourceURL is parsed and used' do
        let(:expected) do
          {
            url: 'https://resource.com/path',
            headers: {'x-resource-type' => ['custom']},
            auth_schemes: [Hearth::Endpoints::AuthScheme.new(name: 'bearer', properties: {})]
          }
        end

        it 'produces the expected output from the EndpointProvider' do
          params = Params.new(resource_url: "https://resource.com/path")
          endpoint = subject.resolve_endpoint(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end

        it 'produces the correct output from the client when calling endpoint_operation_with_resource' do
          config = {}
          config[:stub_responses] = true
          config[:endpoint] = nil

          client = Client.new(config)
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc do |context|
            expected_uri = URI.parse(expected[:url])
            request_uri = context.request.uri
            expect(request_uri.hostname).to end_with(expected_uri.hostname)
            expect(request_uri.scheme).to eq(expected_uri.scheme)
            expect(request_uri.path).to start_with(expected_uri.path)
            expected[:headers].each do |k,v|
              expect(context.request.headers[k]).to eq(Hearth::HTTP::Field.new(k, v).value)
            end
          end)
          client.endpoint_operation_with_resource({resource_url: 'https://resource.com/path'}, interceptors: [interceptor])
        end
      end

      context 'Data prefix is applied' do
        let(:expected) do
          {
            url: 'https://data.whitelabel.com',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointProvider' do
          params = Params.new(dataplane: true)
          endpoint = subject.resolve_endpoint(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end

        it 'produces the correct output from the client when calling dataplane_operation' do
          config = {}
          config[:stub_responses] = true
          config[:endpoint] = nil

          client = Client.new(config)
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc do |context|
            expected_uri = URI.parse(expected[:url])
            request_uri = context.request.uri
            expect(request_uri.hostname).to end_with(expected_uri.hostname)
            expect(request_uri.scheme).to eq(expected_uri.scheme)
            expect(request_uri.path).to start_with(expected_uri.path)
            expected[:headers].each do |k,v|
              expect(context.request.headers[k]).to eq(Hearth::HTTP::Field.new(k, v).value)
            end
          end)
          client.dataplane_operation({}, interceptors: [interceptor])
        end

        it 'produces the correct output from the client when calling endpoint_with_host_label_operation' do
          config = {}
          config[:stub_responses] = true
          config[:endpoint] = nil

          client = Client.new(config)
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc do |context|
            expected_uri = URI.parse(expected[:url])
            request_uri = context.request.uri
            expect(request_uri.hostname).to end_with(expected_uri.hostname)
            expect(request_uri.scheme).to eq(expected_uri.scheme)
            expect(request_uri.path).to start_with(expected_uri.path)
            expected[:headers].each do |k,v|
              expect(context.request.headers[k]).to eq(Hearth::HTTP::Field.new(k, v).value)
            end
          end)
          client.endpoint_with_host_label_operation({label_member: 'label'}, interceptors: [interceptor])
        end
      end
    end
  end
end
