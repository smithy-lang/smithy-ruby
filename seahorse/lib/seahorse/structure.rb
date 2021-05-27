# frozen_string_literal: true

module Seahorse
  module Structure

    # Deeply converts the Struct into a hash. Structure members that
    # are `nil` are omitted from the resultant hash.
    #
    # @return [Hash]
    def to_h(obj = self)
      case obj
      when Struct
        obj.each_pair.with_object({}) do |(member, value), hash|
          hash[member] = to_hash(value) unless value.nil?
        end
      when Hash
        obj.each.with_object({}) do |(key, value), hash|
          hash[key] = to_hash(value)
        end
      when Array
        obj.collect { |value| to_hash(value) }
      else
        obj
      end
    end
    alias to_hash to_h

  end
end
