# frozen_string_literal: true

module Hearth
  module HTTP
    # Represents an HTTP field.
    # @api private
    class Field
      # @param [String] name The name of the field.
      # @param [Array|#to_s] value (nil) The values for the field. It can be any
      #   object that responds to `#to_s` or an Array of objects that respond to
      #  `#to_s`.
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

      # Returns an escaped string representation of the field.
      # @return [String]
      def value(encoding = nil)
        value =
          if @value.is_a?(Array)
            @value.compact.map { |v| escape_value(v.to_s) }.join(', ')
          else
            @value.to_s
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

      def escape_value(str)
        s = str
        s.include?('"') || s.include?(',') ? "\"#{s.gsub('"', '\"')}\"" : s
      end
    end
  end
end
