# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require_relative 'spec_helper'

module UrlEncode
  module Endpoint
    describe Resolver do
      subject { Resolver.new }

      context "uriEncode when the string has nothing to encode returns the input" do
        let(:expected) do
          {error: "The value is: `abcdefg`"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: "abcdefg")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "uriEncode with single character to encode encodes only that character" do
        let(:expected) do
          {error: "The value is: `abc%3Adefg`"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: "abc:defg")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "uriEncode with all ASCII characters to encode encodes all characters" do
        let(:expected) do
          {error: "The value is: `%2F%3A%2C%3F%23%5B%5D%7B%7D%7C%40%21%20%24%26%27%28%29%2A%2B%3B%3D%25%3C%3E%22%5E%60%5C`"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: "/:,?#[]{}|@! $&'()*+;=%<>\"^`\\")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "uriEncode with ASCII characters that should not be encoded returns the input" do
        let(:expected) do
          {error: "The value is: `0123456789.underscore_dash-Tilda~`"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: "0123456789.underscore_dash-Tilda~")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "uriEncode encodes unicode characters" do
        let(:expected) do
          {error: "The value is: `%F0%9F%98%B9`"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: "😹")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "uriEncode on all printable ASCII characters" do
        let(:expected) do
          {error: "The value is: `%20%21%22%23%24%25%26%27%28%29%2A%2B%2C-.%2F0123456789%3A%3B%3C%3D%3E%3F%40ABCDEFGHIJKLMNOPQRSTUVWXYZ%5B%5C%5D%5E_%60abcdefghijklmnopqrstuvwxyz%7B%7C%7D~`"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "uriEncode on an empty string" do
        let(:expected) do
          {error: "The value is: ``"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: "")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end
    end
  end
end
