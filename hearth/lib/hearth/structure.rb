# frozen_string_literal: true

module Hearth
  # A module mixed into Structs that provides utility methods.
  module Structure
    # Initializes the structure with the given options. If a member is
    # not provided, the default value is used.
    def initialize(options = {})
      if is_a?(Union)
        super
      else
        if respond_to?(:_defaults, true)
          _defaults.each do |k, v|
            options[k] = v unless options.include?(k)
          end
        end
        options.each do |k, v|
          send("#{k}=", v)
        end
      end
    end

    # Deeply converts the Struct into a hash. Structure members that
    # are `nil` are omitted from the resultant hash.
    #
    # @return [Hash, Structure]
    def to_h(obj = self)
      case obj
      when Union
        obj.to_h
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

    private

    def _to_h_structure(obj)
      obj.class::MEMBERS.each_with_object({}) do |member, hash|
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
