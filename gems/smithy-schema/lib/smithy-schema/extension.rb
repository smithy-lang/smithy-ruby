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
        #
        # Example:
        #   Extension.wire_index(shape)['ModeledName']
        #   # => [:ruby_name, member]
        def wire_index(shape)
          shape[:schema_wire_index] || resolve_aggregate(shape, :schema_wire_index)
        end

        # Returns the canonical build lookup index. The index maps Ruby member
        # name to [modeled_member_name, member_shape].
        #
        # Example:
        #   Extension.member_index(shape)[:ruby_name]
        #   # => ['ModeledName', member]
        def member_index(shape)
          shape[:schema_member_index] || resolve_aggregate(shape, :schema_member_index)
        end

        # Returns the modeled media type, when present.
        #
        # Example:
        #   Extension.media_type(shape)
        #   # => 'application/json'
        def media_type(shape)
          shape.fetch_metadata(:schema_media_type) do
            shape.traits['smithy.api#mediaType']
          end
        end

        # Returns whether the sensitive trait is present.
        #
        # Example:
        #   Extension.sensitive?(shape)
        #   # => true
        def sensitive?(shape)
          shape.fetch_metadata(:schema_sensitive) do
            shape.traits.key?('smithy.api#sensitive')
          end
        end

        # Returns whether the streaming trait is present.
        #
        # Example:
        #   Extension.streaming?(shape)
        #   # => true
        def streaming?(shape)
          shape.fetch_metadata(:schema_streaming) do
            shape.traits.key?('smithy.api#streaming')
          end
        end

        # Returns whether the requires-length trait is present.
        #
        # Example:
        #   Extension.requires_length?(shape)
        #   # => true
        def requires_length?(shape)
          shape.fetch_metadata(:schema_requires_length) do
            shape.traits.key?('smithy.api#requiresLength')
          end
        end

        # Returns the endpoint host prefix.
        #
        # Example:
        #   Extension.endpoint_host_prefix(operation)
        #   # => '{account_id}.example.com'
        def endpoint_host_prefix(operation)
          operation.fetch_metadata(:schema_endpoint_host_prefix) do
            resolve_endpoint(operation, :schema_endpoint_host_prefix)
          end
        end

        # Returns the compiled endpoint host-prefix plan.
        #
        # Example:
        #   Extension.endpoint_host_prefix_plan(operation)
        #   # => [:account_id, '.example.com']
        def endpoint_host_prefix_plan(operation)
          operation.fetch_metadata(:schema_endpoint_host_prefix_plan) do
            resolve_endpoint(operation, :schema_endpoint_host_prefix_plan)
          end
        end

        # Returns the supported request-compression encodings.
        #
        # Example:
        #   Extension.request_compression_encodings(operation)
        #   # => ['gzip']
        def request_compression_encodings(operation)
          operation.fetch_metadata(:schema_request_compression_encodings) do
            operation.traits.dig('smithy.api#requestCompression', 'encodings')
          end
        end

        # Returns whether an HTTP checksum is required.
        #
        # Example:
        #   Extension.checksum_required?(operation)
        #   # => true
        def checksum_required?(operation)
          operation.fetch_metadata(:schema_checksum_required) do
            operation.traits.key?('smithy.api#httpChecksumRequired')
          end
        end

        # Returns whether an operation uses long polling.
        #
        # Example:
        #   Extension.long_polling?(operation)
        #   # => true
        def long_polling?(operation)
          operation.fetch_metadata(:schema_long_polling) do
            operation.traits.key?('smithy.api#longPoll')
          end
        end

        # Returns whether an operation uses an unsigned payload.
        #
        # Example:
        #   Extension.unsigned_payload?(operation)
        #   # => true
        def unsigned_payload?(operation)
          operation.fetch_metadata(:schema_unsigned_payload) do
            operation.traits.key?('aws.auth#unsignedPayload')
          end
        end

        # Returns operation errors indexed by target shape name.
        #
        # Example:
        #   Extension.error_index(operation)['ExampleError']
        #   # => error_member
        def error_index(operation)
          operation[:schema_error_index] ||= build_error_index(operation)
        end

        # Returns required members by Ruby member name.
        #
        # Example:
        #   Extension.required_members(shape)
        #   # => [:name]
        def required_members(shape)
          shape[:schema_required_members] || resolve_aggregate(shape, :schema_required_members)
        end

        # Returns host labels indexed by modeled member name.
        #
        # Example:
        #   Extension.host_label_index(shape)
        #   # => { 'AccountId' => :account_id }
        def host_label_index(shape)
          shape[:schema_host_label_index] || resolve_aggregate(shape, :schema_host_label_index)
        end

        # Returns the idempotency-token member name.
        #
        # Example:
        #   Extension.idempotency_token_member(shape)
        #   # => :client_token
        def idempotency_token_member(shape)
          shape.fetch_metadata(:schema_idempotency_token_member) do
            resolve_aggregate(shape, :schema_idempotency_token_member)
          end
        end

        # Returns the streaming member.
        #
        # Example:
        #   Extension.streaming_member(shape)
        #   # => member
        def streaming_member(shape)
          shape.fetch_metadata(:schema_streaming_member) do
            resolve_aggregate(shape, :schema_streaming_member)
          end
        end

        # Returns the streaming member when its length is unknown.
        #
        # Example:
        #   Extension.streaming_member_unknown_length(shape)
        #   # => member
        def streaming_member_unknown_length(shape)
          shape.fetch_metadata(:schema_streaming_member_unknown_length) do
            resolve_aggregate(shape, :schema_streaming_member_unknown_length)
          end
        end

        # Returns the event-stream member.
        #
        # Example:
        #   Extension.event_stream_member(shape)
        #   # => member
        def event_stream_member(shape)
          shape.fetch_metadata(:schema_event_stream_member) do
            resolve_aggregate(shape, :schema_event_stream_member)
          end
        end

        # Returns the effective timestamp format, or +:default+ when the model
        # does not select one.
        #
        # Example:
        #   Extension.timestamp_format(member)
        #   # => 'date-time'
        def timestamp_format(shape)
          shape[:schema_timestamp_format] ||= resolve_timestamp_format(shape)
        end

        # Iterates modeled members with separate Ruby name and member-shape
        # arguments. With no block, returns the underlying enumerator.
        #
        # Example:
        #   Extension.each_member(shape) { |name, member| }
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
          shape.fetch_metadata(:schema_sparse) do
            shape.traits.key?('smithy.api#sparse')
          end
        end

        private

        def resolve_endpoint(operation, result)
          endpoint_host_prefix = operation.traits.dig('smithy.api#endpoint', 'hostPrefix')
          endpoint_host_prefix_plan = build_endpoint_host_prefix_plan(operation, endpoint_host_prefix)

          operation[:schema_endpoint_host_prefix] = endpoint_host_prefix
          operation[:schema_endpoint_host_prefix_plan] = endpoint_host_prefix_plan
          operation[result]
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

        def resolve_aggregate(shape, result)
          metadata = empty_aggregate_metadata
          shape.members.each do |ruby_name, member|
            next unless member.name

            index_aggregate_member(metadata, ruby_name, member)
            index_streaming_member(metadata, member)
          end

          freeze_aggregate_metadata(metadata)
          metadata.each { |key, value| shape[key] = value }
          metadata.fetch(result)
        end

        def empty_aggregate_metadata
          {
            schema_wire_index: {},
            schema_member_index: {},
            schema_required_members: [],
            schema_host_label_index: {},
            schema_idempotency_token_member: nil,
            schema_streaming_member: nil,
            schema_event_stream_member: nil,
            schema_streaming_member_unknown_length: nil
          }
        end

        def index_aggregate_member(metadata, ruby_name, member)
          modeled_name = member.name
          metadata[:schema_wire_index][modeled_name] = [ruby_name, member].freeze
          metadata[:schema_member_index][ruby_name] = [modeled_name, member].freeze
          metadata[:schema_required_members] << ruby_name if required_member?(member)
          metadata[:schema_host_label_index][modeled_name] = ruby_name if member.traits.key?('smithy.api#hostLabel')
          index_idempotency_token_member(metadata, ruby_name, member)
        end

        def index_idempotency_token_member(metadata, ruby_name, member)
          return unless member.traits.key?('smithy.api#idempotencyToken')

          metadata[:schema_idempotency_token_member] ||= ruby_name
        end

        def required_member?(member)
          member.traits.key?('smithy.api#required') &&
            !member.traits.key?('smithy.api#clientOptional')
        end

        def index_streaming_member(metadata, member)
          target = member.target
          return unless target.traits.key?('smithy.api#streaming')

          metadata[:schema_streaming_member] ||= member
          metadata[:schema_event_stream_member] ||= member if target.instance_of?(Shapes::UnionShape)
          return if target.traits.key?('smithy.api#requiresLength')

          metadata[:schema_streaming_member_unknown_length] ||= member
        end

        def freeze_aggregate_metadata(metadata)
          metadata.values_at(
            :schema_wire_index, :schema_member_index, :schema_required_members, :schema_host_label_index
          ).each(&:freeze)
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
