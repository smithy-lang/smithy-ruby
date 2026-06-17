# frozen_string_literal: true

module Smithy
  module Schema
    # A module mixed into Structs that provides utility methods for Structure shapes.
    module Structure
      def self.included(base)
        base.undef_method(:each) if base.is_a?(Class) && base.method_defined?(:each)
      end

      # Deeply converts the Struct into a hash. Structure members that
      # are `nil` are omitted from the resultant hash.
      # @return [Hash, Structure]
      def to_h(obj = self)
        case obj
        when Structure
          _to_h_structure(obj)
        when Hash
          _to_h_hash(obj)
        when Array
          _to_h_array(obj)
        else
          obj
        end
      end
      alias to_hash to_h

      # @return [Boolean]
      def empty?
        values.compact == []
      end

      # @param [Symbol] member_name
      # @return [Boolean]
      def key?(member_name)
        !self[member_name].nil?
      end

      private

      def _to_h_structure(obj)
        obj.members.each_with_object({}) do |member, hash|
          value = obj.send(member)
          hash[member] = to_hash(value) unless value.nil?
        end
      end

      def _to_h_hash(obj)
        obj.transform_values do |value|
          to_hash(value)
        end
      end

      def _to_h_array(obj)
        obj.collect { |value| to_hash(value) }
      end
    end
  end
end
