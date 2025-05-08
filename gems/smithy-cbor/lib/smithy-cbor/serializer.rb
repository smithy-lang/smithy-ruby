# frozen_string_literal: true

require 'base64'

module Smithy
  module CBOR
    # @api private
    class Serializer
      include Schema::Shapes

      def initialize(options = {})
        @options = options
      end

      def serialize(shape, data)
        ref = shape.is_a?(ShapeRef) ? shape : ShapeRef.new(shape: shape)
        return if ref.shape == Prelude::Unit

        @top_level = ref
        CBOR.encode(shape(ref, data))
      end

      private

      def shape(ref, value)
        case ref.shape
        when BlobShape then blob(value)
        when ListShape then list(ref, value)
        when MapShape then map(ref, value)
        when StructureShape then structure(ref, value)
        when UnionShape then union(ref, value)
        else value
        end
      end

      def blob(value)
        value.is_a?(String) ? value : value.read
      end

      def list(ref, values)
        shape = ref.shape
        values.collect do |value|
          next if value.nil? && !sparse?(shape.traits)

          value.nil? ? nil : shape(shape.member, value)
        end
      end

      def map(ref, values)
        shape = ref.shape
        values.each.with_object({}) do |(key, value), data|
          next if value.nil? && !sparse?(shape.traits)

          data[key] = value.nil? ? nil : shape(shape.value, value)
        end
      end

      def structure(ref, values)
        ref.shape.members.each_with_object({}) do |(member_name, member_ref), data|
          value = values[member_name]
          value ||= default(member_ref) if default?(ref, member_ref.traits)
          next if value.nil?

          data[member_ref.member_name] = shape(member_ref, value)
        end
      end

      def union(ref, values) # rubocop:disable Metrics/AbcSize
        data = {}
        if values.is_a?(Schema::Union)
          member_ref = ref.shape.member_by_type(values.class)
          data[member_ref.member_name] = shape(member_ref, values).value
        else
          key, value = values.first
          if ref.shape.member?(key)
            member_ref = ref.shape.member(key)
            data[member_ref.member_name] = shape(member_ref, value)
          end
        end
        data
      end

      def sparse?(traits)
        traits.include?('smithy.api#sparse')
      end

      def default?(ref, traits)
        return false if ref == @top_level

        traits.include?('smithy.api#default') && !traits.include?('smithy.api#clientOptional')
      end

      def default(ref)
        trait = ref.traits['smithy.api#default']
        case ref.shape
        when BlobShape then Base64.strict_decode64(trait)
        when TimestampShape
          case trait
          when String then Time.parse(trait)
          when Integer then Time.at(trait)
          else raise ArgumentError, "Invalid default value for Timestamp: #{trait.inspect}"
          end
        else trait
        end
      end
    end
  end
end
