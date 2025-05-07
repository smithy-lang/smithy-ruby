# frozen_string_literal: true

# This is generated code!

module ShapeService
  # This module contains the types returned by client operations.
  module Types

    # @!attribute blob
    #   @return [String]
    # @!attribute boolean
    #   @return [Boolean]
    # @!attribute string
    #   @return [String]
    # @!attribute byte
    #   @return [Integer]
    # @!attribute short
    #   @return [Integer]
    # @!attribute integer
    #   @return [Integer]
    # @!attribute long
    #   @return [Integer]
    # @!attribute float
    #   @return [Float]
    # @!attribute double
    #   @return [Float]
    # @!attribute big_integer
    #   @return [Object]
    # @!attribute big_decimal
    #   @return [Object]
    # @!attribute timestamp
    #   @return [Time]
    # @!attribute document
    #   @return [JSON]
    # @!attribute enum
    #   @return [String]
    # @!attribute int_enum
    #   @return [Integer]
    # @!attribute list
    #   @return [Array<String>]
    # @!attribute map
    #   @return [Hash<String, String>]
    # @!attribute structure
    #   @return [Types::Structure]
    # @!attribute union
    #   @return [Types::Union]
    class OperationInputOutput < Struct.new(
      :blob,
      :boolean,
      :string,
      :byte,
      :short,
      :integer,
      :long,
      :float,
      :double,
      :big_integer,
      :big_decimal,
      :timestamp,
      :document,
      :enum,
      :int_enum,
      :list,
      :map,
      :structure,
      :union,
      keyword_init: true)
      include Smithy::Schema::Structure

      def initialize(options = {})
        require 'byebug'; byebug
        options[:blob] = 'YmxvYg==' unless options.key?(:blob)
        options[:boolean] = true unless options.key?(:boolean)
        options[:string] = 'string' unless options.key?(:string)
        options[:byte] = 0 unless options.key?(:byte)
        options[:short] = 0 unless options.key?(:short)
        options[:integer] = 0 unless options.key?(:integer)
        options[:long] = 0 unless options.key?(:long)
        options[:float] = 0.0 unless options.key?(:float)
        options[:double] = 0.0 unless options.key?(:double)
        options[:big_integer] = 0 unless options.key?(:big_integer)
        options[:big_decimal] = 0.0 unless options.key?(:big_decimal)
        options[:timestamp] = '1985-04-12T23:20:50.52Z' unless options.key?(:timestamp)
        options[:enum] = 'bar' unless options.key?(:enum)
        options[:int_enum] = 1 unless options.key?(:int_enum)
        options[:list] = [] unless options.key?(:list)
        options[:map] = {} unless options.key?(:map)
        super
      end
    end

    # @!attribute member
    #   @return [String]
    class Structure < Struct.new(
      :member,
      keyword_init: true)
      include Smithy::Schema::Structure
    end

    class Union < Smithy::Schema::Union
      class String < Union
        def to_h
          { string: super(__getobj__) }
        end
      end

      class Structure < Union
        def to_h
          { structure: super(__getobj__) }
        end
      end

      class Unit < Union
        def to_h
          { unit: super(__getobj__) }
        end
      end

      class Unknown < Union
        def initialize(name, value)
          super({ name: name, value: value })
        end

        def to_h
          { unknown: super(__getobj__) }
        end
      end
    end

  end
end
