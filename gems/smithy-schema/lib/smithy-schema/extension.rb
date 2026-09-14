# frozen_string_literal: true

module Smithy
  module Schema
    # Cached schema metadata shared by Smithy protocol codecs.
    #
    # Raw Smithy trait data remains on +shape.traits+ and +member.traits+ with
    # string keys. This module resolves generic shape classification and
    # modeled-member indexes. Protocol extensions own wire-specific metadata.
    # @api private
    # rubocop:disable-next Metrics/ModuleLength
    module Extension
      KEY = :schema

      SHAPE_LIST = 1
      SHAPE_MAP = 2
      SHAPE_STRUCTURE = 3
      SHAPE_UNION = 4
      SHAPE_BLOB = 5
      SHAPE_FLOAT = 6
      SHAPE_TIMESTAMP = 7
      SHAPE_BIG_DECIMAL = 8
      SHAPE_BOOLEAN = 9
      SHAPE_DOCUMENT = 10
      SHAPE_ENUM = 11
      SHAPE_INTEGER = 12
      SHAPE_INT_ENUM = 13
      SHAPE_STRING = 14

      SHAPE_REF_BY_CLASS = {
        Shapes::ListShape => SHAPE_LIST,
        Shapes::MapShape => SHAPE_MAP,
        Shapes::StructureShape => SHAPE_STRUCTURE,
        Shapes::UnionShape => SHAPE_UNION,
        Shapes::BlobShape => SHAPE_BLOB,
        Shapes::FloatShape => SHAPE_FLOAT,
        Shapes::TimestampShape => SHAPE_TIMESTAMP,
        Shapes::BigDecimalShape => SHAPE_BIG_DECIMAL,
        Shapes::BooleanShape => SHAPE_BOOLEAN,
        Shapes::DocumentShape => SHAPE_DOCUMENT,
        Shapes::EnumShape => SHAPE_ENUM,
        Shapes::IntegerShape => SHAPE_INTEGER,
        Shapes::IntEnumShape => SHAPE_INT_ENUM,
        Shapes::StringShape => SHAPE_STRING
      }.freeze

      class << self
        # Returns the complete cached Schema metadata payload.
        #
        # Example:
        #   Extension.fetch(shape)
        #   # => { target_shape: Extension::SHAPE_STRUCTURE, ... }
        def fetch(shape)
          return shape[KEY] if shape.key?(KEY)

          shape[KEY] =
            case shape
            when Shapes::OperationShape
              build_operation_metadata(shape)
            when Shapes::StructureShape, Shapes::UnionShape
              build_aggregate_metadata(shape)
            when Shapes::MemberShape
              build_member_metadata(shape)
            else
              build_shape_metadata(shape)
            end
        end

        # Returns the modeled wire-name lookup used by existing serde
        # consumers. The index maps modeled member name to
        # [ruby_member_name, member_shape, target_shape_ref].
        #
        # Example:
        #   Extension.wire_index(shape)
        #   # => { 'wireName' => [:ruby_name, member, Extension::SHAPE_STRING] }
        def wire_index(shape)
          fetch(shape)[:wire_index]
        end

        # Returns the canonical build lookup index. The index maps Ruby member
        # name to [modeled_member_name, member_shape, target_shape_ref].
        #
        # Example:
        #   Extension.member_index(shape)
        #   # => { ruby_name: ['wireName', member, Extension::SHAPE_STRING] }
        def member_index(shape)
          fetch(shape)[:member_index]
        end

        # Returns a normalized reference for the target shape of +shape+.
        # Bare shapes reference themselves, while member shapes reference
        # their modeled target.
        #
        # Example:
        #   Extension.target_shape(member)
        #   # => Extension::SHAPE_STRING
        def target_shape(shape)
          fetch(shape)[:target_shape]
        end

        # Returns [member_shape, target_shape_ref, sparse] for a list.
        #
        # Example:
        #   Extension.list_member(list)
        #   # => [member, Extension::SHAPE_STRING, true]
        def list_member(shape)
          fetch(shape)[:list_member]
        end

        # Returns [member_shape, target_shape_ref] for a map key.
        #
        # Example:
        #   Extension.map_key_member(map)
        #   # => [member, Extension::SHAPE_STRING]
        def map_key_member(shape)
          fetch(shape)[:map_key_member]
        end

        # Returns [member_shape, target_shape_ref, sparse] for a map value.
        #
        # Example:
        #   Extension.map_value_member(map)
        #   # => [member, Extension::SHAPE_STRING, false]
        def map_value_member(shape)
          fetch(shape)[:map_value_member]
        end

        # Returns the modeled media type, when present.
        #
        # Example:
        #   Extension.media_type(shape)
        #   # => 'application/octet-stream'
        def media_type(shape)
          fetch(shape)[:media_type]
        end

        # Returns whether the sensitive trait is present.
        def sensitive?(shape)
          fetch(shape)[:sensitive]
        end

        # Returns whether the streaming trait is present.
        def streaming?(shape)
          fetch(shape)[:streaming]
        end

        # Returns whether the requires-length trait is present.
        def requires_length?(shape)
          fetch(shape)[:requires_length]
        end

        def endpoint_host_prefix(operation)
          fetch(operation)[:endpoint_host_prefix]
        end

        def request_compression_encodings(operation)
          fetch(operation)[:request_compression_encodings]
        end

        def checksum_required?(operation)
          fetch(operation)[:checksum_required]
        end

        def long_polling?(operation)
          fetch(operation)[:long_polling]
        end

        def unsigned_payload?(operation)
          fetch(operation)[:unsigned_payload]
        end

        # Returns operation errors indexed by target shape name.
        #
        # Example:
        #   Extension.error_index(operation)['ResourceNotFound']
        #   # => error_member
        def error_index(operation)
          fetch(operation).fetch(:error_index, {}.freeze)
        end

        def required_members(shape)
          fetch(shape).fetch(:required_members, [].freeze)
        end

        def host_label_index(shape)
          fetch(shape).fetch(:host_label_index, {}.freeze)
        end

        def idempotency_token_member(shape)
          fetch(shape)[:idempotency_token_member]
        end

        def streaming_member(shape)
          fetch(shape)[:streaming_member]
        end

        def streaming_member_unknown_length(shape)
          fetch(shape)[:streaming_member_unknown_length]
        end

        def event_stream_member(shape)
          fetch(shape)[:event_stream_member]
        end

        # Returns the effective timestamp format, or +:default+ when the
        # model does not select one.
        #
        # Example:
        #   Extension.timestamp_format(member)
        #   # => 'date-time'
        def timestamp_format(shape)
          fetch(shape).fetch(:timestamp_format, :default)
        end

        # Returns a modeled union's unknown-member type when present.
        #
        # Example:
        #   Extension.unknown_member_type(union)
        #   # => Types::Unknown
        def unknown_member_type(shape)
          fetch(shape)[:unknown_member_type]
        end

        # Iterates modeled members with separate Ruby name and member-shape
        # arguments. With no block, returns the underlying enumerator.
        #
        # Example:
        #   Extension.each_member(shape) { |name, member| ... }
        def each_member(shape, &block)
          return shape.members.each unless block

          shape.members.each { |name, member| block.call(name, member) }
        end

        # Returns whether a collection may retain nil values.
        #
        # Example:
        #   Extension.sparse?(list)
        #   # => true
        def sparse?(shape)
          shape.traits.key?('smithy.api#sparse')
        end

        private

        def build_operation_metadata(operation)
          traits = operation.traits
          {
            endpoint_host_prefix: traits.dig('smithy.api#endpoint', 'hostPrefix'),
            request_compression_encodings: traits.dig('smithy.api#requestCompression', 'encodings'),
            checksum_required: traits.key?('smithy.api#httpChecksumRequired') || nil,
            long_polling: traits.key?('smithy.api#longPoll') || nil,
            unsigned_payload: traits.key?('aws.auth#unsignedPayload') || nil,
            error_index: build_error_index(operation)
          }.compact.freeze
        end

        def build_error_index(operation)
          operation.errors.each_with_object({}) do |error, index|
            index[error.target.name] = error if error.target&.name
          end.freeze
        end

        def build_shape_metadata(shape)
          target = shape.target
          target_shape = SHAPE_REF_BY_CLASS[target.class]
          metadata = { target_shape: target_shape }.compact
          add_collection_metadata(metadata, shape) if target.equal?(shape)
          add_media_type_metadata(metadata, shape)
          add_boolean_trait_metadata(metadata, shape)
          add_timestamp_metadata(metadata, shape)
          metadata[:unknown_member_type] = shape.member_type(:unknown) if
            target_shape == SHAPE_UNION && shape.member_type?(:unknown)
          metadata.freeze
        end

        def build_member_metadata(member)
          target_shape = SHAPE_REF_BY_CLASS[member.target.class] if member.target
          metadata = { target_shape: target_shape }.compact
          add_media_type_metadata(metadata, member)
          add_boolean_trait_metadata(metadata, member)
          add_timestamp_metadata(metadata, member)
          metadata.freeze
        end

        # rubocop:disable-next Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        def build_aggregate_metadata(shape)
          metadata = build_shape_metadata(shape).dup
          wire_index = {}
          member_index = {}
          required_members = []
          host_label_index = {}

          shape.members.each do |ruby_name, member|
            modeled_name = member.name
            next unless modeled_name

            target_shape = fetch(member)[:target_shape]
            wire_index[modeled_name] = [ruby_name, member, target_shape].freeze
            member_index[ruby_name] = [modeled_name, member, target_shape].freeze
            if member.traits.key?('smithy.api#required') &&
               !member.traits.key?('smithy.api#clientOptional')
              required_members << ruby_name
            end
            host_label_index[modeled_name] = ruby_name if member.traits.key?('smithy.api#hostLabel')
            metadata[:idempotency_token_member] ||= ruby_name if member.traits.key?('smithy.api#idempotencyToken')
            next unless streaming_trait?(member.target)

            metadata[:streaming_member] ||= member
            metadata[:event_stream_member] ||= member if target_shape == SHAPE_UNION
            metadata[:streaming_member_unknown_length] ||= member unless requires_length_trait?(member.target)
          end

          metadata[:wire_index] = wire_index.freeze
          metadata[:member_index] = member_index.freeze
          metadata[:required_members] = required_members.freeze
          metadata[:host_label_index] = host_label_index.freeze
          metadata.freeze
        end

        def add_collection_metadata(metadata, shape)
          case shape
          when Shapes::ListShape
            metadata[:list_member] = member_metadata(shape.member, sparse?(shape))
          when Shapes::MapShape
            metadata[:map_key_member] = member_metadata(shape.key)
            metadata[:map_value_member] = member_metadata(shape.value, sparse?(shape))
          end
        end

        def add_timestamp_metadata(metadata, shape)
          return unless metadata[:target_shape] == SHAPE_TIMESTAMP

          metadata[:timestamp_format] =
            shape.traits['smithy.api#timestampFormat'] ||
            shape.target.traits['smithy.api#timestampFormat'] ||
            :default
        end

        def add_media_type_metadata(metadata, shape)
          media_type = shape.traits['smithy.api#mediaType']
          metadata[:media_type] = media_type if media_type
        end

        def add_boolean_trait_metadata(metadata, shape)
          metadata[:sensitive] = true if shape.traits.key?('smithy.api#sensitive')
          metadata[:streaming] = true if streaming_trait?(shape)
          metadata[:requires_length] = true if requires_length_trait?(shape)
        end

        def streaming_trait?(shape)
          shape.traits.key?('smithy.api#streaming')
        end

        def requires_length_trait?(shape)
          shape.traits.key?('smithy.api#requiresLength')
        end

        def member_metadata(member, sparse = nil)
          target_shape = target_shape(member) if member
          [member, target_shape, sparse].compact.freeze
        end
      end
    end
  end
end
