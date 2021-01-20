# frozen_string_literal: true

module Seahorse
  # Addons for generated Struct types. Adds a Hash interface to a Struct.
  module StructAddons
    # Hashy initialization of a Struct
    def initialize(**values)
      values.each_pair do |key, value|
        self[key] = value
      end
    end

    # @return [Boolean] Returns `true` if this structure has a value
    #   set for the given member.
    def key?(member_name)
      self[member_name] != nil
    end

    # @return [Boolean] Returns `true` if all of the member values are `nil`.
    def empty?
      values.compact.empty?
    end

    # Deeply converts the Structure into a hash.  Structure members that
    # are `nil` are omitted from the resultant hash.
    #
    # @return [Hash]
    def to_hash(obj = self)
      case obj
      when Struct
        obj.members.each_with_object({}) do |member, hash|
          value = obj[member]
          hash[member] = to_hash(value) unless value.nil?
        end
      when Hash
        obj.each_with_object({}) do |(key, value), hash|
          hash[key] = to_hash(value)
        end
      when Array
        obj.map { |value| to_hash(value) }
      else
        obj
      end
    end
    alias to_h to_hash
  end

  # Empty Struct definition must be defined after StructAddons
  EmptyStructure = Struct.new('EmptyStructure') do
    include Seahorse::StructAddons
  end
end
