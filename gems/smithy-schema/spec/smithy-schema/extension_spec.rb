# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Schema
    describe Extension do
      describe '.wire_index' do
        let(:shape) { Shapes::StructureShape.new }
        let(:member) { Shapes::MemberShape.new(target: Shapes::StringShape.new, name: 'wireName') }

        it 'returns a frozen member index keyed by member name' do
          shape.add_member(:some_member, member)

          expect(described_class.wire_index(shape)).to eq('wireName' => [:some_member, member])
          expect(described_class.wire_index(shape)).to be_frozen
        end

        it 'ignores members that do not have a modeled member name' do
          shape.add_member(:missing_name, Shapes::MemberShape.new(target: Shapes::StringShape.new))

          expect(described_class.wire_index(shape)).to eq({})
        end

      end

      describe '.member_index' do
        let(:shape) { Shapes::StructureShape.new }
        let(:member) { Shapes::MemberShape.new(target: Shapes::StringShape.new, name: 'wireName') }

        it 'returns a frozen build index keyed by Ruby member name' do
          shape.add_member(:some_member, member)

          expect(described_class.member_index(shape)).to eq(some_member: ['wireName', member])
          expect(described_class.member_index(shape)).to be_frozen
        end

        it 'ignores members that do not have a modeled member name' do
          shape.add_member(:missing_name, Shapes::MemberShape.new(target: Shapes::StringShape.new))

          expect(described_class.member_index(shape)).to eq({})
        end

      end

      describe '.host_label_index' do
        let(:shape) { Shapes::StructureShape.new }

        it 'returns a frozen host-label index keyed by modeled label name' do
          shape.add_member(
            :account_id,
            Shapes::MemberShape.new(
              target: Shapes::StringShape.new,
              name: 'accountId',
              traits: { 'smithy.api#hostLabel' => {} }
            )
          )

          expect(described_class.host_label_index(shape)).to eq('accountId' => :account_id)
          expect(described_class.host_label_index(shape)).to be_frozen
        end

        it 'ignores non-host-label members' do
          shape.add_member(:string, Shapes::MemberShape.new(target: Shapes::StringShape.new, name: 'string'))

          expect(described_class.host_label_index(shape)).to eq({})
        end

      end

      describe '.default_members' do
        let(:shape) { Shapes::StructureShape.new }

        it 'returns a frozen list of members with default and without clientOptional' do
          default_member = Shapes::MemberShape.new(
            target: Shapes::StringShape.new,
            name: 'defaulted',
            traits: { 'smithy.api#default' => 'value' }
          )
          client_optional_member = Shapes::MemberShape.new(
            target: Shapes::StringShape.new,
            name: 'optional',
            traits: {
              'smithy.api#default' => 'value',
              'smithy.api#clientOptional' => {}
            }
          )
          shape.add_member(:defaulted, default_member)
          shape.add_member(:optional, client_optional_member)

          expect(described_class.default_members(shape)).to eq([[:defaulted, default_member]])
          expect(described_class.default_members(shape)).to be_frozen
        end

        it 'returns an empty list when no members are eligible' do
          shape.add_member(:string, Shapes::MemberShape.new(target: Shapes::StringShape.new, name: 'string'))

          expect(described_class.default_members(shape)).to eq([])
        end

      end

      describe '.required_members' do
        let(:shape) { Shapes::StructureShape.new }

        it 'returns a frozen list of member names with required and without clientOptional' do
          required_member = Shapes::MemberShape.new(
            target: Shapes::StringShape.new,
            name: 'required',
            traits: { 'smithy.api#required' => {} }
          )
          client_optional_member = Shapes::MemberShape.new(
            target: Shapes::StringShape.new,
            name: 'optional',
            traits: {
              'smithy.api#required' => {},
              'smithy.api#clientOptional' => {}
            }
          )
          shape.add_member(:required, required_member)
          shape.add_member(:optional, client_optional_member)

          expect(described_class.required_members(shape)).to eq([:required])
          expect(described_class.required_members(shape)).to be_frozen
        end

        it 'returns an empty list when no members are eligible' do
          shape.add_member(:string, Shapes::MemberShape.new(target: Shapes::StringShape.new, name: 'string'))

          expect(described_class.required_members(shape)).to eq([])
        end

      end

      describe '.idempotency_token_member' do
        let(:shape) { Shapes::StructureShape.new }

        it 'returns the ruby member name with the trait' do
          shape.add_member(
            :client_token,
            Shapes::MemberShape.new(
              target: Shapes::StringShape.new,
              name: 'clientToken',
              traits: { 'smithy.api#idempotencyToken' => {} }
            )
          )

          expect(described_class.idempotency_token_member(shape)).to eq(:client_token)
        end

      end

      describe '.request_compression_encodings' do
        it 'returns the modeled request compression encodings' do
          operation = Shapes::OperationShape.new(
            traits: { 'smithy.api#requestCompression' => { 'encodings' => ['gzip'] } }
          )

          expect(described_class.request_compression_encodings(operation)).to eq(['gzip'])
        end
      end

      describe '.xml_flattened?' do
        it 'returns true when xmlFlattened is present' do
          member = Shapes::MemberShape.new(
            target: Shapes::ListShape.new,
            traits: { 'smithy.api#xmlFlattened' => {} }
          )

          expect(described_class.xml_flattened?(member)).to be(true)
        end

        it 'returns false when xmlFlattened is absent' do
          member = Shapes::MemberShape.new(target: Shapes::ListShape.new)

          expect(described_class.xml_flattened?(member)).to be(false)
        end
      end

      describe '.media_type' do
        it 'returns the modeled media type trait value' do
          shape = Shapes::StringShape.new(
            traits: { 'smithy.api#mediaType' => 'application/custom' }
          )

          expect(described_class.media_type(shape)).to eq('application/custom')
        end
      end

      describe '.streaming_member' do
        let(:shape) { Shapes::StructureShape.new }

        it 'returns the member when it targets a streaming shape' do
          stream_target = Shapes::BlobShape.new(traits: { 'smithy.api#streaming' => {} })
          stream_member = Shapes::MemberShape.new(target: stream_target, name: 'stream')
          shape.add_member(:stream, stream_member)

          expect(described_class.streaming_member(shape)).to be(stream_member)
        end

      end

      describe '.default_trait' do
        it 'returns the modeled default trait payload' do
          member = Shapes::MemberShape.new(
            target: Shapes::StringShape.new,
            traits: { 'smithy.api#default' => 'value' }
          )

          expect(described_class.default_trait(member)).to eq('value')
        end

        it 'returns nil when the trait is absent' do
          member = Shapes::MemberShape.new(target: Shapes::StringShape.new)

          expect(described_class.default_trait(member)).to be_nil
        end
      end

      describe '.error_index' do
        let(:operation) { Shapes::OperationShape.new }
        let(:error_shape) { Shapes::StructureShape.new(name: 'Error') }

        it 'returns a frozen error index keyed by modeled error name' do
          operation.errors = [error_shape]

          expect(described_class.error_index(operation)).to eq('Error' => error_shape)
          expect(described_class.error_index(operation)).to be_frozen
        end

        it 'ignores error shapes that do not have a modeled name' do
          operation.errors = [Shapes::StructureShape.new]

          expect(described_class.error_index(operation)).to eq({})
        end

      end

      describe '.endpoint_host_prefix' do
        it 'returns the modeled endpoint host prefix' do
          operation = Shapes::OperationShape.new(
            traits: { 'smithy.api#endpoint' => { 'hostPrefix' => 'foo.' } }
          )

          expect(described_class.endpoint_host_prefix(operation)).to eq('foo.')
        end

      end

      describe '.event_stream_member' do
        let(:shape) { Shapes::StructureShape.new }
        let(:stream_target) do
          Shapes::UnionShape.new(traits: { 'smithy.api#streaming' => {} })
        end
        let(:stream_member) { Shapes::MemberShape.new(target: stream_target, name: 'events') }

        it 'returns the member when it targets a streaming union' do
          shape.add_member(:events, stream_member)

          expect(described_class.event_stream_member(shape)).to be(stream_member)
        end

        it 'returns the streaming union member even when payload metadata is absent' do
          shape.add_member(:events, stream_member)

          expect(described_class.event_stream_member(shape)).to be(stream_member)
        end

        describe '.event_streaming?' do
          it 'returns true when the shape has a streaming union member' do
            shape.add_member(:events, stream_member)

            expect(described_class.event_streaming?(shape)).to be(true)
          end

          it 'returns false when the shape has no streaming union member' do
            shape.add_member(:string, Shapes::MemberShape.new(target: Shapes::StringShape.new, name: 'string'))

            expect(described_class.event_streaming?(shape)).to be(false)
          end
        end
      end

      describe '.streaming_member_without_length' do
        let(:shape) { Shapes::StructureShape.new }

        it 'returns the member when it targets a streaming shape without requiresLength' do
          stream_target = Shapes::BlobShape.new(traits: { 'smithy.api#streaming' => {} })
          stream_member = Shapes::MemberShape.new(target: stream_target, name: 'stream')
          shape.add_member(:stream, stream_member)

          expect(described_class.streaming_member_without_length(shape)).to be(stream_member)
        end

        it 'ignores streaming members that require length' do
          stream_target = Shapes::BlobShape.new(
            traits: {
              'smithy.api#streaming' => {},
              'smithy.api#requiresLength' => {}
            }
          )
          shape.add_member(:stream, Shapes::MemberShape.new(target: stream_target, name: 'stream'))

          expect(described_class.streaming_member_without_length(shape)).to be_nil
        end
      end

      describe '.wire_name' do
        it 'returns the model name' do
          member = Shapes::MemberShape.new(
            target: Shapes::StringShape.new,
            name: 'wireName',
            traits: { 'smithy.api#jsonName' => 'jsonWireName' }
          )

          expect(described_class.wire_name(member)).to eq('wireName')
        end
      end

      describe '.checksum_required?' do
        it 'returns whether the operation has the checksum-required trait' do
          operation = Shapes::OperationShape.new(
            traits: { 'smithy.api#httpChecksumRequired' => {} }
          )

          expect(described_class.checksum_required?(operation)).to be(true)
          expect(described_class.checksum_required?(Shapes::OperationShape.new)).to be(false)
        end
      end

      describe '.long_polling?' do
        it 'returns whether the operation has the long-poll trait' do
          operation = Shapes::OperationShape.new(
            traits: { 'smithy.api#longPoll' => {} }
          )

          expect(described_class.long_polling?(operation)).to be(true)
          expect(described_class.long_polling?(Shapes::OperationShape.new)).to be(false)
        end
      end

      describe '.timestamp_format' do
        it 'prefers the member trait' do
          member = Shapes::MemberShape.new(
            target: Shapes::TimestampShape.new(
              traits: { 'smithy.api#timestampFormat' => 'http-date' }
            ),
            traits: { 'smithy.api#timestampFormat' => 'date-time' }
          )

          expect(described_class.timestamp_format(member)).to eq('date-time')
        end

        it 'falls back to the target shape trait' do
          member = Shapes::MemberShape.new(
            target: Shapes::TimestampShape.new(
              traits: { 'smithy.api#timestampFormat' => 'http-date' }
            )
          )

          expect(described_class.timestamp_format(member)).to eq('http-date')
        end

        it 'returns :default when no explicit format is modeled' do
          member = Shapes::MemberShape.new(target: Shapes::TimestampShape.new)

          expect(described_class.timestamp_format(member)).to eq(:default)
        end

      end

      describe '.requires_length?' do
        it 'returns whether the shape has the requiresLength trait' do
          shape = Shapes::BlobShape.new(traits: { 'smithy.api#requiresLength' => {} })

          expect(described_class.requires_length?(shape)).to be(true)
          expect(described_class.requires_length?(Shapes::BlobShape.new)).to be(false)
        end
      end

      describe '.streaming?' do
        it 'returns whether the shape has the streaming trait' do
          shape = Shapes::BlobShape.new(traits: { 'smithy.api#streaming' => {} })

          expect(described_class.streaming?(shape)).to be(true)
          expect(described_class.streaming?(Shapes::BlobShape.new)).to be(false)
        end
      end

      describe '.unsigned_payload?' do
        it 'returns whether the operation has the unsignedPayload trait' do
          operation = Shapes::OperationShape.new(
            traits: { 'aws.auth#unsignedPayload' => {} }
          )

          expect(described_class.unsigned_payload?(operation)).to be(true)
          expect(described_class.unsigned_payload?(Shapes::OperationShape.new)).to be(false)
        end
      end
    end
  end
end
