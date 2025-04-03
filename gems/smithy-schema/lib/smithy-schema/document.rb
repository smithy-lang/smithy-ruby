# frozen_string_literal: true

require 'json'

module Smithy
  module Schema
    # TODO: need to address the following and more
    #  * documentation
    #  * some json considerations like timestamp, jsonName trait etc
    #  * handle union stuffs
    class Document
      def initialize(data, schema = nil)
        @data = format_data(data, schema) # ruby obj to make it easy to work with
        @discriminator = schema ? extract_discriminator(data, schema) : nil
      end

      attr_reader :data, :discriminator

      # if discriminator is set, add discriminator being generating
      def as_json
        JSON.generate(@data, allow_nan: true) # do we want to allow this?
      end

      def [](key)
        return unless @data.is_a?(Hash) && @data.key?(key)

        @data[key]
      end

      # expected schema here is a shape that has a type representation
      def as_typed(schema)
        # ensures that given schema has a type representation and
        error_message = 'Invalid schema or document data'
        raise ArgumentError, error_message unless valid_schema?(schema) && @data.is_a?(Hash)

        type = schema.type.new
        apply_data(schema, @data, type)
      end

      private

      def apply_data(schema, data, type = nil)
        case schema
        when Shapes::StructureShape then apply_structure(schema, data, type)
        # when Shapes::UnionShape then union(shape, value, type)
        when Shapes::ListShape then apply_list(schema, data)
        when Shapes::MapShape then apply_map(schema, data)
        else data
        end
      end

      def apply_structure(schema, data, type)
        type = schema.type.new if type.nil?
        data.each do |k, v|
          next if (name = resolve_member_name(schema, k)).nil?

          type[name] = apply_data(schema.member(name).shape, v)
        end
        type
      end

      def resolve_member_name(schema, key)
        return unless schema.name_by_member_name?(key) || schema.member?(key.to_sym)

        schema.name_by_member_name(key) || key.to_sym
      end

      def apply_list(schema, data)
        data.map do |v|
          next if v.nil?

          apply_data(schema.member.shape, v)
        end
      end

      def apply_map(schema, data)
        data.each_with_object({}) do |(k, v), h|
          h[k.to_s] =
            if v.nil?
              nil
            else
              apply_data(schema.value.shape, v)
            end
        end
      end

      def valid_schema?(schema)
        schema.is_a?(Shapes::StructureShape) && !schema.type.nil?
      end

      def discriminator?(data)
        data.is_a?(Hash) && data.key?('__type')
      end

      def format_data(data, schema)
        return if data.nil?

        case data
        when Smithy::Schema::Structure # indicates that this is a runtime shape
          if schema.nil? || !schema.is_a?(Shapes::StructureShape)
            raise ArgumentError, 'Unable to convert as document with given schema'
          end

          extract_data(schema, data)
        else
          data
        end
      end

      # handle timestamp, union, number?
      def extract_data(schema, data)
        return nil if data.nil?

        case schema
        when Shapes::StructureShape then extract_structure(schema, data)
        when Shapes::ListShape      then extract_list(schema, data)
        when Shapes::MapShape       then extract_map(schema, data)
        when Shapes::BlobShape      then extract_blob(data)
        else data
        end
      end

      def extract_structure(schema, data)
        data.to_h.each_with_object({}) do |(k, v), o|
          next unless schema.member?(k)

          member_shape = schema.member(k)
          o[member_shape.name] = extract_data(member_shape.shape, v)
        end
      end

      def extract_list(schema, data)
        data.collect { |value| extract_data(schema.member.shape, value) }
      end

      def extract_map(schema, data)
        data.each.with_object({}) do |(k, v), h|
          h[k.to_s] = extract_data(schema.value.shape, v)
        end
      end

      def extract_blob(data)
        Base64.strict_encode64(data.is_a?(String) ? data : data.read)
      end

      def extract_discriminator(data, schema)
        return if data.nil?

        if discriminator?(data)
          data['__type']
        elsif schema
          raise "Expected a structure schema, given #{schema} instead" unless schema.is_a?(Shapes::Shape)

          schema.id
        end
      end
    end
  end
end
