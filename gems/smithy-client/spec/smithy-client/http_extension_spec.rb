# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe HttpExtension do
      it 'caches empty HTTP metadata for unsupported shapes' do
        shape = Schema::Shapes::StringShape.new

        expect(described_class.fetch(shape)).to eq({})
        expect(described_class.fetch(shape)).to be(shape[:http])
      end

      it 'caches HTTP operation metadata' do
        operation = Schema::Shapes::OperationShape.new(
          traits: { 'smithy.api#http' => { 'method' => 'GET', 'uri' => '/things?x=1', 'code' => 204 } }
        )

        expect(described_class.fetch(operation)).to include(
          method: 'GET', path: '/things', static_query: 'x=1', response_code: 204
        )
        expect(described_class.fetch(operation)).to be(described_class.fetch(operation))
      end

      it 'indexes member bindings and payload media types' do
        shape = Schema::Shapes::StructureShape.new
        header = Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::StringShape.new, name: 'Header',
          traits: { 'smithy.api#httpHeader' => 'X-Test' }
        )
        query = Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::StringShape.new, name: 'Query',
          traits: { 'smithy.api#httpQuery' => 'q' }
        )
        prefix_headers = Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::MapShape.new, name: 'Metadata',
          traits: { 'smithy.api#httpPrefixHeaders' => 'X-Meta-' }
        )
        query_params = Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::MapShape.new, name: 'Params',
          traits: { 'smithy.api#httpQueryParams' => {} }
        )
        payload = Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::BlobShape.new(
            traits: { 'smithy.api#mediaType' => 'application/custom' }
          ),
          name: 'Payload', traits: { 'smithy.api#httpPayload' => {} }
        )
        response_code = Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::IntegerShape.new, name: 'Status',
          traits: { 'smithy.api#httpResponseCode' => {} }
        )
        shape.add_member(:header, header)
        shape.add_member(:query, query)
        shape.add_member(:prefix_headers, prefix_headers)
        shape.add_member(:query_params, query_params)
        shape.add_member(:payload, payload)
        shape.add_member(:response_code, response_code)

        expect(described_class.header_members(shape).first.last).to eq('X-Test')
        expect(described_class.prefix_header_member(shape)).to eq(
          [:prefix_headers, prefix_headers, 'X-Meta-']
        )
        expect(described_class.query_members(shape).first.last).to eq('q')
        expect(described_class.query_params_member(shape)).to eq([:query_params, query_params])
        expect(described_class.payload_member(shape).last).to eq('application/custom')
        expect(described_class.response_code_member(shape)).to eq([:response_code, response_code])
      end
    end
  end
end
