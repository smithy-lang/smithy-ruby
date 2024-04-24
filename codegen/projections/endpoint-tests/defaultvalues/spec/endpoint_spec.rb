# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require_relative 'spec_helper'

module DefaultValues
  module Endpoint
    describe Resolver do
      subject { Resolver.new }

      context "Default value is used when parameter is unset" do
        let(:expected) do
          {
            url: 'https://example.com/baz',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(bar: "a b")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end

        it 'produces the correct output from the client when calling get_thing' do
          config = {bar: 'a b'}
          config[:stub_responses] = true
          config[:endpoint] = nil
          config[:endpoint] = "https://custom.example.com"

          client = Client.new(config)
          proc = proc do |context|
            expected_uri = URI.parse(expected[:url])
            request_uri = context.request.uri
            expect(request_uri.hostname).to end_with(expected_uri.hostname)
            expect(request_uri.scheme).to eq(expected_uri.scheme)
            expect(request_uri.path).to start_with(expected_uri.path)
            expected[:headers].each do |k,v|
              expect(context.request.headers[k]).to eq(Hearth::HTTP::Field.new(k, v).value)
            end
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          client.get_thing({}, interceptors: [interceptor])
        end
      end

      context "Default value is not used when the parameter is set" do
        let(:expected) do
          {
            url: 'https://example.com/BIG',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(bar: "a b", baz: "BIG")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end

        it 'produces the correct output from the client when calling get_thing' do
          config = {bar: 'a b', baz: 'BIG'}
          config[:stub_responses] = true
          config[:endpoint] = nil
          config[:endpoint] = "https://custom.example.com"

          client = Client.new(config)
          proc = proc do |context|
            expected_uri = URI.parse(expected[:url])
            request_uri = context.request.uri
            expect(request_uri.hostname).to end_with(expected_uri.hostname)
            expect(request_uri.scheme).to eq(expected_uri.scheme)
            expect(request_uri.path).to start_with(expected_uri.path)
            expected[:headers].each do |k,v|
              expect(context.request.headers[k]).to eq(Hearth::HTTP::Field.new(k, v).value)
            end
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          client.get_thing({}, interceptors: [interceptor])
        end
      end

      context "a documentation string" do
        let(:expected) do
          {error: "endpoint error"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new()
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end
    end
  end
end
