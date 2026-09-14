# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe HttpExtension do
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
        shape.add_member(:header, Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::StringShape.new, name: 'Header',
          traits: { 'smithy.api#httpHeader' => 'X-Test' }
        ))
        shape.add_member(:query, Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::StringShape.new, name: 'Query',
          traits: { 'smithy.api#httpQuery' => 'q' }
        ))
        shape.add_member(:payload, Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::BlobShape.new(
            traits: { 'smithy.api#mediaType' => 'application/custom' }
          ),
          name: 'Payload', traits: { 'smithy.api#httpPayload' => {} }
        ))

        expect(described_class.header_members(shape).first.last).to eq('X-Test')
        expect(described_class.query_members(shape).first.last).to eq('q')
        expect(described_class.payload_member(shape).last).to eq('application/custom')
      end
    end
  end
end
