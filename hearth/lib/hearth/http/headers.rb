# frozen_string_literal: true

module Hearth
  module HTTP
    # Provides Hash like access for Headers with key normalization
    # @api private
    class Headers
      # @param [Hash<String,String>] headers
      def initialize(headers: {})
        @headers = {}
        headers.each_pair do |key, value|
          self[key] = value
        end
      end

      # @param [String] key
      def [](key)
        @headers[normalize(key)]
      end

      # @param [String] key
      # @param [String] value
      def []=(key, value)
        @headers[normalize(key)] = value.to_s
      end

      # @param [String] key
      # @return [Boolean] Returns `true` if there is a header with
      #   the given key.
      def key?(key)
        @headers.key?(normalize(key))
      end

      # @return [Array<String>]
      def keys
        @headers.keys
      end

      # @param [String] key
      # @return [String, nil] Returns the value for the deleted key.
      def delete(key)
        @headers.delete(normalize(key))
      end

      # @return [Enumerable<String,String>]
      def each_pair(&block)
        @headers.each(&block)
      end
      alias each each_pair

      # @return [Hash]
      def to_hash
        @headers.dup
      end
      alias to_h to_hash

      # @return [Integer] Returns the number of entries in the headers
      #   hash.
      def size
        @headers.size
      end

      # @return [Hash]
      def clear
        @headers = {}
      end

      private

      def normalize(key)
        key.to_s.gsub(/[^-]+/, &:capitalize)
      end
    end
  end
end
