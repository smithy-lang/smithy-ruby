# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require_relative 'spec_helper'

module ParseUrl
  module Endpoint
    describe Resolver do
      subject { Resolver.new }

      context "simple URL parsing" do
        let(:expected) do
          {
            url: 'https://https-authority.com.example.com/path-is/custom-path',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(endpoint: "https://authority.com/custom-path")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context "empty path no slash" do
        let(:expected) do
          {
            url: 'https://https-authority.com-nopath.example.com',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(endpoint: "https://authority.com")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context "empty path with slash" do
        let(:expected) do
          {
            url: 'https://https-authority.com-nopath.example.com',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(endpoint: "https://authority.com/")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context "authority with port" do
        let(:expected) do
          {
            url: 'https://authority.com:8000/uri-with-port',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(endpoint: "https://authority.com:8000/port")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context "http schemes" do
        let(:expected) do
          {
            url: 'http://authority.com:8000/uri-with-port',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(endpoint: "http://authority.com:8000/port")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context "arbitrary schemes are not supported" do
        let(:expected) do
          {error: "endpoint was invalid"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(endpoint: "acbd://example.com")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "host labels are not validated" do
        let(:expected) do
          {
            url: 'https://http-99_ab.com-nopath.example.com',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(endpoint: "http://99_ab.com")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context "host labels are not validated" do
        let(:expected) do
          {
            url: 'https://http-99_ab-.com-nopath.example.com',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(endpoint: "http://99_ab-.com")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context "invalid URL" do
        let(:expected) do
          {error: "endpoint was invalid"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(endpoint: "http://abc.com:a/foo")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "IP Address" do
        let(:expected) do
          {
            url: 'http://192.168.1.1/foo/is-ip-addr',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(endpoint: "http://192.168.1.1/foo/")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context "IP Address with port" do
        let(:expected) do
          {
            url: 'http://192.168.1.1:1234/foo/is-ip-addr',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(endpoint: "http://192.168.1.1:1234/foo/")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context "IPv6 Address" do
        let(:expected) do
          {
            url: 'https://[2001:db8:85a3:8d3:1319:8a2e:370:7348]:443/is-ip-addr',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(endpoint: "https://[2001:db8:85a3:8d3:1319:8a2e:370:7348]:443")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context "weird DNS name" do
        let(:expected) do
          {
            url: 'https://https-999.999.abc.blah-nopath.example.com',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(endpoint: "https://999.999.abc.blah")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context "query in resolved endpoint is not supported" do
        let(:expected) do
          {error: "endpoint was invalid"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(endpoint: "https://example.com/path?query1=foo")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end
    end
  end
end
