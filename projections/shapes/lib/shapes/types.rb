# frozen_string_literal: true

# This is generated code!

module ShapeService
  # This module contains the types returned by client operations.
  module Types

    # TODO!
    OperationInputOutput = Struct.new(
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
    ) do
      include Smithy::Schema::Structure
    end

    # TODO!
    Structure = Struct.new(
      :member,
      keyword_init: true
    ) do
      include Smithy::Schema::Structure
    end

    # TODO!
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

      class Unknown < Union
        def initialize(name:, value:)
          super({name: name || 'Unknown', value: value})
        end

        def to_h
          { unknown: super(__getobj__) }
        end
      end
    end

  end
end
