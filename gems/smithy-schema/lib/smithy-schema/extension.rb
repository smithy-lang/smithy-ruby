# frozen_string_literal: true

module Smithy
  module Schema
    # Cached schema metadata shared by Smithy protocol codecs.
    #
    # Raw Smithy trait data remains on +shape.traits+ and +member.traits+ with
    # string keys. This module resolves modeled-member indexes. Protocol
    # extensions own wire-specific metadata.
    # @api private
    module Extension
      KEY = :schema

      class << self
        # Returns the complete cached Schema metadata payload.
        #
        # Example:
        #   Extension.fetch(shape)
        #   # => { wire_index: ..., ... }
        def fetch(shape)
          shape[KEY] || build_and_cache(shape)
        end

        # Returns the modeled wire-name lookup used by existing serde
        # consumers. The index maps modeled member name to
        # [ruby_member_name, member_shape].
        #
        # Example:
        #   Extension.wire_index(shape)
        #   # => { 'wireName' => [:ruby_name, member] }
        def wire_index(shape)
          (shape[KEY] || build_and_cache(shape))[:wire_index]
        end

        # Returns the canonical build lookup index. The index maps Ruby member
        # name to [modeled_member_name, member_shape].
        #
        # Example:
        #   Extension.member_index(shape)
        #   # => { ruby_name: ['wireName', member] }
        def member_index(shape)
          (shape[KEY] || build_and_cache(shape))[:member_index]
        end

        # Returns the modeled media type, when present.
        #
        # Example:
        #   Extension.media_type(shape)
        #   # => 'application/octet-stream'
        def media_type(shape)
          (shape[KEY] || build_and_cache(shape))[:media_type]
        end

        # Returns whether the sensitive trait is present.
        def sensitive?(shape)
          (shape[KEY] || build_and_cache(shape))[:sensitive]
        end

        # Returns whether the streaming trait is present.
        def streaming?(shape)
          (shape[KEY] || build_and_cache(shape))[:streaming]
        end

        # Returns whether the requires-length trait is present.
        def requires_length?(shape)
          (shape[KEY] || build_and_cache(shape))[:requires_length]
        end

        def endpoint_host_prefix(operation)
          (operation[KEY] || build_and_cache(operation))[:endpoint_host_prefix]
        end

        def endpoint_host_prefix_plan(operation)
          (operation[KEY] || build_and_cache(operation))[:endpoint_host_prefix_plan]
        end

        def request_compression_encodings(operation)
          (operation[KEY] || build_and_cache(operation))[:request_compression_encodings]
        end

        def checksum_required?(operation)
          (operation[KEY] || build_and_cache(operation))[:checksum_required]
        end

        def long_polling?(operation)
          (operation[KEY] || build_and_cache(operation))[:long_polling]
        end

        def unsigned_payload?(operation)
          (operation[KEY] || build_and_cache(operation))[:unsigned_payload]
        end

        # Returns operation errors indexed by target shape name.
        #
        # Example:
        #   Extension.error_index(operation)['ResourceNotFound']
        #   # => error_member
        def error_index(operation)
          (operation[KEY] || build_and_cache(operation)).fetch(:error_index, {}.freeze)
        end

        def required_members(shape)
          (shape[KEY] || build_and_cache(shape)).fetch(:required_members, [].freeze)
        end

        def host_label_index(shape)
          (shape[KEY] || build_and_cache(shape)).fetch(:host_label_index, {}.freeze)
        end

        def idempotency_token_member(shape)
          (shape[KEY] || build_and_cache(shape))[:idempotency_token_member]
        end

        def streaming_member(shape)
          (shape[KEY] || build_and_cache(shape))[:streaming_member]
        end

        def streaming_member_unknown_length(shape)
          (shape[KEY] || build_and_cache(shape))[:streaming_member_unknown_length]
        end

        def event_stream_member(shape)
          (shape[KEY] || build_and_cache(shape))[:event_stream_member]
        end

        # Returns the effective timestamp format, or +:default+ when the
        # model does not select one.
        #
        # Example:
        #   Extension.timestamp_format(member)
        #   # => 'date-time'
        def timestamp_format(shape)
          (shape[KEY] || build_and_cache(shape)).fetch(:timestamp_format, :default)
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

        def build_and_cache(shape)
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

        def build_operation_metadata(operation)
          traits = operation.traits
          endpoint_host_prefix = traits.dig('smithy.api#endpoint', 'hostPrefix')
          {
            endpoint_host_prefix: endpoint_host_prefix,
            endpoint_host_prefix_plan: build_endpoint_host_prefix_plan(operation, endpoint_host_prefix),
            request_compression_encodings: traits.dig('smithy.api#requestCompression', 'encodings'),
            checksum_required: traits.key?('smithy.api#httpChecksumRequired') || nil,
            long_polling: traits.key?('smithy.api#longPoll') || nil,
            unsigned_payload: traits.key?('aws.auth#unsignedPayload') || nil,
            error_index: build_error_index(operation)
          }.compact.freeze
        end

        def build_endpoint_host_prefix_plan(operation, host_prefix)
          return unless host_prefix

          host_labels = host_label_index(operation.input)
          plan = []
          offset = 0
          host_prefix.to_enum(:scan, /\{(.+?)}/).each do
            match = Regexp.last_match
            offset = append_host_prefix_match(plan, host_prefix, host_labels, match, offset)
          end
          plan << host_prefix[offset..].freeze if offset < host_prefix.length
          plan.freeze
        end

        def append_host_prefix_match(plan, host_prefix, host_labels, match, offset)
          plan << host_prefix[offset...match.begin(0)].freeze if match.begin(0) > offset
          label = match[1]
          name = host_labels[label]
          raise ArgumentError, "#{label} is not a valid host label" unless name

          plan << name
          match.end(0)
        end

        def build_error_index(operation)
          operation.errors.each_with_object({}) do |error, index|
            index[error.target.name] = error if error.target&.name
          end.freeze
        end

        def build_shape_metadata(shape)
          metadata = {}
          add_media_type_metadata(metadata, shape)
          add_boolean_trait_metadata(metadata, shape)
          add_timestamp_metadata(metadata, shape)
          metadata.freeze
        end

        def build_member_metadata(member)
          metadata = {}
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

            wire_index[modeled_name] = [ruby_name, member].freeze
            member_index[ruby_name] = [modeled_name, member].freeze
            if member.traits.key?('smithy.api#required') &&
               !member.traits.key?('smithy.api#clientOptional')
              required_members << ruby_name
            end
            host_label_index[modeled_name] = ruby_name if member.traits.key?('smithy.api#hostLabel')
            metadata[:idempotency_token_member] ||= ruby_name if member.traits.key?('smithy.api#idempotencyToken')
            target = member.target
            next unless streaming_trait?(target)

            metadata[:streaming_member] ||= member
            metadata[:event_stream_member] ||= member if target.instance_of?(Shapes::UnionShape)
            metadata[:streaming_member_unknown_length] ||= member unless requires_length_trait?(target)
          end

          metadata[:wire_index] = wire_index.freeze
          metadata[:member_index] = member_index.freeze
          metadata[:required_members] = required_members.freeze
          metadata[:host_label_index] = host_label_index.freeze
          metadata.freeze
        end

        def add_timestamp_metadata(metadata, shape)
          target = shape.target
          return unless target.is_a?(Shapes::TimestampShape)

          metadata[:timestamp_format] =
            shape.traits['smithy.api#timestampFormat'] ||
            target.traits['smithy.api#timestampFormat'] ||
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
      end
    end
  end
end
