# frozen_string_literal: true

require 'base64'

module Smithy
  module Client
    module Codecs
      # Codec that serializes and deserializes in CBOR format.
      # TODO:
      #   * Support handling of typed documents when it is supported
      #   * Update implementation to handle event streams
      #   * Update (de)serializing document types
      #   * Allow user to pass in their preferred type to deserialize
      #     If it fails, resort to deserializing type on the shape.
      class CBOR
        include Schema::Shapes

        def initialize(options = {}); end

        # @param [Object] data
        # @param [Shape] shape
        # @return [String] the encoded bytes in CBOR format
        def serialize(shape, data)
          return nil if shape == Prelude::Unit

          Client::CBOR.encode(format_data(shape, data))
        end

        # @param [String] bytes
        # @param [Shape] shape
        # @param [Struct] type
        # @return [Object, Hash]
        def deserialize(shape, bytes, type = nil)
          return {} if bytes.empty? || shape == Prelude::Unit

          parse_data(shape, Client::CBOR.decode(bytes), type)
        end

        private

        def sparse?(shape)
          shape.traits.include?('smithy.api#sparse')
        end

        def format_blob(value)
          (value.is_a?(String) ? value : value.read).force_encoding(Encoding::BINARY)
        end

        def format_data(shape, values)
          case shape
          when BlobShape then format_blob(values)
          when ListShape then format_list(shape, values)
          when MapShape then format_map(shape, values)
          when StructureShape then format_structure(shape, values)
          when UnionShape then format_union(shape, values)
          else values
          end
        end

        def format_list(shape, values)
          values.collect do |value|
            next if value.nil? && !sparse?(shape)

            if value.nil? && sparse?(shape)
              nil
            else
              format_data(shape.member.shape, value)
            end
          end
        end

        def format_map(shape, values)
          values.each.with_object({}) do |(key, value), data|
            next if value.nil? && !sparse?(shape)

            data[key] =
              if value.nil? && sparse?(shape)
                nil
              else
                format_data(shape.value.shape, value)
              end
          end
        end

        def format_structure(shape, values)
          values.each_pair.with_object({}) do |(key, value), data|
            if shape.member?(key) && !value.nil?
              member_shape = shape.member(key)
              data[member_shape.name] = format_data(member_shape.shape, value)
            end
          end
        end

        def format_union(shape, values)
          data = {}
          member_shape = shape.member_by_type(values.class)
          data[member_shape.name] = format_data(member_shape.shape, values).value
          data
        end

        def parse_data(shape, value, type = nil)
          return nil if value.nil?

          case shape
          when BlobShape then StringIO.new(value)
          when StructureShape then parse_structure(shape, value, type)
          when UnionShape then parse_union(shape, value, type)
          when ListShape then parse_list(shape, value, type)
          when MapShape then parse_map(shape, value, type)
          else value
          end
        end

        def parse_list(shape, values, type = nil)
          type = [] if type.nil?
          values.each do |value|
            next if value.nil? && !sparse?(shape)

            type <<
              if value.nil?
                nil
              else
                parse_data(shape.member.shape, value)
              end
          end
          type
        end

        def parse_map(shape, values, type = nil)
          type = {} if type.nil?
          values.each do |key, value|
            next if value.nil? && !sparse?(shape)

            type[key] =
              if value.nil?
                nil
              else
                parse_data(shape.value.shape, value)
              end
          end
          type
        end

        def parse_structure(shape, values, type = nil)
          type = shape.type.new if type.nil?
          values.each do |key, value|
            next unless shape.name_by_member_name?(key)

            name = shape.name_by_member_name(key)
            member_shape = shape.member(name)
            type[name] = parse_data(member_shape.shape, value)
          end
          type
        end

        def parse_union(shape, values, type = nil)
          key, value = values.flatten
          return nil if key.nil? || key == ' __type'

          if shape.name_by_member_name?(key)
            parse_union_member(shape, key, value, type)
          else
            shape.member_type(:unknown).new(name: key, value: value)
          end
        end

        def parse_union_member(shape, key, value, type = nil)
          member_name = shape.name_by_member_name(key)
          type = shape.member_type(member_name) if type.nil?
          type.new(parse_data(shape.member(member_name).shape, value))
        end
      end
    end
  end
end
