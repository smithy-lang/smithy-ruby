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

      def initialize(**args)
        args[:blob] = 'YmxvYg==' unless args.key?(:blob)
        args[:boolean] = true unless args.key?(:boolean)
        args[:string] = 'string' unless args.key?(:string)
        args[:byte] = 0 unless args.key?(:byte)
        args[:short] = 0 unless args.key?(:short)
        args[:integer] = 0 unless args.key?(:integer)
        args[:long] = 0 unless args.key?(:long)
        args[:float] = 0.0 unless args.key?(:float)
        args[:double] = 0.0 unless args.key?(:double)
        args[:big_integer] = 0 unless args.key?(:big_integer)
        args[:big_decimal] = 0.0 unless args.key?(:big_decimal)
        args[:timestamp] = '1985-04-12T23:20:50.52Z' unless args.key?(:timestamp)
        args[:enum] = 'bar' unless args.key?(:enum)
        args[:int_enum] = 1 unless args.key?(:int_enum)
        args[:list] = [] unless args.key?(:list)
        args[:map] = {} unless args.key?(:map)
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
