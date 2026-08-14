# frozen_string_literal: true

require 'base64'

module Smithy
  module Json
    # @api private
    class Parser
      include Smithy::Schema::Shapes

      def initialize(options = {})
        @json_name = options[:json_name] || false
      end

      def parse(shape, bytes, result = nil)
        return {} if bytes.empty?

        parse_shape(shape, Smithy::Json.load(bytes), result)
      end

      private

      def parse_shape(shape, value, result = nil) # rubocop:disable Metrics/CyclomaticComplexity
        case shape.target
        when BlobShape then Base64.decode64(value)
        when FloatShape then float(value)
        when ListShape then list(shape, value, result)
        when MapShape then map(shape, value, result)
        when StructureShape then structure(shape, value, result)
        when TimestampShape then timestamp(value)
        when UnionShape then union(shape, value, result)
        else value
        end
      end

      def float(value)
        case value
        when 'Infinity' then ::Float::INFINITY
        when '-Infinity' then -::Float::INFINITY
        when 'NaN' then ::Float::NAN
        else value.to_f
        end
      end

      def list(shape, values, result = nil)
        return if values.nil?

        result = [] if result.nil?
        values.each do |value|
          next if value.nil? && !sparse?(shape.target)

          result << parse_shape(shape.target.member, value)
        end
        result
      end

      def map(shape, values, result = nil)
        result = {} if result.nil?
        values.each do |key, value|
          next if value.nil? && !sparse?(shape.target)

          result[key] = parse_shape(shape.target.value, value)
        end
        result
      end

      def structure(shape, values, result = nil)
        return if values.nil?

        result = shape.target.type.new if result.nil?
        values.each do |wire_name, value|
          next if value.nil?

          member_name, member_shape = shape.target.member_by_wire_name(wire_name)
          next unless member_shape

          result[member_name] = parse_shape(member_shape, value)
        end
        result
      end

      def timestamp(value)
        case value
        when Numeric then Time.at(value)
        else
          begin
            fractional_time = Time.parse(value).to_f
            Time.at(fractional_time).utc
          rescue ArgumentError
            raise "unhandled timestamp format: #{value}"
          end
        end
      end

      def union(shape, values, result = nil) # rubocop:disable Metrics/AbcSize
        shape.target.members.each do |member_name, member_shape|
          value = values[location_name(member_shape)]
          next if value.nil?

          result = shape.target.member_type(member_name) if result.nil?
          return result.new(member_name => parse_shape(member_shape, value))
        end

        values.delete('__type')
        key, value = values.first
        shape.target.member_type(:unknown).new(unknown: { key => value })
      end

      def location_name(member)
        return member.location_name unless @json_name

        member.traits['smithy.api#jsonName'] || member.location_name
      end

      def sparse?(shape)
        shape.traits.key?('smithy.api#sparse')
      end
    end
  end
end
