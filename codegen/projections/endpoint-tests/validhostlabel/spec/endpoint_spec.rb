# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require_relative 'spec_helper'

module ValidHostlabel
  module Endpoint
    describe Resolver do
      subject { Resolver.new }

      context "standard region is a valid hostlabel" do
        let(:expected) do
          {
            url: 'https://us-east-1.amazonaws.com',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(region: "us-east-1")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context "starting with a number is a valid hostlabel" do
        let(:expected) do
          {
            url: 'https://3aws4.amazonaws.com',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(region: "3aws4")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context "when there are dots, only match if subdomains are allowed" do
        let(:expected) do
          {
            url: 'https://part1.part2-subdomains.amazonaws.com',
            headers: {},
            auth_schemes: []
          }
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(region: "part1.part2")
          endpoint = subject.resolve(params)
          expect(endpoint.uri).to eq(expected[:url])
          expect(endpoint.headers).to eq(expected[:headers])
          expect(endpoint.auth_schemes).to eq(expected[:auth_schemes])
        end
      end

      context "a space is never a valid hostlabel" do
        let(:expected) do
          {error: "Invalid hostlabel"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(region: "part1 part2")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "an empty string is not a valid hostlabel" do
        let(:expected) do
          {error: "Invalid hostlabel"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(region: "")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "ending with a dot is not a valid hostlabel" do
        let(:expected) do
          {error: "Invalid hostlabel"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(region: "part1.")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "multiple consecutive dots are not allowed" do
        let(:expected) do
          {error: "Invalid hostlabel"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(region: "part1..part2")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "labels cannot start with a dash" do
        let(:expected) do
          {error: "Invalid hostlabel"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(region: "part1.-part2")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end
    end
  end
end
