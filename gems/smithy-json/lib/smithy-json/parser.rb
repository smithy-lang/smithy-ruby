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

      def parse(shape, bytes, target = nil)
        return {} if bytes.empty?

        ref = shape.is_a?(ShapeRef) ? shape : ShapeRef.new(shape: shape)
        shape(ref, Smithy::Json.load(bytes), target)
      end

      private

      def shape(ref, value, target = nil) # rubocop:disable Metrics/CyclomaticComplexity
        case ref.shape
        when BlobShape then Base64.decode64(value)
        when FloatShape then float(value)
        when ListShape then list(ref, value, target)
        when MapShape then map(ref, value, target)
        when StructureShape then structure(ref, value, target)
        when TimestampShape then timestamp(value)
        when UnionShape then union(ref, value, target)
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

      def list(ref, values, target = nil)
        return if values.nil?

        target = [] if target.nil?
        values.each do |value|
          next if value.nil? && !sparse?(ref.shape)

          target << shape(ref.shape.member, value)
        end
        target
      end

      def map(ref, values, target = nil)
        target = {} if target.nil?
        values.each do |key, value|
          next if value.nil? && !sparse?(ref.shape)

          target[key] = shape(ref.shape.value, value)
        end
        target
      end

      def structure(ref, values, target = nil)
        return if values.nil?

        target = ref.shape.type.new if target.nil?
        ref.shape.members.each do |member_name, member_ref|
          value = values[location_name(member_ref)]
          target[member_name] = shape(member_ref, value) unless value.nil?
        end
        target
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

      def union(ref, values, target = nil) # rubocop:disable Metrics/AbcSize
        ref.shape.members.each do |member_name, member_ref|
          value = values[location_name(member_ref)]
          next if value.nil?

          target = ref.shape.member_type(member_name) if target.nil?
          return target.new(member_name => shape(member_ref, value))
        end

        values.delete('__type')
        key, value = values.first
        ref.shape.member_type(:unknown).new(unknown: { key => value })
      end

      def location_name(ref)
        return ref.location_name unless @json_name

        ref.traits['smithy.api#jsonName'] || ref.location_name
      end

      def sparse?(shape)
        shape.traits.key?('smithy.api#sparse')
      end
    end
  end
end
