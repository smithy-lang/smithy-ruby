# frozen_string_literal: true

module Smithy
  module Schema
    # Represents shape types from the Smithy model.
    module Shapes
      # A base shape that all shapes inherits from.
      class Shape
        def initialize(options = {})
          @id = options[:id]
          @name = options[:name]
          @traits = options[:traits] || {}
          @metadata = {}
        end

        # @return [String] Absolute shape ID from model
        attr_accessor :id

        # @return [String] Shape name
        attr_accessor :name

        # @return [Hash<String, Object>]
        attr_accessor :traits

        # @return [Object]
        def [](key)
          @metadata[key]
        end

        # @param [Symbol] key
        # @param [Object] value
        def []=(key, value)
          @metadata[key] = value
        end
      end

      # A reference to a shape.
      class ShapeRef
        def initialize(options = {})
          @shape = options[:shape]
          @location_name = options[:location_name]
          @traits = options[:traits] || {}
          @metadata = {}
        end

        # @return [Shape]
        attr_accessor :shape

        # @return [String, nil]
        attr_accessor :location_name

        # @return [Hash<String, Object>]
        attr_accessor :traits

        # @return [Object]
        def [](key)
          @metadata[key]
        end

        # @param [Symbol] key
        # @param [Object] value
        def []=(key, value)
          @metadata[key] = value
        end
      end

      # Represents a slim variation of the Service shape.
      class ServiceShape < Shape
        include Enumerable

        def initialize(options = {})
          super
          @name = options[:name]
          @version = options[:version]
          @operations = {}
          yield self if block_given?
        end

        # @return [String]
        attr_accessor :name

        # @return [String, nil]
        attr_accessor :version

        # @return [Hash<Symbol, OperationShape>]
        attr_accessor :operations

        # @return [Hash<Symbol, OperationShape>]
        def each(&)
          @operations.each(&)
        end

        # @return [OperationShape]
        def add_operation(name, operation)
          @operations[name] = operation
        end

        # @param [Symbol] name
        # @return [OperationShape] operation
        def operation(name)
          raise ArgumentError, "unknown operation #{name.inspect}" unless @operations.key?(name)

          @operations[name]
        end

        # @return [Array<Symbol>]
        def operation_names
          @operations.keys
        end
      end

      # Represents an Operation shape.
      class OperationShape < Shape
        def initialize(options = {})
          super
          @name = options[:name]
          @input = options[:input]
          @output = options[:output]
          @errors = options[:errors] || []
          yield self if block_given?
        end

        # @return [String]
        attr_accessor :name

        # @return [ShapeRef]
        attr_accessor :input

        # @return [ShapeRef]
        attr_accessor :output

        # @return [Array<ShapeRef>]
        attr_accessor :errors
      end

      # Represents a BigDecimal shape.
      class BigDecimalShape < Shape; end

      # Represents both Blob and Data Stream shapes.
      class BlobShape < Shape; end

      # Represents a Boolean shape.
      class BooleanShape < Shape; end

      # Represents a Document shape.
      class DocumentShape < Shape; end

      # Represents an Enum shape.
      class EnumShape < Shape
        def initialize(options = {})
          super
          @members = {}
        end

        # @return [Hash<Symbol, ShapeRef>]
        attr_accessor :members

        # @return [ShapeRef]
        def add_member(name, shape_ref)
          @members[name] = shape_ref
        end

        # @param [Symbol] name
        # @return [Boolean]
        def member?(name)
          @members.key?(name)
        end

        # @param [Symbol] name
        # @return [ShapeRef, nil]
        def member(name)
          @members[name]
        end
      end

      # Represents both Float and Double shapes.
      class FloatShape < Shape; end

      # Represents the following shapes: Byte, Short, Integer, Long, BigInteger.
      class IntegerShape < Shape; end

      # Represents an IntEnum shape.
      class IntEnumShape < Shape
        def initialize(options = {})
          super
          @members = {}
        end

        # @return [Hash<Symbol, ShapeRef>]
        attr_accessor :members

        # @return [ShapeRef]
        def add_member(name, shape_ref)
          @members[name] = shape_ref
        end

        # @param [Symbol] name
        # @return [Boolean]
        def member?(name)
          @members.key?(name)
        end

        # @param [Symbol] name
        # @return [ShapeRef, nil]
        def member(name)
          @members[name]
        end
      end

      # Represents a List shape.
      class ListShape < Shape
        # @return [ShapeRef]
        attr_accessor :member
      end

      # Represents a Map shape.
      class MapShape < Shape
        # @return [ShapeRef]
        attr_accessor :key

        # @return [ShapeRef]
        attr_accessor :value
      end

      # Represents a String shape.
      class StringShape < Shape; end

      # Represents a Structure shape.
      class StructureShape < Shape
        def initialize(options = {})
          super
          @members = {}
        end

        # @return [Hash<Symbol, ShapeRef>]
        attr_accessor :members

        # @return [Class]
        attr_accessor :type

        # @return [ShapeRef]
        def add_member(name, shape_ref)
          @members[name] = shape_ref
        end

        # @param [Symbol] name
        # @return [Boolean]
        def member?(name)
          @members.key?(name)
        end

        # @param [Symbol] name
        # @return [ShapeRef, nil]
        def member(name)
          @members[name]
        end
      end

      # Represents a Timestamp shape.
      class TimestampShape < Shape; end

      # Represents both Union and EventStream shapes.
      class UnionShape < Shape
        def initialize(options = {})
          super
          @members = {}
          @member_types = {}
          @members_by_type = {}
        end

        # @return [Hash<Symbol, ShapeRef>]
        attr_accessor :members

        # @return [Hash<Symbol, Class>]
        attr_accessor :member_types

        # @return [Hash<Class, [String, ShapeRef]>]
        attr_accessor :members_by_type

        # @return [Class]
        attr_accessor :type

        # @return [ShapeRef]
        def add_member(name, type, shape_ref)
          @member_types[name] = type
          @members_by_type[type] = [name, shape_ref]
          @members[name] = shape_ref
        end

        # @param [Symbol] name
        # @return [Boolean]
        def member?(name)
          @members.key?(name)
        end

        # @param [Symbol] name
        # @return [ShapeRef, nil]
        def member(name)
          @members[name]
        end

        # @param [Symbol] name
        # @return [Boolean]
        def member_type?(name)
          @member_types.key?(name)
        end

        # @param [Symbol] name
        # @return [Class, nil]
        def member_type(name)
          @member_types[name]
        end

        # @param [Class] type
        # @return [Boolean]
        def member_by_type?(type)
          @members_by_type.key?(type)
        end

        # @param [Class] type
        # @return [ShapeRef, nil]
        def member_by_type(type)
          @members_by_type[type]
        end
      end

      # Prelude shape definitions.
      module Prelude
        BigDecimal = BigDecimalShape.new(id: 'smithy.api#BigDecimal', name: 'BigDecimal')
        BigInteger = IntegerShape.new(id: 'smithy.api#BigInteger', name: 'BigInteger')
        Blob = BlobShape.new(id: 'smithy.api#Blob', name: 'Blob')
        Boolean = BooleanShape.new(id: 'smithy.api#Boolean', name: 'Boolean')
        Byte = IntegerShape.new(id: 'smithy.api#Byte', name: 'Byte')
        Document = DocumentShape.new(id: 'smithy.api#Document', name: 'Document')
        Double = FloatShape.new(id: 'smithy.api#Double', name: 'Double')
        Float = FloatShape.new(id: 'smithy.api#Float', name: 'Float')
        Integer = IntegerShape.new(id: 'smithy.api#Integer', name: 'Integer')
        Long = IntegerShape.new(id: 'smithy.api#Long', name: 'Long')
        PrimitiveBoolean = BooleanShape.new(
          id: 'smithy.api#PrimitiveBoolean',
          name: 'PrimitiveBoolean',
          traits: { 'smithy.api#default' => false }
        )
        PrimitiveByte = IntegerShape.new(
          id: 'smithy.api#PrimitiveByte',
          name: 'PrimitiveByte',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveDouble = FloatShape.new(
          id: 'smithy.api#PrimitiveDouble',
          name: 'PrimitiveDouble',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveFloat = FloatShape.new(
          id: 'smithy.api#PrimitiveFloat',
          name: 'PrimitiveFloat',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveInteger = IntegerShape.new(
          id: 'smithy.api#PrimitiveInteger',
          name: 'PrimitiveInteger',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveShort = IntegerShape.new(
          id: 'smithy.api#PrimitiveShort',
          name: 'PrimitiveShort',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveLong = IntegerShape.new(
          id: 'smithy.api#PrimitiveLong',
          name: 'PrimitiveLong',
          traits: { 'smithy.api#default' => 0 }
        )
        Short = IntegerShape.new(id: 'smithy.api#Short', name: 'Short')
        String = StringShape.new(id: 'smithy.api#String', name: 'String')
        Timestamp = TimestampShape.new(id: 'smithy.api#Timestamp', name: 'Timestamp',)
        Unit = StructureShape.new(
          id: 'smithy.api#Unit',
          name: 'Unit',
          traits: { 'smithy.api#unitType' => {} }
        )
        Unit.type = EmptyStructure
      end
    end
  end
end
