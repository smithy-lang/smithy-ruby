# frozen_string_literal: true

module Smithy
  module JSON
    # @api private
    class Deserializer
      include Smithy::Schema::Shapes

      def initialize(options = {})
        @options = options
      end

      def deserialize(shape, bytes, target)
        return {} if bytes.empty?

        ref = shape.is_a?(ShapeRef) ? shape : ShapeRef.new(shape: shape)
        shape(ref, Smithy::JSON.load(bytes), target)
      end

      private

      def shape(ref, value, target = nil) # rubocop:disable Metrics/CyclomaticComplexity
        case ref.shape
        when BlobShape then Base64.decode64(value)
        when BooleanShape then value.to_s == 'true'
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
        when nil then nil
        else value.to_f
        end
      end

      def list(ref, values, target = nil)
        target = [] if target.nil?
        values.each do |value|
          next if value.nil? && !sparse?(ref.shape)

          target << (value.nil? ? nil : shape(ref.shape.member, value))
        end
        target
      end

      def map(ref, values, target = nil)
        target = {} if target.nil?
        values.each do |key, value|
          next if value.nil? && !sparse?(ref.shape)

          target[key] = value.nil? ? nil : shape(ref.shape.value, value)
        end
        target
      end

      def structure(ref, values, target = nil) # rubocop:disable Metrics/AbcSize
        return Smithy::Schema::EmptyStructure.new if ref.shape == Prelude::Unit

        target = ref.shape.type.new if target.nil?
        ref.shape.members.each do |member_name, member_ref|
          key = member_ref.traits['smithy.api#jsonName'] || member_ref.member_name
          next unless values.key?(key)

          target[member_name] = shape(member_ref, values[key])
        end
        target
      end

      def timestamp(value)
        case value
        when nil then nil
        when Numeric then Time.at(value)
        when /^[\d.]+$/ then Time.at(value.to_f)
        else
          begin
            fractional_time = Time.parse(value).to_f
            Time.at(fractional_time).utc
          rescue ArgumentError
            raise "unhandled timestamp format `#{value}'"
          end
        end
      end

      def union(ref, values, target = nil) # rubocop:disable Metrics/AbcSize
        sanitize_union!(ref, values)

        key, value = values.first
        return nil if key.nil?

        ref.shape.members.each do |member_name, member_ref|
          name = member_ref.traits['smithy.api#jsonName'] || member_ref.member_name
          next unless values.key?(name)

          target = ref.shape.member_type(member_name) if target.nil?
          return target.new(shape(member_ref, values[name]))
        end
        ref.shape.member_type(:unknown).new(key, value)
      end

      def sanitize_union!(ref, values) # rubocop:disable Metrics/CyclomaticComplexity
        return unless values.size > 1

        # __type should be ignored unless it's a jsonName for a member
        type_as_name = false
        ref.shape.members.each_value do |member_ref|
          name = member_ref.traits['smithy.api#jsonName'] || member_ref.member_name
          type_as_name = true if name == '__type'
        end

        values.delete('__type') if values.key?('__type') && !type_as_name
        raise ArgumentError, "union value includes more than one key, received: #{values.keys}" if values.size > 1
      end

      def sparse?(shape)
        shape.traits.include?('smithy.api#sparse')
      end
    end
  end
end
