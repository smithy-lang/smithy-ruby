# frozen_string_literal: true

module Hearth
  module HTTP
    # Provides Hash like access for Headers and Trailers with key normalization
    class Fields
      include Enumerable

      # @param [Hash<String,String|Integer|Array|Field>] fields
      def initialize(fields = {}, encoding: 'utf-8')
        @entries = {}
        fields.each_pair { |k, v| self[k] = v }
        @encoding = encoding
      end

      # @return [String]
      attr_reader :encoding

      # @param [String] key
      def [](key)
        @entries[key.downcase]
      end

      # @param [String] key
      # @param [Field] value
      def []=(key, value)
        raise ArgumentError, 'value must be a Field' unless value.is_a?(Field)
        @entries[key.downcase] = value
      end

      # @param [Field] field
      def <<(field)
        @entries[field.name.downcase] << field
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

      # @return [Enumerable<Field>]
      def each(&block)
        @entries.values.each(&block)
      end

      # @return [Hash]
      def to_hash
        each.to_h { |v| [v.name, v.value(@encoding)] }
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
