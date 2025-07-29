# frozen_string_literal: true

require 'base64'

module Smithy
  module Json
    # @api private
    class Builder
      include Smithy::Schema::Shapes

      def initialize(options = {})
        @json_name = options[:json_name] || false
      end

      def build(shape, data)
        ref = shape.is_a?(ShapeRef) ? shape : ShapeRef.new(shape: shape)
        Smithy::Json.dump(shape(ref, data))
      end

      private

      def shape(ref, value) # rubocop:disable Metrics/CyclomaticComplexity
        case ref.shape
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
        Base64.strict_encode64(value.respond_to?(:read) ? value.read : value)
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

        shape = ref.shape
        values.collect do |value|
          shape(shape.member, value)
        end
      end

      def map(ref, values)
        return if values.nil?

        shape = ref.shape
        values.each.with_object({}) do |(key, value), data|
          data[key] = shape(shape.value, value)
        end
      end

      def structure(ref, values)
        return if values.nil?

        ref.shape.members.each_with_object({}) do |(member_name, member_ref), data|
          value = values[member_name]
          data[location_name(member_ref)] = shape(member_ref, value) unless value.nil?
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
        return if values.nil?

        data = {}
        if values.is_a?(Schema::Union)
          _name, member_ref = ref.shape.member_by_type(values.class)
          data[location_name(member_ref)] = shape(member_ref, values.value)
        else
          key, value = values.first
          if ref.shape.member?(key)
            member_ref = ref.shape.member(key)
            data[location_name(member_ref)] = shape(member_ref, value)
          end
        end
        data
      end

      def location_name(ref)
        return ref.member_name unless @json_name

        ref.traits['smithy.api#jsonName'] || ref.member_name
      end
    end
  end
end
