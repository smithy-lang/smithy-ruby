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
    class OperationInput < Struct.new(
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
      keyword_init: true
    )
      include ::Smithy::Schema::Structure
    end

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
    class OperationOutput < Struct.new(
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
      keyword_init: true
    )
      include ::Smithy::Schema::Structure
    end

    # @!attribute member
    #   @return [String]
    class Structure < Struct.new(
      :member,
      keyword_init: true
    )
      include ::Smithy::Schema::Structure
    end

    # @!attribute string
    #   @return [String]
    # @!attribute structure
    #   @return [Types::Structure]
    # @!attribute unit
    #   @return [Smithy::Schema::EmptyStructure]
    class Union < Struct.new(
      :string,
      :structure,
      :unit,
      :unknown,
      keyword_init: true
    )
      include ::Smithy::Schema::Union

      class String < Union; end
      class Structure < Union; end
      class Unit < Union; end
      class Unknown < Union; end
    end

  end
end
