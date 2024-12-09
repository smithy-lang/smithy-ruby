# frozen_string_literal: true

module Smithy
  module Client
    module HTTP
      # Represents an HTTP field.
      class Field
        # @param [String] name The name of the field.
        # @param [#to_s] value (nil) The value for the field. It can be any
        #  object that responds to `#to_s`.
        # @param [Hash] options
        # @option options [Symbol] :kind (:header) The kind of field, either
        #  :header` or `:trailer`.
        def initialize(name, value = nil, **options)
          raise ArgumentError, 'Field name must be a non-empty String' if name.nil? || name.empty?

          @name = name
          @value = value
          @kind = options[:kind] || :header
        end

        # @return [String]
        attr_reader :name

        # @return [Symbol]
        attr_reader :kind

        # Returns a string representation of the field.
        # @return [String]
        def value(encoding = nil)
          encoding ? @value.to_s.encode(encoding) : @value.to_s
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
      end
    end
  end
end
