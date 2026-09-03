# frozen_string_literal: true

module Smithy
  module Schema
    # Lookup helpers for protocol-agnostic serde using modeled member names.
    #
    # Raw Smithy trait data remains on +shape.traits+ and +member.traits+ with
    # string keys. This module only provides generic modeled-name lookup
    # helpers and memoizes shape-level indexes in metadata when that
    # meaningfully avoids rebuilding them.
    #
    # - +shape[:wire_index]+ caches the modeled wire-name lookup index for a shape
    # - +shape[:member_index]+ caches the modeled build lookup index for a shape
    # - +shape[:host_label_index]+ caches the modeled host-label lookup index for a shape
    # - +shape[:idempotency_token_member]+ caches the modeled idempotency-token
    #   member for a shape, or +false+ when absent
    # - +operation[:request_compression_encodings]+ caches the modeled request
    #   compression encodings for an operation, or +false+ when absent
    # - +operation[:error_index]+ caches the modeled error-name lookup index for an operation
    # - +operation[:endpoint_host_prefix]+ caches the modeled endpoint host prefix,
    #   or +false+ when the operation does not model one
    # - +shape[:http_payload_member]+ caches the modeled HTTP payload member
    #   derived from member traits, or +false+ when absent
    # - +shape[:default_members]+ caches modeled members with Smithy @default
    #   that are not Smithy @clientOptional
    # - +shape[:required_members]+ caches modeled members with Smithy @required
    #   that are not Smithy @clientOptional
    # - +shape[:streaming_member]+ caches the modeled member that targets a
    #   streaming shape, or +false+ when absent
    # - +shape[:event_stream_member]+ caches the modeled member that targets a
    #   streaming union, or +false+ when the shape does not model an event stream
    # - +shape[:streaming_member_without_length]+ caches the modeled member that
    #   targets a streaming shape without Smithy @requiresLength, or +false+
    #   when absent
    # - +shape[:xml_flattened]+ caches whether the shape has the Smithy
    #   @xmlFlattened trait
    # - +shape[:media_type]+ caches the modeled Smithy @mediaType trait value,
    #   or +false+ when absent
    # - +operation[:unsigned_payload]+ caches whether the operation has the
    #   AWS @unsignedPayload trait
    # - +shape[:timestamp_format]+ caches the resolved explicit timestamp format
    #   for a member or target shape, or +:default+ when the model does not
    #   override the protocol default
    # @api private
    module Extension
      class << self
        # Returns the modeled member lookup index cached on the shape as
        # +shape[:wire_index]+.
        #
        # Return shape:
        # - +Hash{String => [Symbol, MemberShape]}+
        def wire_index(shape)
          shape[:wire_index] ||= build_wire_index(shape)
        end

        # Returns the modeled build lookup index cached on the shape as
        # +shape[:member_index]+.
        #
        # Return shape:
        # - +Hash{Symbol => [String, MemberShape]}+
        def member_index(shape)
          shape[:member_index] ||= build_member_index(shape)
        end

        # Returns the modeled host-label lookup index cached on the shape as
        # +shape[:host_label_index]+.
        #
        # Return shape:
        # - +Hash{String => Symbol}+
        def host_label_index(shape)
          shape[:host_label_index] ||= build_host_label_index(shape)
        end

        # Returns the modeled error lookup index cached on the operation as
        # +operation[:error_index]+.
        #
        # Return shape:
        # - +Hash{String => Shape}+
        def error_index(operation)
          operation[:error_index] ||= build_error_index(operation)
        end

        # Returns the modeled member name for schema lookup.
        #
        # Return shape:
        # - modeled wire name as +String+
        # - +nil+ when absent
        def wire_name(member)
          member.name
        end

        # Returns the modeled idempotency-token member cached on the shape as
        # +shape[:idempotency_token_member]+.
        #
        # Return shape:
        # - ruby member name as +Symbol+
        # - +nil+ when absent
        def idempotency_token_member(shape)
          value = shape[:idempotency_token_member]
          return value if value
          return nil if value == false

          value = build_idempotency_token_member(shape)
          shape[:idempotency_token_member] = value || false
          value
        end

        # Returns the modeled HTTP payload member when present on the shape.
        #
        # Return shape:
        # - +MemberShape+
        # - +nil+ when absent
        def http_payload_member(shape)
          value = shape[:http_payload_member]
          return value if value
          return nil if value == false

          value = shape.members.each_value.find do |member|
            member.traits.key?('smithy.api#httpPayload')
          end

          shape[:http_payload_member] = value || false
          value
        end

        # Returns the modeled members eligible for client-side default
        # application on nested structures.
        #
        # Return shape:
        # - +Array<[Symbol, MemberShape]>+
        def default_members(shape)
          shape[:default_members] ||= build_default_members(shape)
        end

        # Returns the modeled member names eligible for required-member
        # validation.
        #
        # Return shape:
        # - +Array<Symbol>+
        def required_members(shape)
          shape[:required_members] ||= build_required_members(shape)
        end

        # Returns the cached member that targets a streaming shape, or +nil+
        # when the shape does not model a streaming member.
        #
        # Return shape:
        # - +MemberShape+
        # - +nil+ when absent
        def streaming_member(shape)
          value = shape[:streaming_member]
          return value if value
          return nil if value == false

          value = shape.members.each_value.find do |member|
            member.target.traits.key?('smithy.api#streaming')
          end

          shape[:streaming_member] = value || false
          value
        end

        # Returns the cached member that targets a streaming union, or +nil+
        # when the shape does not model an event stream member.
        #
        # Return shape:
        # - +MemberShape+
        # - +nil+ when absent
        def event_stream_member(shape)
          value = shape[:event_stream_member]
          return value if value
          return nil if value == false

          value = shape.members.each_value.find do |member|
            streaming_union_member?(member)
          end

          shape[:event_stream_member] = value || false
          value
        end

        # Returns whether the shape models an event stream member.
        #
        # Return shape:
        # - +true+ or +false+
        def event_streaming?(shape)
          !event_stream_member(shape).nil?
        end

        # Returns the cached member that targets a streaming shape without the
        # Smithy @requiresLength trait, or +nil+ when absent.
        #
        # Return shape:
        # - +MemberShape+
        # - +nil+ when absent
        def streaming_member_without_length(shape)
          value = shape[:streaming_member_without_length]
          return value if value
          return nil if value == false

          value = shape.members.each_value.find do |member|
            target = member.target
            target.traits.key?('smithy.api#streaming') && !requires_length?(target)
          end

          shape[:streaming_member_without_length] = value || false
          value
        end

        # Returns whether the shape has the Smithy @xmlFlattened trait.
        #
        # Return shape:
        # - +true+ or +false+
        def xml_flattened?(shape)
          value = shape[:xml_flattened]
          return value unless value.nil?

          shape[:xml_flattened] = shape.traits.key?('smithy.api#xmlFlattened')
        end

        # Returns the modeled Smithy @mediaType trait value when present.
        #
        # Return shape:
        # - media type as +String+
        # - +nil+ when absent
        def media_type(shape)
          value = shape[:media_type]
          return value if value
          return nil if value == false

          value = shape.traits['smithy.api#mediaType']
          shape[:media_type] = value || false
          value
        end

        # Returns the modeled request-compression encodings when present on the
        # operation.
        #
        # Return shape:
        # - +Array<String>+
        # - +nil+ when absent
        def request_compression_encodings(operation)
          value = operation[:request_compression_encodings]
          return value if value
          return nil if value == false

          value = operation.traits.dig('smithy.api#requestCompression', 'encodings')
          operation[:request_compression_encodings] = value || false
          value
        end

        # Returns the modeled endpoint host prefix when present on the operation.
        #
        # Return shape:
        # - host prefix as +String+
        # - +nil+ when absent
        def endpoint_host_prefix(operation)
          value = operation[:endpoint_host_prefix]
          return value if value
          return nil if value == false

          value = operation.traits.dig('smithy.api#endpoint', 'hostPrefix')
          operation[:endpoint_host_prefix] = value || false
          value
        end

        # Returns whether the operation has the Smithy
        # @httpChecksumRequired trait.
        #
        # Return shape:
        # - +true+ or +false+
        def checksum_required?(operation)
          operation.traits.key?('smithy.api#httpChecksumRequired')
        end

        # TODO: Revisit after trait is finalized.
        # Returns whether the operation has the Smithy @longPoll trait.
        #
        # Return shape:
        # - +true+ or +false+
        def long_polling?(operation)
          operation.traits.key?('smithy.api#longPoll')
        end

        # Returns whether the operation has the AWS @unsignedPayload trait.
        #
        # Return shape:
        # - +true+ or +false+
        def unsigned_payload?(operation)
          value = operation[:unsigned_payload]
          return value unless value.nil?

          operation[:unsigned_payload] =
            operation.traits.key?('aws.auth#unsignedPayload')
        end

        # Returns the modeled Smithy @default trait payload when present.
        #
        # Return shape:
        # - raw trait payload
        # - +nil+ when absent
        def default_trait(shape)
          shape.traits['smithy.api#default']
        end

        # Returns whether the shape has the Smithy @sparse trait.
        #
        # Return shape:
        # - +true+ or +false+
        def sparse?(shape)
          shape.traits.key?('smithy.api#sparse')
        end

        # Returns whether the shape has the Smithy @requiresLength trait.
        #
        # Return shape:
        # - +true+ or +false+
        def requires_length?(shape)
          shape.traits.key?('smithy.api#requiresLength')
        end

        # Returns whether the shape has the Smithy @streaming trait.
        #
        # Return shape:
        # - +true+ or +false+
        def streaming?(shape)
          shape.traits.key?('smithy.api#streaming')
        end

        # Returns the resolved explicit timestamp format for a member/target
        # shape, or +:default+ when the model does not override the protocol
        # default.
        #
        # Return shape:
        # - explicit timestamp format as +String+
        # - +:default+ when the protocol default should be used
        def timestamp_format(shape)
          shape[:timestamp_format] ||=
            shape.traits['smithy.api#timestampFormat'] ||
            shape.target.traits['smithy.api#timestampFormat'] ||
            :default
        end

        private

        def build_wire_index(shape)
          index = {}
          shape.members.each do |name, member|
            wire_name = wire_name(member)
            next unless wire_name

            index[wire_name] = [name, member]
          end
          index.freeze
        end

        def build_member_index(shape)
          index = {}
          shape.members.each do |name, member|
            wire_name = wire_name(member)
            next unless wire_name

            index[name] = [wire_name, member]
          end
          index.freeze
        end

        def build_host_label_index(shape)
          index = {}
          shape.members.each do |member_name, member_shape|
            next unless member_shape.traits.key?('smithy.api#hostLabel')
            next unless member_shape.name

            index[member_shape.name] = member_name
          end
          index.freeze
        end

        def build_default_members(shape)
          members = []
          shape.members.each do |member_name, member_shape|
            traits = member_shape.traits
            next unless traits.key?('smithy.api#default')
            next if traits.key?('smithy.api#clientOptional')

            members << [member_name, member_shape]
          end
          members.freeze
        end

        def build_required_members(shape)
          members = []
          shape.members.each do |member_name, member_shape|
            traits = member_shape.traits
            next unless traits.key?('smithy.api#required')
            next if traits.key?('smithy.api#clientOptional')

            members << member_name
          end
          members.freeze
        end

        def build_idempotency_token_member(shape)
          shape.members.each do |member_name, member_shape|
            next unless member_shape.traits.key?('smithy.api#idempotencyToken')

            return member_name
          end

          nil
        end

        def build_error_index(operation)
          index = {}
          operation.errors.each do |error_shape|
            next unless error_shape.name

            index[error_shape.name] = error_shape
          end
          index.freeze
        end

        def streaming_union_member?(member)
          return false unless member

          target = member.target
          target.is_a?(Shapes::UnionShape) &&
            target.traits.key?('smithy.api#streaming')
        end
      end
    end
  end
end
