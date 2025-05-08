# frozen_string_literal: true

require 'base64'

module Smithy
  module JSON
    # @api private
    class Serializer
      include Smithy::Schema::Shapes

      def initialize(options = {})
        @json_name = options[:json_name] || false
      end

      def serialize(shape, data)
        ref = shape.is_a?(ShapeRef) ? shape : ShapeRef.new(shape: shape)
        @top_level = ref
        Smithy::JSON.dump(shape(ref, data))
      end

      private

      def shape(ref, value) # rubocop:disable Metrics/CyclomaticComplexity
        shape = ref.shape
        case shape
        when BlobShape then blob(value)
        when FloatShape then float(value)
        when ListShape then list(ref, value)
        when MapShape then map(ref, value)
        when StructureShape then structure(ref, value)
        when TimestampShape then timestamp(ref, value)
        when UnionShape then union(ref, value)
        else value
        end
      end

      def blob(value)
        Base64.strict_encode64(value.is_a?(String) ? value : value.read)
      end

      def float(value)
        if value == ::Float::INFINITY
          'Infinity'
        elsif value == -::Float::INFINITY
          '-Infinity'
        elsif value.nan?
          'NaN'
        else
          value
        end
      end

      def list(ref, values)
        return if values.nil?

        values.collect do |value|
          next if value.nil? && !sparse?(ref.shape)

          shape(ref.shape.member, value)
        end
      end

      def map(ref, values)
        values.each.with_object({}) do |(key, value), data|
          next if value.nil? && !sparse?(ref.shape)

          data[key] = shape(ref.shape.value, value)
        end
      end

      def structure(ref, values)
        return if values.nil?

        ref.shape.members.each_with_object({}) do |(member_name, member_ref), data|
          value = values[member_name]
          value ||= default(member_ref) if default?(ref, member_ref.traits)
          next if value.nil?

          data[location_name(member_ref)] = shape(member_ref, value)
        end
      end

      def timestamp(ref, value)
        trait = 'smithy.api#timestampFormat'
        case ref.traits[trait] || ref.shape.traits[trait]
        when 'date-time' then value.utc.iso8601
        when 'http-date' then value.utc.httpdate
        else
          # default to epoch-seconds
          value.to_i
        end
      end

      def union(ref, values)
        data = {}
        if values.is_a?(Smithy::Schema::Union)
          member_ref = ref.shape.member_by_type(values.class)
          data[location_name(member_ref)] = shape(member_ref, values)
        else
          key, value = values.first
          if ref.shape.member?(key)
            member_ref = ref.shape.member(key)
            data[location_name(member_ref)] = shape(member_ref, value)
          end
        end
        data
      end

      def sparse?(shape)
        shape.traits.include?('smithy.api#sparse')
      end

      def location_name(ref)
        return ref.member_name unless @json_name

        ref.traits['smithy.api#jsonName'] || ref.member_name
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
