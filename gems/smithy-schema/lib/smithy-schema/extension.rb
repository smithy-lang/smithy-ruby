# frozen_string_literal: true

module Smithy
  module Schema
    # Cached schema metadata shared by Smithy protocol codecs.
    #
    # Raw Smithy trait data remains on +shape.traits+ and +member.traits+ with
    # string keys. Resolved values are cached as flat, schema-prefixed keys on
    # their owning shape, member, or operation.
    # @api private
    module Extension
      class << self
        # Returns the modeled wire-name lookup used by existing serde
        # consumers. The index maps modeled member name to
        # [ruby_member_name, member_shape].
        def wire_index(shape)
          shape[:schema_wire_index] || resolve_aggregate(shape, :wire_index)
        end

        # Returns the canonical build lookup index. The index maps Ruby member
        # name to [modeled_member_name, member_shape].
        def member_index(shape)
          shape[:schema_member_index] || resolve_aggregate(shape, :member_index)
        end

        # Returns the modeled media type, when present.
        def media_type(shape)
          shape.fetch_metadata(:schema_media_type) do
            shape.traits['smithy.api#mediaType']
          end
        end

        # Returns whether the sensitive trait is present.
        def sensitive?(shape)
          shape.fetch_metadata(:schema_sensitive) do
            shape.traits.key?('smithy.api#sensitive')
          end
        end

        # Returns whether the streaming trait is present.
        def streaming?(shape)
          shape.fetch_metadata(:schema_streaming) do
            shape.traits.key?('smithy.api#streaming')
          end
        end

        # Returns whether the requires-length trait is present.
        def requires_length?(shape)
          shape.fetch_metadata(:schema_requires_length) do
            shape.traits.key?('smithy.api#requiresLength')
          end
        end

        def endpoint_host_prefix(operation)
          operation.fetch_metadata(:schema_endpoint_host_prefix) do
            resolve_operation(operation, :endpoint_host_prefix)
          end
        end

        def endpoint_host_prefix_plan(operation)
          operation.fetch_metadata(:schema_endpoint_host_prefix_plan) do
            resolve_operation(operation, :endpoint_host_prefix_plan)
          end
        end

        def request_compression_encodings(operation)
          operation.fetch_metadata(:schema_request_compression_encodings) do
            resolve_operation(operation, :request_compression_encodings)
          end
        end

        def checksum_required?(operation)
          operation.fetch_metadata(:schema_checksum_required) do
            operation.traits.key?('smithy.api#httpChecksumRequired')
          end
        end

        def long_polling?(operation)
          operation.fetch_metadata(:schema_long_polling) do
            operation.traits.key?('smithy.api#longPoll')
          end
        end

        def unsigned_payload?(operation)
          operation.fetch_metadata(:schema_unsigned_payload) do
            operation.traits.key?('aws.auth#unsignedPayload')
          end
        end

        # Returns operation errors indexed by target shape name.
        def error_index(operation)
          operation[:schema_error_index] || resolve_operation(operation, :error_index)
        end

        def required_members(shape)
          shape[:schema_required_members] || resolve_aggregate(shape, :required_members)
        end

        def host_label_index(shape)
          shape[:schema_host_label_index] || resolve_aggregate(shape, :host_label_index)
        end

        def idempotency_token_member(shape)
          shape.fetch_metadata(:schema_idempotency_token_member) do
            resolve_aggregate(shape, :idempotency_token_member)
          end
        end

        def streaming_member(shape)
          shape.fetch_metadata(:schema_streaming_member) do
            resolve_aggregate(shape, :streaming_member)
          end
        end

        def streaming_member_unknown_length(shape)
          shape.fetch_metadata(:schema_streaming_member_unknown_length) do
            resolve_aggregate(shape, :streaming_member_unknown_length)
          end
        end

        def event_stream_member(shape)
          shape.fetch_metadata(:schema_event_stream_member) do
            resolve_aggregate(shape, :event_stream_member)
          end
        end

        # Returns the effective timestamp format, or +:default+ when the model
        # does not select one.
        def timestamp_format(shape)
          shape[:schema_timestamp_format] ||= resolve_timestamp_format(shape)
        end

        # Iterates modeled members with separate Ruby name and member-shape
        # arguments. With no block, returns the underlying enumerator.
        def each_member(shape, &block)
          return shape.members.each unless block

          shape.members.each { |name, member| block.call(name, member) }
        end

        # Returns whether a collection may retain nil values.
        def sparse?(shape)
          shape.fetch_metadata(:schema_sparse) do
            shape.traits.key?('smithy.api#sparse')
          end
        end

        private

        def resolve_operation(operation, result)
          traits = operation.traits
          endpoint_host_prefix = traits.dig('smithy.api#endpoint', 'hostPrefix')
          endpoint_host_prefix_plan = build_endpoint_host_prefix_plan(operation, endpoint_host_prefix)
          request_compression_encodings = traits.dig('smithy.api#requestCompression', 'encodings')
          error_index = build_error_index(operation)

          operation[:schema_endpoint_host_prefix] = endpoint_host_prefix
          operation[:schema_endpoint_host_prefix_plan] = endpoint_host_prefix_plan
          operation[:schema_request_compression_encodings] = request_compression_encodings
          operation[:schema_error_index] = error_index

          case result
          when :endpoint_host_prefix then endpoint_host_prefix
          when :endpoint_host_prefix_plan then endpoint_host_prefix_plan
          when :request_compression_encodings then request_compression_encodings
          when :error_index then error_index
          end
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

        # rubocop:disable-next Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        def resolve_aggregate(shape, result)
          wire_index = {}
          member_index = {}
          required_members = []
          host_label_index = {}
          idempotency_token_member = nil
          streaming_member = nil
          event_stream_member = nil
          streaming_member_unknown_length = nil

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
            idempotency_token_member ||= ruby_name if member.traits.key?('smithy.api#idempotencyToken')

            target = member.target
            next unless target.traits.key?('smithy.api#streaming')

            streaming_member ||= member
            event_stream_member ||= member if target.instance_of?(Shapes::UnionShape)
            streaming_member_unknown_length ||= member unless target.traits.key?('smithy.api#requiresLength')
          end

          wire_index.freeze
          member_index.freeze
          required_members.freeze
          host_label_index.freeze
          shape[:schema_wire_index] = wire_index
          shape[:schema_member_index] = member_index
          shape[:schema_required_members] = required_members
          shape[:schema_host_label_index] = host_label_index
          shape[:schema_idempotency_token_member] = idempotency_token_member
          shape[:schema_streaming_member] = streaming_member
          shape[:schema_event_stream_member] = event_stream_member
          shape[:schema_streaming_member_unknown_length] = streaming_member_unknown_length

          case result
          when :wire_index then wire_index
          when :member_index then member_index
          when :required_members then required_members
          when :host_label_index then host_label_index
          when :idempotency_token_member then idempotency_token_member
          when :streaming_member then streaming_member
          when :event_stream_member then event_stream_member
          when :streaming_member_unknown_length then streaming_member_unknown_length
          end
        end

        def resolve_timestamp_format(shape)
          target = shape.target
          return :default unless target.is_a?(Shapes::TimestampShape)

          shape.traits['smithy.api#timestampFormat'] ||
            target.traits['smithy.api#timestampFormat'] ||
            :default
        end
      end
    end
  end
end
