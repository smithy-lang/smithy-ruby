# frozen_string_literal: true

module Smithy
  module Schema
    # Represents shape types from the Smithy model.
    module Shapes
      # A base shape that all shapes inherits from.
      class Shape
        def initialize(options = {})
          @id = options[:id]
          @traits = options[:traits] || {}
        end

        # @return [String, nil] Absolute shape ID from model
        attr_accessor :id

        # @return [Hash<String, Object>]
        attr_accessor :traits
      end

      # Represents an aggregate shape that has members.
      class Structure < Shape
        def initialize(options = {})
          super
          @members = {}
          @names_by_member_name = {}
        end

        # @return [Hash<Symbol, MemberShape>]
        attr_accessor :members

        # @return [Hash<String, Symbol>]
        attr_accessor :names_by_member_name

        # @return [Class, nil]
        attr_accessor :type

        # @return [MemberShape]
        def add_member(name, member_name, shape, traits: {})
          @names_by_member_name[member_name] = name
          @members[name] = MemberShape.new(member_name, shape, traits: traits)
        end

        # @param [Symbol] name
        # @return [Boolean]
        def member?(name)
          @members.key?(name)
        end

        # @param [Symbol] name
        # @return [MemberShape, nil]
        def member(name)
          @members[name]
        end

        # @param [String] member_name
        # @return [Boolean]
        def name_by_member_name?(member_name)
          @names_by_member_name.key?(member_name)
        end

        # @param [String] member_name
        # @return [Symbol, nil]
        def name_by_member_name(member_name)
          @names_by_member_name[member_name]
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

        # @return [String, nil] Service name
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

        # @return [String, nil] Operation name
        attr_accessor :name

        # @return [StructureShape, nil]
        attr_accessor :input

        # @return [StructureShape, nil]
        attr_accessor :output

        # @return [Array<StructureShape>]
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
      class EnumShape < Structure; end

      # Represents the following shapes: Byte, Short, Integer, Long, BigInteger.
      class IntegerShape < Shape; end

      # Represents an IntEnum shape.
      class IntEnumShape < Structure; end

      # Represents both Float and Double shapes.
      class FloatShape < Shape; end

      # Represents a List shape.
      class ListShape < Shape
        def initialize(options = {})
          super
          @member = nil
        end

        # @return [MemberShape, nil]
        attr_accessor :member

        def set_member(shape, traits: {})
          @member = MemberShape.new('member', shape, traits: traits)
        end
      end

      # Represents a Map shape.
      class MapShape < Shape
        def initialize(options = {})
          super
          @key = nil
          @value = nil
        end

        # @return [MemberShape, nil]
        attr_accessor :key

        # @return [MemberShape, nil]
        attr_accessor :value

        def set_key(shape, traits: {})
          @key = MemberShape.new('key', shape, traits: traits)
        end

        def set_value(shape, traits: {})
          @value = MemberShape.new('value', shape, traits: traits)
        end
      end

      # Represents a String shape.
      class StringShape < Shape; end

      # Represents a Structure shape.
      class StructureShape < Structure
      end

      # Represents a Timestamp shape.
      class TimestampShape < Shape; end

      # Represents both Union and EventStream shapes.
      class UnionShape < Structure
        def initialize(options = {})
          super
          @members = {}
          @member_types = {}
          @members_by_type = {}
        end

        # @return [Hash<Symbol, MemberShape>]
        attr_accessor :members

        # @return [Hash<Symbol, Class>]
        attr_accessor :member_types

        # @return [Hash<Class, MemberShape>]
        attr_accessor :members_by_type

        # @return [Class, nil]
        attr_accessor :type

        # @return [MemberShape]
        def add_member(name, member_name, shape, type, traits: {})
          member = MemberShape.new(member_name, shape, traits: traits)
          @names_by_member_name[member_name] = name
          @members[name] = member
          @members_by_type[type] = member
          @member_types[name] = type
          member
        end

        # @param [Symbol] name
        # @return [Boolean]
        def member?(name)
          @members.key?(name)
        end

        # @param [Symbol] name
        # @return [MemberShape, nil]
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
        # @return [MemberShape, nil]
        def member_by_type(type)
          @members_by_type[type]
        end
      end

      # Represents a member shape.
      class MemberShape
        def initialize(name, shape, traits: {})
          @name = name
          @shape = shape
          @traits = traits
        end

        # @return [String] Member name
        attr_accessor :name

        # @return [Shape] Referenced shape
        attr_accessor :shape

        # @return [Hash<String, Object>]
        attr_accessor :traits
      end

      # Prelude shape definitions.
      module Prelude
        BigDecimal = BigDecimalShape.new(id: 'smithy.api#BigDecimal')
        BigInteger = IntegerShape.new(id: 'smithy.api#BigInteger')
        Blob = BlobShape.new(id: 'smithy.api#Blob')
        Boolean = BooleanShape.new(id: 'smithy.api#Boolean')
        Byte = IntegerShape.new(id: 'smithy.api#Byte')
        Document = DocumentShape.new(id: 'smithy.api#Document')
        Double = FloatShape.new(id: 'smithy.api#Double')
        Float = FloatShape.new(id: 'smithy.api#Float')
        Integer = IntegerShape.new(id: 'smithy.api#Integer')
        Long = IntegerShape.new(id: 'smithy.api#Long')
        PrimitiveBoolean = BooleanShape.new(
          id: 'smithy.api#PrimitiveBoolean',
          traits: { 'smithy.api#default' => false }
        )
        PrimitiveByte = IntegerShape.new(
          id: 'smithy.api#PrimitiveByte',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveDouble = FloatShape.new(
          id: 'smithy.api#PrimitiveDouble',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveFloat = FloatShape.new(
          id: 'smithy.api#PrimitiveFloat',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveInteger = IntegerShape.new(
          id: 'smithy.api#PrimitiveInteger',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveShort = IntegerShape.new(
          id: 'smithy.api#PrimitiveShort',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveLong = IntegerShape.new(
          id: 'smithy.api#PrimitiveLong',
          traits: { 'smithy.api#default' => 0 }
        )
        Short = IntegerShape.new(id: 'smithy.api#Short')
        String = StringShape.new(id: 'smithy.api#String')
        Timestamp = TimestampShape.new(id: 'smithy.api#Timestamp')
        Unit = StructureShape.new(
          id: 'smithy.api#Unit',
          traits: { 'smithy.api#unitType' => {} }
        )
      end
    end
  end
end
