# frozen_string_literal: true

module Smithy
  module JSON
    # @api private
    class Serializer
      include Smithy::Schema::Shapes

      def initialize(options = {})
        @options = options
      end

      def serialize(shape, data)
        return nil if shape == Prelude::Unit

        ref = shape.is_a?(ShapeRef) ? shape : ShapeRef.new(shape: shape)
        ::JSON.dump(shape(ref, data))
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
        values.collect do |value|
          next if value.nil? && !sparse?(ref.shape)

          value.nil? ? nil : shape(ref.shape.member, value)
        end
      end

      def map(ref, values)
        values.each.with_object({}) do |(key, value), data|
          next if value.nil? && !sparse?(ref.shape)

          data[key] = value.nil? ? nil : shape(ref.shape.value, value)
        end
      end

      def structure(ref, values)
        return nil if values.nil?

        values.each_pair.with_object({}) do |(key, value), data|
          if ref.shape.member?(key) && !value.nil?
            member_ref = ref.shape.member(key)
            member_name = member_ref.traits['smithy.api#jsonName'] || member_ref.location_name
            data[member_name] = shape(member_ref, value)
          end
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

      def union(ref, values) # rubocop:disable Metrics/AbcSize
        data = {}
        if values.is_a?(Smithy::Schema::Union)
          member_ref = ref.shape.member_by_type(values.class)
          member_name = member_ref.traits['smithy.api#jsonName'] || member_ref.location_name
          data[member_name] = shape(member_ref, values)
        else
          key, value = values.first
          if ref.shape.member?(key)
            member_ref = ref.shape.member(key)
            member_name = member_ref.traits['smithy.api#jsonName'] || member_ref.location_name
            data[member_name] = shape(member_ref, value)
          end
        end
        data
      end

      def sparse?(shape)
        shape.traits.include?('smithy.api#sparse')
      end
    end
  end
end
