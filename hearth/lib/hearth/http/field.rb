# frozen_string_literal: true

module Hearth
  module HTTP
    # Represents an HTTP field.
    class Field
      # @param [String] name The name of the field.
      # @param [Array<String>] values ([]) The String values for the field.
      # @param [Symbol] kind The kind of field, either :header or :trailer.
      #   Trailers are currently not supported.
      def initialize(name, values = [], kind: :header)
        if name.nil? || name.empty?
          raise ArgumentError, 'Field name must be a non-empty String'
        end

        if !values.is_a?(Array) || values.any? { |v| !v.is_a?(String) }
          raise ArgumentError, 'Field values must be an Array of Strings'
        end

        @name = name
        @values = values
        @kind = kind
      end

      # @return [String]
      attr_reader :name

      # @return [Array, nil]
      attr_accessor :values

      # @return [Symbol]
      attr_reader :kind

      # Append a value to the field.
      # @param [String] value
      def <<(value)
        @values << value
      end

      # Delete a value from the field.
      # @param [String] value
      def delete(value)
        @values.delete(value)
      end

      # Returns an escaped string representation of the field.
      # @return [String]
      def value
        @values.compact.map { |v| escape_value(v) }.join(',')
      end

      # @return [Boolean]
      def header?
        @kind == :header
      end

      def to_h
        { @name => value }
      end

      private

      def escape_value(str)
        s = str
        s.include?('"') || s.include?(',') ? "\"#{s.gsub('"', '\"')}\"" : s
      end
    end
  end
end
