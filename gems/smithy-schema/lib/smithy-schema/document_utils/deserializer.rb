# frozen_string_literal: true

module Smithy
  module Schema
    module DocumentUtils
      # Deserializes document data into a type.
      # @api private
      class Deserializer
        include Shapes

        NUMERIC_TIMESTAMP = /^[\d.]+$/

        def initialize(options = {})
          @type_registry = options[:type_registry]
        end

        def deserialize(data, shape, result)
          deserialize_shape(shape, data, result)
        end

        private

        def deserialize_shape(shape, value, result = nil) # rubocop:disable Metrics/CyclomaticComplexity
          case shape.target
          when BlobShape then Base64.strict_decode64(value)
          when DocumentShape then document(value)
          when FloatShape then float(value)
          when ListShape then list(shape, value, result)
          when MapShape then map(shape, value, result)
          when StructureShape then structure(shape, value, result)
          when TimestampShape then timestamp(value)
          when UnionShape then union(shape, value, result)
          else value
          end
        end

        def document(values)
          return values unless values.is_a?(Hash) && values.key?('__type')

          msg = 'invalid document - document discriminator not found in type registry'
          raise ArgumentError, msg unless @type_registry.key?(values['__type'])

          deserialize_shape(@type_registry[values['__type']], values)
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

        def list(shape, values, result = nil)
          return if values.nil?

          member = shape.target.member
          result = [] if result.nil?
          values.each do |value|
            result << deserialize_shape(member, value) unless value.nil?
          end
          result
        end

        def map(shape, values, result = nil)
          return if values.nil?

          value_member = shape.target.value
          result = {} if result.nil?
          values.each do |key, value|
            result[key] = deserialize_shape(value_member, value) unless value.nil?
          end
          result
        end

        def structure(shape, values, result = nil)
          return if values.nil?

          target = shape.target
          result = target.type.new if result.nil?
          target.members.each do |member_name, member_shape|
            value = values[member_shape.name]
            result[member_name] = deserialize_shape(member_shape, value) unless value.nil?
          end
          result
        end

        def timestamp(value)
          return if value.nil?
          return Time.at(value).utc if value.is_a?(Numeric)
          return Time.at(value.to_f).utc if NUMERIC_TIMESTAMP.match?(value)

          begin
            fractional_time = Time.parse(value).to_f
            Time.at(fractional_time).utc
          rescue ArgumentError
            raise "unhandled timestamp format `#{value}'"
          end
        end

        def union(shape, values, result = nil)
          target = shape.target
          target.members.each do |member_name, member_shape|
            value = values[member_shape.name]
            next if value.nil?

            result = target.member_type(member_name) if result.nil?
            return result.new(member_name => deserialize_shape(member_shape, value))
          end

          unknown_union(target, values)
        end

        def unknown_union(target, values)
          values.each do |key, value|
            return target.member_type(:unknown).new(key, value) unless key == '__type'
          end
          target.member_type(:unknown).new(nil, nil)
        end
      end
    end
  end
end
