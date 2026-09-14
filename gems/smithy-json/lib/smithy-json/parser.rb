# frozen_string_literal: true

require 'base64'

module Smithy
  module Json
    # @api private
    class Parser
      def initialize(options = {})
        @json_name = options[:json_name] || false
      end

      def parse(shape, bytes, result = nil)
        return {} if bytes.empty?

        parse_shape(shape, Smithy::Json.load(bytes), result)
      end

      private

      def parse_shape(shape, value, result = nil) # rubocop:disable Metrics/CyclomaticComplexity
        case Schema::Extension.target_shape(shape)
        when Schema::Extension::SHAPE_BLOB then Base64.decode64(value)
        when Schema::Extension::SHAPE_FLOAT then float(value)
        when Schema::Extension::SHAPE_LIST then list(shape, value, result)
        when Schema::Extension::SHAPE_MAP then map(shape, value, result)
        when Schema::Extension::SHAPE_STRUCTURE then structure(shape, value, result)
        when Schema::Extension::SHAPE_TIMESTAMP then timestamp(value)
        when Schema::Extension::SHAPE_UNION then union(shape, value, result)
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

        member, _target_shape, sparse = Schema::Extension.list_member(shape.target)
        result = [] if result.nil?
        values.each do |value|
          next if value.nil? && !sparse

          result << parse_shape(member, value)
        end
        result
      end

      def map(shape, values, result = nil)
        value_member, _target_shape, sparse = Schema::Extension.map_value_member(shape.target)
        result = {} if result.nil?
        values.each do |key, value|
          next if value.nil? && !sparse

          result[key] = parse_shape(value_member, value)
        end
        result
      end

      def structure(shape, values, result = nil)
        return if values.nil?

        result = shape.target.type.new if result.nil?
        index = wire_index(shape.target)
        values.each do |wire_name, value|
          next if value.nil?

          entry = index[wire_name]
          next unless entry

          member_name, member_shape, _target_shape = entry
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
        index = wire_index(shape.target)
        values.each do |wire_name, value|
          next if value.nil?

          entry = index[wire_name]
          next unless entry

          member_name, member_shape, _target_shape = entry
          result = shape.target.member_type(member_name) if result.nil?
          return result.new(member_name => parse_shape(member_shape, value))
        end

        values.delete('__type')
        key, value = values.first
        unknown_member_type =
          Schema::Extension.unknown_member_type(shape.target) ||
          shape.target.member_type(:unknown)
        unknown_member_type.new(unknown: { key => value })
      end

      def wire_index(shape)
        if @json_name
          Extension.wire_index(shape)
        else
          Schema::Extension.wire_index(shape)
        end
      end
    end
  end
end
