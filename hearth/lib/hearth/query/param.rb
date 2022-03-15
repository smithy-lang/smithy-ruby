# frozen_string_literal: true

module Hearth
  module Query
    # A class used to represent a query parameter before serialization.
    # @api private
    class Param
      # @param [String] name
      # @param [String, Array, nil] value (nil)
      def initialize(name, value = nil)
        @name = name
        @value = value
      end

      # @return [String]
      attr_reader :name

      # @return [String, nil]
      attr_reader :value

      # @return [String]
      def to_s
        if value.is_a?(Array)
          value.map { |v| serialize(name, v) }.join('&')
        else
          serialize(name, value)
        end
      end

      # @return [Boolean]
      def ==(other)
        other.is_a?(Param) &&
          other.name == name &&
          other.value == value
      end

      # @return [Boolean]
      def <=>(other)
        name <=> other.name
      end

      private

      def serialize(name, value)
        value ? "#{escape(name)}=#{escape(value)}" : "#{escape(name)}="
      end

      def escape(str)
        Hearth::HTTP.uri_escape(str)
      end
    end
  end
end
