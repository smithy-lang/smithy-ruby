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
        include Model::Shapes

        def initialize(options = {}); end

        # @param [Object] data
        # @param [Shape] shape
        # @return [String] the encoded bytes in CBOR format
        def serialize(data, shape)
          return nil if shape == Prelude::Unit

          Client::CBOR.encode(format_data(data, shape))
        end

        # @param [String] bytes
        # @param [Shape] shape
        # @param [Struct] type
        # @return [Object, Hash]
        def deserialize(bytes, shape, type = nil)
          return {} if bytes.empty? || shape == Prelude::Unit

          parse_data(Client::CBOR.decode(bytes), shape, type)
        end

        private

        def sparse?(shape)
          shape.traits.keys.include?('smithy.api#sparse')
        end

        def format_blob(value)
          (value.is_a?(String) ? value : value.read).force_encoding(Encoding::BINARY)
        end

        def format_data(value, shape)
          case shape
          when StructureShape then format_structure(value, shape)
          when ListShape      then format_list(value, shape)
          when MapShape       then format_map(value, shape)
          when BlobShape      then format_blob(value)
          else value
          end
        end

        def format_list(values, shape)
          values.collect do |value|
            next if value.nil? && !sparse?(shape)

            if value.nil? && sparse?(shape)
              nil
            else
              format_data(value, shape.member.shape)
            end
          end
        end

        def format_map(values, shape)
          values.each.with_object({}) do |(key, value), data|
            next if value.nil? && !sparse?(shape)

            data[key] =
              if value.nil? && sparse?(shape)
                nil
              else
                format_data(value, shape.value.shape)
              end
          end
        end

        def format_structure(values, shape)
          values.each_pair.with_object({}) do |(key, value), data|
            if shape.member?(key) && !value.nil?
              member = shape.member(key)
              data[member.name] = format_data(value, member.shape)
            end
          end
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
