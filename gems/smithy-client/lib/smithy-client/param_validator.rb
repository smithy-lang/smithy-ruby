# frozen_string_literal: true

require 'bigdecimal'

module Smithy
  module Client
    # @api private
    class ParamValidator
      include Smithy::Schema::Shapes

      EXPECTED_GOT = 'expected %s to be %s, got class %s instead.'

      def initialize(shape, validate_required: true)
        @shape = shape
        @validate_required = validate_required
      end

      # @param [Hash] params
      # @param [String] context
      # @return [void]
      # @raise [ArgumentError] if the params are invalid
      def validate!(params, context: 'params')
        errors = []
        structure(@shape, params, errors, context)
        raise ArgumentError, error_messages(errors) unless errors.empty?
      end

      private

      # rubocop:disable-next Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      def validate_shape(shape, value, errors, context)
        case Schema::Extension.target_shape(shape)
        when Schema::Extension::SHAPE_STRUCTURE then structure(shape, value, errors, context)
        when Schema::Extension::SHAPE_LIST then list(shape, value, errors, context)
        when Schema::Extension::SHAPE_MAP then map(shape, value, errors, context)
        when Schema::Extension::SHAPE_DOCUMENT then document(shape, value, errors, context)
        when Schema::Extension::SHAPE_UNION then union(shape, value, errors, context)
        when Schema::Extension::SHAPE_STRING, Schema::Extension::SHAPE_ENUM
          errors << expected_got(context, 'a String', value) unless value.is_a?(String)
        when Schema::Extension::SHAPE_INTEGER, Schema::Extension::SHAPE_INT_ENUM
          errors << expected_got(context, 'an Integer', value) unless value.is_a?(Integer)
        when Schema::Extension::SHAPE_BIG_DECIMAL
          errors << expected_got(context, 'a BigDecimal', value) unless value.is_a?(BigDecimal)
        when Schema::Extension::SHAPE_FLOAT
          errors << expected_got(context, 'a Float', value) unless value.is_a?(Float)
        when Schema::Extension::SHAPE_TIMESTAMP
          errors << expected_got(context, 'a Time object', value) unless value.is_a?(Time)
        when Schema::Extension::SHAPE_BOOLEAN
          errors << expected_got(context, 'true or false', value) unless [true, false].include?(value)
        when Schema::Extension::SHAPE_BLOB
          blob(shape, value, errors, context)
        end
      end

      def blob(shape, value, errors, context)
        return if value.is_a?(String)

        streaming = streaming_input?(shape)
        return if io_like?(value, require_size: !streaming)

        expected =
          if streaming
            'a String or IO like object that supports read and rewind'
          else
            'a String or IO like object that supports read, rewind, and size'
          end
        errors << expected_got(context, expected, value)
      end

      def document(shape, value, errors, context)
        document_types = [Hash, Array, Numeric, String, TrueClass, FalseClass, NilClass]
        unless document_types.any? { |t| value.is_a?(t) }
          errors << expected_got(context, "one of #{document_types.join(', ')}", value)
        end

        case value
        when Hash
          value.each do |k, v|
            document(shape, v, errors, context + "[#{k}]")
          end
        when Array
          value.each do |v|
            document(shape, v, errors, context)
          end
        end
      end

      def list(shape, values, errors, context)
        unless values.is_a?(Array)
          errors << expected_got(context, 'an Array', values)
          return
        end

        member = shape.target.member
        values.each.with_index do |value, index|
          next unless value

          validate_shape(member, value, errors, context + "[#{index}]")
        end
      end

      def map(shape, values, errors, context)
        unless values.is_a?(Hash)
          errors << expected_got(context, 'a Hash', values)
          return
        end

        key_member = shape.target.key
        value_member = shape.target.value
        values.each do |key, value|
          validate_shape(key_member, key, errors, "#{context} #{key.inspect} key")
          next unless value

          validate_shape(value_member, value, errors, context + "[#{key.inspect}]")
        end
      end

      def member(shape, name, value, errors, context)
        if shape.target.member?(name)
          member_shape = shape.target.member(name)
          validate_shape(member_shape, value, errors, context + "[#{name.inspect}]")
        else
          errors << "unexpected value at #{context}[#{name.inspect}]"
        end
      end

      def structure(shape, values, errors, context)
        return if shape.target == Prelude::Unit
        return unless valid_structure?(shape, values, errors, context)

        validate_required_members(shape, values, errors, context) if @validate_required
        values.each_pair do |name, value|
          next if value.nil?

          member(shape, name, value, errors, context)
        end
      end

      def valid_structure?(shape, values, errors, context)
        if !values.is_a?(Hash) && !values.is_a?(shape.target.type)
          errors << expected_got(context, 'a Hash', values)
          return false
        end

        true
      end

      def union(shape, values, errors, context)
        return unless valid_union?(shape, values, errors, context)

        if values.is_a?(Schema::Union)
          _name, member_shape = shape.target.member_by_type(values.class)
          validate_shape(member_shape, values.value, errors, context)
        elsif values.is_a?(Hash)
          values.each_pair do |name, value|
            next if value.nil?

            member(shape, name, value, errors, context)
          end
        end
      end

      def valid_union?(shape, values, errors, context)
        return true if values.is_a?(shape.target.type)

        unless values.is_a?(Hash)
          errors << expected_got(context, 'a Hash', values)
          return false
        end
        return true if values.size <= 1

        union_members = shape.target.members.keys.join(', ')
        error = "expected #{context} to be a Hash with one of #{union_members}, got #{values.size} keys instead."
        errors << error
        false
      end

      def validate_required_members(shape, values, errors, context)
        Schema::Extension.required_members(shape.target).each do |name|
          if values[name].nil?
            param = "#{context}[#{name.inspect}]"
            errors << "missing required parameter #{param}"
          end
        end
      end

      def streaming_input?(shape)
        Schema::Extension.streaming?(shape.target)
      end

      def io_like?(value, require_size: false)
        value.respond_to?(:read) && value.respond_to?(:rewind) &&
          (!require_size || value.respond_to?(:size))
      end

      def error_messages(errors)
        if errors.size == 1
          errors.first
        else
          prefix = "\n  - "
          "parameter validator found #{errors.size} errors:" +
            prefix + errors.join(prefix)
        end
      end

      def expected_got(context, expected, got)
        format(EXPECTED_GOT, context, expected, got.class.name)
      end
    end
  end
end
