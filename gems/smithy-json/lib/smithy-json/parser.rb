# frozen_string_literal: true

require 'base64'

module Smithy
  module Json
    # @api private
    class Parser
      def initialize(options = {})
        @json_name = options[:json_name] || false
        @extension = @json_name ? Extension : Schema::Extension
      end

      def parse(shape, bytes, result = nil)
        return {} if bytes.empty?

        parse_shape(shape, Smithy::Json.load(bytes), result)
      end

      private

      def parse_shape(shape, value, result = nil) # rubocop:disable Metrics/CyclomaticComplexity
        target = shape.target
        case target
        when Schema::Shapes::BlobShape then Base64.decode64(value)
        when Schema::Shapes::FloatShape then float(value)
        when Schema::Shapes::ListShape then list(shape, value, result)
        when Schema::Shapes::MapShape then map(shape, value, result)
        when Schema::Shapes::StructureShape then structure(shape, value, result)
        when Schema::Shapes::TimestampShape then timestamp(value)
        when Schema::Shapes::UnionShape then union(shape, value, result)
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

        target = shape.target
        member = target.member
        sparse = target.traits.key?('smithy.api#sparse')
        result = [] if result.nil?
        values.each do |value|
          next if value.nil? && !sparse

          result << parse_shape(member, value)
        end
        result
      end

      def map(shape, values, result = nil)
        target = shape.target
        value_member = target.value
        sparse = target.traits.key?('smithy.api#sparse')
        result = {} if result.nil?
        values.each do |key, value|
          next if value.nil? && !sparse

          result[key] = parse_shape(value_member, value)
        end
        result
      end

      def structure(shape, values, result = nil)
        return if values.nil?

        target = shape.target
        result = target.type.new if result.nil?
        index = @extension.wire_index(target)
        values.each do |wire_name, value|
          next if value.nil?

          entry = index[wire_name]
          next unless entry

          member_name, member_shape = entry
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

      def union(shape, values, result = nil)
        target = shape.target
        index = @extension.wire_index(target)
        values.each do |wire_name, value|
          next if value.nil?

          entry = index[wire_name]
          next unless entry

          member_name, member_shape = entry
          result = target.member_type(member_name) if result.nil?
          return result.new(member_name => parse_shape(member_shape, value))
        end

        values.delete('__type')
        key, value = values.first
        target.member_type(:unknown).new(unknown: { key => value })
      end
    end
  end
end
