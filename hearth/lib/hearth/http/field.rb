# frozen_string_literal: true

module Hearth
  module HTTP
    # Represents an HTTP field.
    class Field
      # @param [String] name The name of the field.
      # @param [String|#to_s] value (nil) The value for the field. It can be any
      #   object that responds to `#to_s`.
      # @param [Symbol] kind The kind of field, either :header or :trailer.
      def initialize(name, value = nil, kind: :header)
        if name.nil? || name.empty?
          raise ArgumentError, 'Field name must be a non-empty String'
        end

        @name = name
        @value = value
        @kind = kind
      end

      # @return [String]
      attr_reader :name

      # @return [Symbol]
      attr_reader :kind

      # Returns a string representation of the field.
      # @return [String]
      def value(encoding = nil)
        value = @value.to_s
        value = value.encode(encoding) if encoding
        value
      end

      # @return [Boolean]
      def header?
        @kind == :header
      end

      # @return [Boolean]
      def trailer?
        @kind == :trailer
      end

      # @return [Hash]
      def to_h
        { @name => value }
      end

      # Escapes header field value
      # @return [String]
      def self.escape_value(str)
        s = str
        s.include?('"') || s.include?(',') ? "\"#{s.gsub('"', '\"')}\"" : s
      end
    end
  end
end
