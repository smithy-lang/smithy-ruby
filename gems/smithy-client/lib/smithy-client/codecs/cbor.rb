# frozen_string_literal: true

require 'base64'

module Smithy
  module Client
    module Codecs
      # Codec that serializes and deserializes in CBOR format.
      # TODO:
      #   * Support (de)serializing union shapes once union is supported
      #   * Support handling of typed documents when it is supported
      #   * Update implementation to handle event streams
      #   * Handle query_compatible trait
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

          parse_data(Client::CBOR.decode(bytes), shape, type)
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
              member = shape.member(key)
              data[member.name] = format_data(member.shape, value)
            end
          end
        end

        def format_union(shape, values)
          member_shape = shape.member_by_type(values.class)
          format_data(member_shape.shape, values).value
        end

        def parse_data(value, shape, type = nil)
          return nil if value.nil?

          case shape
          when StructureShape then parse_structure(value, shape, type)
          when ListShape then parse_list(value, shape, type)
          when MapShape then parse_map(value, shape, type)
          else value
          end
        end

        def parse_list(values, shape, type = nil)
          type = [] if type.nil?
          values.each do |value|
            next if value.nil? && !sparse?(shape)

            type <<
              if value.nil?
                nil
              else
                parse_data(value, shape.member.shape)
              end
          end
          type
        end

        def parse_map(values, shape, type = nil)
          type = {} if type.nil?
          values.each do |key, value|
            next if value.nil? && !sparse?(shape)

            type[key] =
              if value.nil?
                nil
              else
                parse_data(value, shape.value.shape)
              end
          end
          type
        end

        def parse_structure(values, shape, type = nil)
          type = shape.type.new if type.nil?
          values.each do |key, value|
            if (member = shape.member(key))
              member_name = shape.members_by_name[member.name]
              type[member_name] = parse_data(value, member.shape)
            end
          end
          type
        end
      end
    end
  end
end
