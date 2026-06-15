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
        Smithy::Json.dump(build_shape(shape, data))
      end

      private

      def build_shape(shape, value) # rubocop:disable Metrics/CyclomaticComplexity
        case shape.target
        when BlobShape then blob(value)
        when FloatShape then float(value)
        when ListShape then list(shape, value)
        when MapShape then map(shape, value)
        when StructureShape then structure(shape, value)
        when TimestampShape then timestamp(shape, value)
        when UnionShape then union(shape, value)
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

      def list(shape, values)
        return if values.nil?

        values.collect do |value|
          build_shape(shape.target.member, value)
        end
      end

      def map(shape, values)
        return if values.nil?

        values.each.with_object({}) do |(key, value), data|
          data[key] = build_shape(shape.target.value, value)
        end
      end

      def structure(shape, values)
        return if values.nil?

        shape.target.members.each_with_object({}) do |(member_name, member_shape), data|
          value = values[member_name]
          data[location_name(member_shape)] = build_shape(member_shape, value) unless value.nil?
        end
      end

      def timestamp(shape, value)
        trait = 'smithy.api#timestampFormat'
        case shape.traits[trait] || shape.target.traits[trait]
        when 'date-time' then value.utc.iso8601
        when 'http-date' then value.utc.httpdate
        else
          # default to epoch-seconds
          value.to_i
        end
      end

      def union(shape, values) # rubocop:disable Metrics/AbcSize
        return if values.nil?

        data = {}
        if values.is_a?(Schema::Union)
          _name, member_shape = shape.target.member_by_type(values.class)
          data[location_name(member_shape)] = build_shape(member_shape, values.value)
        else
          key, value = values.first
          if shape.target.member?(key)
            member_shape = shape.target.member(key)
            data[location_name(member_shape)] = build_shape(member_shape, value)
          end
        end
        data
      end

      def location_name(member)
        return member.location_name unless @json_name

        member.traits['smithy.api#jsonName'] || member.location_name
      end
    end
  end
end
