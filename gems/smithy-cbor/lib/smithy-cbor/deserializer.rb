# frozen_string_literal: true

require 'base64'

module Smithy
  module CBOR
    # @api private
    class Deserializer
      include Schema::Shapes

      def initialize(options = {})
        @options = options
      end

      def deserialize(shape, bytes, target)
        return {} if bytes.empty? || shape == Prelude::Unit

        shape(shape, CBOR.decode(bytes), target)
      end

      private

      def shape(shape, value, target = nil)
        return nil if value.nil?

        case shape
        when ListShape then list(shape, value, target)
        when MapShape then map(shape, value, target)
        when StructureShape then structure(shape, value, target)
        when UnionShape then union(shape, value, target)
        else value
        end
      end

      def list(shape, values, target = nil)
        target = [] if target.nil?
        values.each do |value|
          next if value.nil? && !sparse?(shape)

          target <<
            if value.nil?
              nil
            else
              shape(shape.member.shape, value)
            end
        end
        target
      end

      def map(shape, values, target = nil)
        target = {} if target.nil?
        values.each do |key, value|
          next if value.nil? && !sparse?(shape)

          target[key] =
            if value.nil?
              nil
            else
              shape(shape.value.shape, value)
            end
        end
        target
      end

      def structure(shape, values, target = nil)
        # TODO: iterate shape members instead of values
        return Schema::EmptyStructure.new if shape == Prelude::Unit

        target = shape.type.new if target.nil?
        values.each do |key, value|
          next unless shape.name_by_member_name?(key)

          name = shape.name_by_member_name(key)
          member_shape = shape.member(name)
          target[name] = shape(member_shape.shape, value)
        end
        target
      end

      def union(shape, values, target = nil)
        # TODO: delete target instead of checking key?
        key, value = values.flatten
        return nil if key.nil? || key == ' __target'

        if shape.name_by_member_name?(key)
          member_name = shape.name_by_member_name(key)
          target = shape.member_type(member_name) if target.nil?
          target.new(shape(shape.member(member_name).shape, value))
        else
          shape.member_type(:unknown).new(key, value)
        end
      end

      def sparse?(shape)
        shape.traits.include?('smithy.api#sparse')
      end
    end
  end
end
