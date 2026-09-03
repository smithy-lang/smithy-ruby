# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe HttpBinding do
      let(:string_shape) { Schema::Shapes::StringShape.new }
      let(:structure_shape) { Schema::Shapes::StructureShape.new }
      let(:union_shape) { Schema::Shapes::UnionShape.new }

      describe 'operation accessors' do
        it 'caches method, path, and static query data from the http trait' do
          operation = Schema::Shapes::OperationShape.new(
            traits: {
              'smithy.api#http' => {
                'method' => 'PUT',
                'uri' => '/{Bucket}/{Key+}?uploads=true',
                'code' => 204
              }
            }
          )

          expect(described_class.operation_method(operation)).to eq('PUT')
          expect(described_class.operation_path(operation)).to eq('/{Bucket}/{Key+}')
          expect(described_class.operation_static_query(operation)).to eq('uploads=true')
          expect(operation[:http_operation_index]).to eq(
            http_method: 'PUT',
            http_path: '/{Bucket}/{Key+}',
            http_static_query: 'uploads=true',
            http_response_code: 204
          )
        end
      end

      describe 'request accessors' do
        it 'caches request-side HTTP routing in one pass' do
          shape = Schema::Shapes::StructureShape.new
          header_member = Schema::Shapes::MemberShape.new(
            target: string_shape,
            name: 'Checksum',
            traits: { 'smithy.api#httpHeader' => 'x-amz-checksum' }
          )
          prefix_member = Schema::Shapes::MemberShape.new(
            target: Schema::Shapes::MapShape.new,
            name: 'Metadata',
            traits: { 'smithy.api#httpPrefixHeaders' => 'x-amz-meta-' }
          )
          query_member = Schema::Shapes::MemberShape.new(
            target: string_shape,
            name: 'Mode',
            traits: { 'smithy.api#httpQuery' => 'mode' }
          )
          label_member = Schema::Shapes::MemberShape.new(
            target: string_shape,
            name: 'TimestampLabel',
            traits: { 'smithy.api#httpLabel' => {} }
          )
          payload_member = Schema::Shapes::MemberShape.new(
            target: string_shape,
            name: 'Body',
            traits: { 'smithy.api#httpPayload' => {} }
          )
          document_member = Schema::Shapes::MemberShape.new(
            target: string_shape,
            name: 'Acl'
          )
          shape.add_member(:checksum, header_member)
          shape.add_member(:metadata, prefix_member)
          shape.add_member(:mode, query_member)
          shape.add_member(:timestamp_label, label_member)
          shape.add_member(:body, payload_member)
          shape.add_member(:acl, document_member)

          expect(described_class.header_members(shape)).to eq([[:checksum, header_member, 'x-amz-checksum']])
          expect(described_class.prefix_header_members(shape)).to eq([[:metadata, prefix_member, 'x-amz-meta-']])
          expect(described_class.query_members(shape)).to eq([[:mode, query_member]])
          expect(described_class.query_name(query_member)).to eq('mode')
          expect(query_member[:http_query_name]).to eq('mode')
          expect(described_class.label_members(shape)).to eq(
            'TimestampLabel' => [:timestamp_label, label_member]
          )
          expect(described_class.payload_member(shape)).to eq([:body, payload_member])
          expect(described_class.payload_type(shape)).to eq(:raw)
          expect(described_class.payload_content_type(shape)).to eq('text/plain')
          expect(described_class.raw_payload?(shape)).to be(true)
          expect(described_class.special_payload?(shape)).to be(true)
          expect(described_class.document_members(shape)).to eq([[:acl, document_member]])
          expect(shape[:http_request_index]).to eq(
            http_header_members: [[:checksum, header_member, 'x-amz-checksum']],
            http_prefix_header_members: [[:metadata, prefix_member, 'x-amz-meta-']],
            http_query_members: [[:mode, query_member]],
            http_query_params_member: nil,
            http_label_members: { 'TimestampLabel' => [:timestamp_label, label_member] },
            http_payload_member: [:body, payload_member],
            http_payload_type: :raw,
            http_payload_content_type: 'text/plain',
            http_document_members: [[:acl, document_member]]
          )
        end

        it 'categorizes default and union payload members' do
          default_shape = Schema::Shapes::StructureShape.new
          default_shape.add_member(
            :body,
            Schema::Shapes::MemberShape.new(
              target: structure_shape,
              name: 'Body',
              traits: { 'smithy.api#httpPayload' => {} }
            )
          )

          union_payload_shape = Schema::Shapes::StructureShape.new
          union_payload_shape.add_member(
            :body,
            Schema::Shapes::MemberShape.new(
              target: union_shape,
              name: 'Body',
              traits: { 'smithy.api#httpPayload' => {} }
            )
          )

          expect(described_class.payload_type(default_shape)).to eq(:default)
          expect(described_class.payload_content_type(default_shape)).to be_nil
          expect(described_class.special_payload?(default_shape)).to be(false)
          expect(described_class.payload_type(union_payload_shape)).to eq(:union)
          expect(described_class.payload_content_type(union_payload_shape)).to be_nil
          expect(described_class.union_payload?(union_payload_shape)).to be(true)
          expect(described_class.special_payload?(union_payload_shape)).to be(true)
        end

        it 'prefers payload media types over inferred scalar content types' do
          shape = Schema::Shapes::StructureShape.new
          payload_shape = Schema::Shapes::StringShape.new(
            traits: { 'smithy.api#mediaType' => 'application/custom' }
          )
          shape.add_member(
            :body,
            Schema::Shapes::MemberShape.new(
              target: payload_shape,
              name: 'Body',
              traits: { 'smithy.api#httpPayload' => {} }
            )
          )

          expect(described_class.payload_content_type(shape)).to eq('application/custom')
        end
      end

      describe 'response accessors' do
        it 'caches response-side HTTP routing in one pass' do
          shape = Schema::Shapes::StructureShape.new
          header_member = Schema::Shapes::MemberShape.new(
            target: string_shape,
            name: 'LastModified',
            traits: { 'smithy.api#httpHeader' => 'Last-Modified' }
          )
          prefix_member = Schema::Shapes::MemberShape.new(
            target: Schema::Shapes::MapShape.new,
            name: 'Metadata',
            traits: { 'smithy.api#httpPrefixHeaders' => 'x-amz-meta-' }
          )
          response_code_member = Schema::Shapes::MemberShape.new(
            target: Schema::Shapes::IntegerShape.new,
            name: 'StatusCode',
            traits: { 'smithy.api#httpResponseCode' => {} }
          )
          payload_member = Schema::Shapes::MemberShape.new(
            target: string_shape,
            name: 'Body',
            traits: { 'smithy.api#httpPayload' => {} }
          )

          shape.add_member(:last_modified, header_member)
          shape.add_member(:metadata, prefix_member)
          shape.add_member(:status_code, response_code_member)
          shape.add_member(:body, payload_member)

          expect(described_class.response_header_members(shape)).to eq(
            [[:last_modified, header_member, 'Last-Modified']]
          )
          expect(described_class.response_prefix_header_members(shape)).to eq(
            [[:metadata, prefix_member, 'x-amz-meta-']]
          )
          expect(described_class.response_code_member(shape)).to eq([:status_code, response_code_member])
          expect(described_class.response_payload_member(shape)).to eq([:body, payload_member])
          expect(described_class.response_payload_type(shape)).to eq(:raw)
          expect(described_class.response_raw_payload?(shape)).to be(true)
          expect(described_class.response_special_payload?(shape)).to be(true)
          expect(shape[:http_response_index]).to eq(
            http_header_members: [[:last_modified, header_member, 'Last-Modified']],
            http_prefix_header_members: [[:metadata, prefix_member, 'x-amz-meta-']],
            http_payload_member: [:body, payload_member],
            http_payload_type: :raw,
            http_response_code_member: [:status_code, response_code_member]
          )
        end
      end
    end
  end
end
