# frozen_string_literal: true

# This is generated code!

module ShapeService
  # This module contains a schema composed of shapes used by the client.
  module Schema

    BigDecimal = ::Smithy::Schema::Shapes::BigDecimalShape.new(id: "smithy.ruby.tests#BigDecimal", name: "BigDecimal", traits: {"smithy.ruby.tests#shape" => {}})
    BigInteger = ::Smithy::Schema::Shapes::IntegerShape.new(id: "smithy.ruby.tests#BigInteger", name: "BigInteger", traits: {"smithy.ruby.tests#shape" => {}})
    Blob = ::Smithy::Schema::Shapes::BlobShape.new(id: "smithy.ruby.tests#Blob", name: "Blob", traits: {"smithy.ruby.tests#shape" => {}})
    Boolean = ::Smithy::Schema::Shapes::BooleanShape.new(id: "smithy.ruby.tests#Boolean", name: "Boolean", traits: {"smithy.ruby.tests#shape" => {}})
    Byte = ::Smithy::Schema::Shapes::IntegerShape.new(id: "smithy.ruby.tests#Byte", name: "Byte", traits: {"smithy.ruby.tests#shape" => {}})
    Document = ::Smithy::Schema::Shapes::DocumentShape.new(id: "smithy.ruby.tests#Document", name: "Document", traits: {"smithy.ruby.tests#shape" => {}})
    Double = ::Smithy::Schema::Shapes::FloatShape.new(id: "smithy.ruby.tests#Double", name: "Double", traits: {"smithy.ruby.tests#shape" => {}})
    Enum = ::Smithy::Schema::Shapes::EnumShape.new(id: "smithy.ruby.tests#Enum", name: "Enum", traits: {"smithy.ruby.tests#shape" => {}})
    Float = ::Smithy::Schema::Shapes::FloatShape.new(id: "smithy.ruby.tests#Float", name: "Float", traits: {"smithy.ruby.tests#shape" => {}})
    IntEnum = ::Smithy::Schema::Shapes::IntEnumShape.new(id: "smithy.ruby.tests#IntEnum", name: "IntEnum", traits: {"smithy.ruby.tests#shape" => {}})
    Integer = ::Smithy::Schema::Shapes::IntegerShape.new(id: "smithy.ruby.tests#Integer", name: "Integer", traits: {"smithy.ruby.tests#shape" => {}})
    List = ::Smithy::Schema::Shapes::ListShape.new(id: "smithy.ruby.tests#List", name: "List", traits: {"smithy.ruby.tests#shape" => {}})
    Long = ::Smithy::Schema::Shapes::IntegerShape.new(id: "smithy.ruby.tests#Long", name: "Long", traits: {"smithy.ruby.tests#shape" => {}})
    Map = ::Smithy::Schema::Shapes::MapShape.new(id: "smithy.ruby.tests#Map", name: "Map", traits: {"smithy.ruby.tests#shape" => {}})
    OperationInput = ::Smithy::Schema::Shapes::StructureShape.new(id: "smithy.ruby.tests#OperationInput", name: "OperationInput")
    OperationOutput = ::Smithy::Schema::Shapes::StructureShape.new(id: "smithy.ruby.tests#OperationOutput", name: "OperationOutput")
    Short = ::Smithy::Schema::Shapes::IntegerShape.new(id: "smithy.ruby.tests#Short", name: "Short", traits: {"smithy.ruby.tests#shape" => {}})
    String = ::Smithy::Schema::Shapes::StringShape.new(id: "smithy.ruby.tests#String", name: "String", traits: {"smithy.ruby.tests#shape" => {}})
    Structure = ::Smithy::Schema::Shapes::StructureShape.new(id: "smithy.ruby.tests#Structure", name: "Structure", traits: {"smithy.ruby.tests#shape" => {}})
    Timestamp = ::Smithy::Schema::Shapes::TimestampShape.new(id: "smithy.ruby.tests#Timestamp", name: "Timestamp", traits: {"smithy.ruby.tests#shape" => {}})
    Union = ::Smithy::Schema::Shapes::UnionShape.new(id: "smithy.ruby.tests#Union", name: "Union", traits: {"smithy.ruby.tests#shape" => {}})

    Enum.add_member(:foo, ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::Unit, name: "FOO", traits: {"smithy.api#enumValue" => "bar"}))
    IntEnum.add_member(:baz, ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::Unit, name: "BAZ", traits: {"smithy.api#enumValue" => 1}))
    List.member = ::Smithy::Schema::Shapes::MemberShape.new(target: String, name: "member", traits: {"smithy.ruby.tests#shape" => {}})
    Map.key = ::Smithy::Schema::Shapes::MemberShape.new(target: String, name: "key", traits: {"smithy.ruby.tests#shape" => {}})
    Map.value = ::Smithy::Schema::Shapes::MemberShape.new(target: String, name: "value", traits: {"smithy.ruby.tests#shape" => {}})
    OperationInput.add_member(:blob, ::Smithy::Schema::Shapes::MemberShape.new(target: Blob, name: "blob"))
    OperationInput.add_member(:boolean, ::Smithy::Schema::Shapes::MemberShape.new(target: Boolean, name: "boolean"))
    OperationInput.add_member(:string, ::Smithy::Schema::Shapes::MemberShape.new(target: String, name: "string"))
    OperationInput.add_member(:byte, ::Smithy::Schema::Shapes::MemberShape.new(target: Byte, name: "byte"))
    OperationInput.add_member(:short, ::Smithy::Schema::Shapes::MemberShape.new(target: Short, name: "short"))
    OperationInput.add_member(:integer, ::Smithy::Schema::Shapes::MemberShape.new(target: Integer, name: "integer"))
    OperationInput.add_member(:long, ::Smithy::Schema::Shapes::MemberShape.new(target: Long, name: "long"))
    OperationInput.add_member(:float, ::Smithy::Schema::Shapes::MemberShape.new(target: Float, name: "float"))
    OperationInput.add_member(:double, ::Smithy::Schema::Shapes::MemberShape.new(target: Double, name: "double"))
    OperationInput.add_member(:big_integer, ::Smithy::Schema::Shapes::MemberShape.new(target: BigInteger, name: "bigInteger"))
    OperationInput.add_member(:big_decimal, ::Smithy::Schema::Shapes::MemberShape.new(target: BigDecimal, name: "bigDecimal"))
    OperationInput.add_member(:timestamp, ::Smithy::Schema::Shapes::MemberShape.new(target: Timestamp, name: "timestamp"))
    OperationInput.add_member(:document, ::Smithy::Schema::Shapes::MemberShape.new(target: Document, name: "document"))
    OperationInput.add_member(:enum, ::Smithy::Schema::Shapes::MemberShape.new(target: Enum, name: "enum"))
    OperationInput.add_member(:int_enum, ::Smithy::Schema::Shapes::MemberShape.new(target: IntEnum, name: "intEnum"))
    OperationInput.add_member(:list, ::Smithy::Schema::Shapes::MemberShape.new(target: List, name: "list"))
    OperationInput.add_member(:map, ::Smithy::Schema::Shapes::MemberShape.new(target: Map, name: "map"))
    OperationInput.add_member(:structure, ::Smithy::Schema::Shapes::MemberShape.new(target: Structure, name: "structure"))
    OperationInput.add_member(:union, ::Smithy::Schema::Shapes::MemberShape.new(target: Union, name: "union"))
    OperationInput.type = Types::OperationInput
    OperationOutput.add_member(:blob, ::Smithy::Schema::Shapes::MemberShape.new(target: Blob, name: "blob"))
    OperationOutput.add_member(:boolean, ::Smithy::Schema::Shapes::MemberShape.new(target: Boolean, name: "boolean"))
    OperationOutput.add_member(:string, ::Smithy::Schema::Shapes::MemberShape.new(target: String, name: "string"))
    OperationOutput.add_member(:byte, ::Smithy::Schema::Shapes::MemberShape.new(target: Byte, name: "byte"))
    OperationOutput.add_member(:short, ::Smithy::Schema::Shapes::MemberShape.new(target: Short, name: "short"))
    OperationOutput.add_member(:integer, ::Smithy::Schema::Shapes::MemberShape.new(target: Integer, name: "integer"))
    OperationOutput.add_member(:long, ::Smithy::Schema::Shapes::MemberShape.new(target: Long, name: "long"))
    OperationOutput.add_member(:float, ::Smithy::Schema::Shapes::MemberShape.new(target: Float, name: "float"))
    OperationOutput.add_member(:double, ::Smithy::Schema::Shapes::MemberShape.new(target: Double, name: "double"))
    OperationOutput.add_member(:big_integer, ::Smithy::Schema::Shapes::MemberShape.new(target: BigInteger, name: "bigInteger"))
    OperationOutput.add_member(:big_decimal, ::Smithy::Schema::Shapes::MemberShape.new(target: BigDecimal, name: "bigDecimal"))
    OperationOutput.add_member(:timestamp, ::Smithy::Schema::Shapes::MemberShape.new(target: Timestamp, name: "timestamp"))
    OperationOutput.add_member(:document, ::Smithy::Schema::Shapes::MemberShape.new(target: Document, name: "document"))
    OperationOutput.add_member(:enum, ::Smithy::Schema::Shapes::MemberShape.new(target: Enum, name: "enum"))
    OperationOutput.add_member(:int_enum, ::Smithy::Schema::Shapes::MemberShape.new(target: IntEnum, name: "intEnum"))
    OperationOutput.add_member(:list, ::Smithy::Schema::Shapes::MemberShape.new(target: List, name: "list"))
    OperationOutput.add_member(:map, ::Smithy::Schema::Shapes::MemberShape.new(target: Map, name: "map"))
    OperationOutput.add_member(:structure, ::Smithy::Schema::Shapes::MemberShape.new(target: Structure, name: "structure"))
    OperationOutput.add_member(:union, ::Smithy::Schema::Shapes::MemberShape.new(target: Union, name: "union"))
    OperationOutput.type = Types::OperationOutput
    Structure.add_member(:member, ::Smithy::Schema::Shapes::MemberShape.new(target: String, name: "member", traits: {"smithy.ruby.tests#shape" => {}}))
    Structure.type = Types::Structure
    Union.add_member(:string, Types::Union::String, ::Smithy::Schema::Shapes::MemberShape.new(target: String, name: "string", traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:structure, Types::Union::Structure, ::Smithy::Schema::Shapes::MemberShape.new(target: Structure, name: "structure", traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:unit, Types::Union::Unit, ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::Unit, name: "unit", traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:unknown, Types::Union::Unknown, ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::Unit))
    Union.type = Types::Union

    ShapeService = ::Smithy::Schema::Shapes::ServiceShape.new do |service|
      service.id = "smithy.ruby.tests#ShapeService"
      service.name = "ShapeService"
      service.version = "2018-10-31"
      service.traits = {"smithy.ruby.tests#shape" => {}}
      service.add_operation(:operation, ::Smithy::Schema::Shapes::OperationShape.new do |operation|
        operation.id = "smithy.ruby.tests#Operation"
        operation.name = "Operation"
        operation.input = OperationInput
        operation.output = OperationOutput
        operation.traits = {"smithy.ruby.tests#shape" => {}}
      end)
    end

    class << self
      def type_registry
        return @type_registry if @type_registry

        shapes = constants.map { |sym| const_get(sym) }.select { |const| const.is_a?(::Smithy::Schema::Shapes::StructureShape) }
        @type_registry = ::Smithy::Schema::TypeRegistry.new(shapes)
      end
    end
  end
end
