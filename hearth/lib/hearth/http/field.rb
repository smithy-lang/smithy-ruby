# frozen_string_literal: true

module Hearth
  module HTTP
    # Represents an HTTP field.
    class Field
      # @param [String] name The name of the field.
      # @param [Array<String>] value ([]) The String values for the field.
      # @param [Symbol] kind The kind of field, either :header or :trailer.
      #   Trailers are currently not supported by Net::HTTP.
      def initialize(name, value = [], kind: :header)
        if name.nil? || name.empty?
          raise ArgumentError, 'Field name must be a non-empty String'
        end

        @name = name
        @values = _values(value)
        @kind = kind
      end

      # @return [String]
      attr_reader :name

      # @return [Array, nil]
      attr_reader :values

      # @return [Symbol]
      attr_reader :kind

      # @param [Array|String|Integer|Float] value
      def values=(value)
        @values = _values(value)
      end

      # Append a value to the field.
      # @param [String|Integer|Float] value
      def <<(value)
        @values << value.to_s
      end

      # Delete a value from the field.
      # @param [String] value
      def delete(value)
        @values.delete(value)
      end

      # Returns an escaped string representation of the field.
      # @return [String]
      def value(encoding = nil)
        value = if @values.size > 1
                  @values.compact.map { |v| escape_value(v.to_s) }.join(', ')
                else
                  @values.first&.to_s || ''
                end
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

      def to_h
        { @name => value }
      end

      private

      def _values(value)
        case value
        when String, Integer, Float then [value]
        when Array then value
        else
          raise ArgumentError,
                'Field value must be a String, Integer, Float, or Array'
        end
      end

      def escape_value(str)
        s = str
        s.include?('"') || s.include?(',') ? "\"#{s.gsub('"', '\"')}\"" : s
      end
    end
  end
end
