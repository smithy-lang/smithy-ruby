# frozen_string_literal: true

require 'base64'

module Smithy
  module Json
    # @api private
    class Builder
      include Smithy::Schema::Shapes

      def initialize(options = {})
        @extension = options[:json_name] ? Smithy::Json::Extension : Smithy::Schema::Extension
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

        member = shape.target.member
        values.collect do |value|
          build_shape(member, value)
        end
      end

      def map(shape, values)
        return if values.nil?

        value_member = shape.target.value
        values.each.with_object({}) do |(key, value), data|
          data[key] = build_shape(value_member, value)
        end
      end

      def structure(shape, values)
        return if values.nil?

        members = shape.target.members
        values.each_pair.with_object({}) do |(member_name, value), data|
          next if value.nil?

          member_shape = members[member_name]
          next unless member_shape

          data[@extension.wire_name(member_shape)] = build_shape(member_shape, value)
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

      def union(shape, values)
        return if values.nil?

        if values.is_a?(Schema::Union)
          key = values.member
          value = values.value
        else
          key, value = values.first
        end
        member_shape = shape.target.member(key)
        return {} unless member_shape

        { @extension.wire_name(member_shape) => build_shape(member_shape, value) }
      end
    end
  end
end
