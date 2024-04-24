# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require_relative 'spec_helper'

module Headers
  module Endpoint
    describe Resolver do
      subject { Resolver.new }

      context "header set to region" do
        let(:expected) do
          {
            url: 'https://us-east-1.amazonaws.com',
            headers: {'x-amz-multi' => ['*','us-east-1'], 'x-amz-region' => ['us-east-1']},
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
    end
  end
end
