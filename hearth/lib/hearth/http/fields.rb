# frozen_string_literal: true

module Hearth
  module HTTP
    # Provides Hash like access for Headers and Trailers with key normalization
    class Fields
      include Enumerable

      # @param [Array<Field>] fields
      # @param [String] encoding
      def initialize(fields = [], encoding: 'utf-8')
        @entries = {}
        fields.each { |field| self[field.name] = field }
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

      # Proxy class that wraps Fields to create Headers and Trailers
      class Proxy
        include Enumerable

        def initialize(fields, kind)
          @fields = fields
          @kind = kind
        end

        # @param [String] key
        def [](key)
          @fields[key]
        end

        # @param [String] key
        # @param [String, Integer, Array<String|Integer>] value
        def []=(key, value)
          @fields[key] = Field.new(key, value, kind: @kind)
        end

        # @return [Enumerable<Field>]
        def each(&block)
          @fields.filter { |f| f.kind == @kind }.each(&block)
        end

        # @return [Hash]
        def to_hash
          each.to_h { |v| [v.name, v.value(@fields.encoding)] }
        end
        alias to_h to_hash
      end
    end
  end
end
