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

      def deserialize(shape, bytes, type)
        return {} if bytes.empty? || shape == Prelude::Unit

        shape(shape, CBOR.decode(bytes), type)
      end

      private

      def shape(shape, value, type = nil)
        return nil if value.nil?

        case shape
        when StructureShape then structure(shape, value, type)
        when UnionShape then union(shape, value, type)
        when ListShape then list(shape, value, type)
        when MapShape then map(shape, value, type)
        else value
        end
      end

      def list(shape, values, type = nil)
        type = [] if type.nil?
        values.each do |value|
          next if value.nil? && !sparse?(shape)

          type <<
            if value.nil?
              nil
            else
              shape(shape.member.shape, value)
            end
        end
        type
      end

      def map(shape, values, type = nil)
        type = {} if type.nil?
        values.each do |key, value|
          next if value.nil? && !sparse?(shape)

          type[key] =
            if value.nil?
              nil
            else
              shape(shape.value.shape, value)
            end
        end
        type
      end

      def structure(shape, values, type = nil)
        return Schema::EmptyStructure.new if shape == Prelude::Unit

        type = shape.type.new if type.nil?
        values.each do |key, value|
          next unless shape.name_by_member_name?(key)

          name = shape.name_by_member_name(key)
          member_shape = shape.member(name)
          type[name] = shape(member_shape.shape, value)
        end
        type
      end

      def union(shape, values, type = nil)
        key, value = values.flatten
        return nil if key.nil? || key == ' __type'

        if shape.name_by_member_name?(key)
          member_name = shape.name_by_member_name(key)
          type = shape.member_type(member_name) if type.nil?
          type.new(shape(shape.member(member_name).shape, value))
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
