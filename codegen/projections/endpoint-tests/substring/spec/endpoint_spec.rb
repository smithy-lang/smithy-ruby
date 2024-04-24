# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require_relative 'spec_helper'

module Substring
  module Endpoint
    describe Resolver do
      subject { Resolver.new }

      context "substring when string is long enough" do
        let(:expected) do
          {error: "The value is: `abcd`"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: "abcdefg")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "substring when string is exactly the right length" do
        let(:expected) do
          {error: "The value is: `abcd`"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: "abcd")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "substring when string is too short" do
        let(:expected) do
          {error: "No tests matched"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: "abc")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "substring when string is too short" do
        let(:expected) do
          {error: "No tests matched"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: "")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "substring on wide characters (ensure that unicode code points are properly counted)" do
        let(:expected) do
          {error: "No tests matched"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: "﷽")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "unicode characters always return `None`" do
        let(:expected) do
          {error: "No tests matched"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: "abcdef🐱")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "non-ascii cause substring to always return `None`" do
        let(:expected) do
          {error: "No tests matched"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: "abcdef\u0080")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "the full set of ascii is supported, including non-printable characters" do
        let(:expected) do
          {error: "The value is: `\u007fabc`"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "1", input: "\u007fabcdef")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "substring when string is long enough" do
        let(:expected) do
          {error: "The value is: `defg`"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "2", input: "abcdefg")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "substring when string is exactly the right length" do
        let(:expected) do
          {error: "The value is: `defg`"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "2", input: "defg")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "substring when string is too short" do
        let(:expected) do
          {error: "No tests matched"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "2", input: "abc")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "substring when string is too short" do
        let(:expected) do
          {error: "No tests matched"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "2", input: "")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "substring on wide characters (ensure that unicode code points are properly counted)" do
        let(:expected) do
          {error: "No tests matched"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "2", input: "﷽")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "substring when string is longer" do
        let(:expected) do
          {error: "The value is: `ef`"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "3", input: "defg")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "substring when string is exact length" do
        let(:expected) do
          {error: "The value is: `ef`"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "3", input: "def")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "substring when string is too short" do
        let(:expected) do
          {error: "No tests matched"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "3", input: "ab")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "substring when string is too short" do
        let(:expected) do
          {error: "No tests matched"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "3", input: "")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end

      context "substring on wide characters (ensure that unicode code points are properly counted)" do
        let(:expected) do
          {error: "No tests matched"}
        end

        it 'produces the expected output from the EndpointResolver' do
          params = Params.new(test_case_id: "3", input: "﷽")
          expect do
            subject.resolve(params)
          end.to raise_error(ArgumentError, expected[:error])
        end
      end
    end
  end
end
