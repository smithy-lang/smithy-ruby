# frozen_string_literal: true

module Hearth
  module HTTP
    # Provides Hash like access for Headers and Trailers with key normalization
    class Fields
      include Enumerable

      # @param [Hash<String,Field>] fields
      def initialize(fields = {}, encoding: 'utf-8')
        @entries = {}
        fields.each_pair do |key, value|
          self[key] = value
        end
        @encoding = encoding
      end

      # @return [String]
      attr_reader :encoding

      # @param [String] key
      def [](key)
        @entries[key.downcase]
      end

      # @param [String] key
      # @param [String,Array,Field] value
      def []=(key, value)
        value =
          case value
          when String
            Field.new(key, [value])
          when Integer
            Field.new(key, [value.to_s])
          when Array
            Field.new(key, value)
          when Field
            value
          else
            raise ArgumentError,
                  'value must be a String, Integer, Array, or Field'
          end
        @entries[key.downcase] = value
      end

      # @param [String] key
      # @return [Boolean] Returns `true` if there is a Field with the given key.
      def key?(key)
        @entries.key?(key.downcase)
      end

      # @return [Array<String>]
      def keys
        @entries.keys
      end

      # @param [String] key
      # @return [Field, nil] Returns the Field for the deleted Field key.
      def delete(key)
        @entries.delete(key.downcase)
      end

      # @return [Enumerable<String,Field>]
      def each_pair(&block)
        @entries.each(&block)
      end
      alias each each_pair

      # @return [Hash]
      def to_hash
        @entries.to_h { |_k, v| [v.name, v.value] }
      end
      alias to_h to_hash

      # @return [Integer] Returns the number of Field entries.
      def size
        @entries.size
      end

      # @return [Hash]
      def clear
        @entries = {}
      end
    end
  end
end
