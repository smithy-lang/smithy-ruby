# frozen_string_literal: true

# This is generated code!

module ShapeService
  # This module contains a schema composed of shapes used by the client.
  module Schema
    include Smithy::Schema::Shapes

    BigDecimal = BigDecimalShape.new(id: 'smithy.ruby.tests#BigDecimal', traits: {"smithy.ruby.tests#shape" => {}})
    BigInteger = IntegerShape.new(id: 'smithy.ruby.tests#BigInteger', traits: {"smithy.ruby.tests#shape" => {}})
    Blob = BlobShape.new(id: 'smithy.ruby.tests#Blob', traits: {"smithy.ruby.tests#shape" => {}})
    Boolean = BooleanShape.new(id: 'smithy.ruby.tests#Boolean', traits: {"smithy.ruby.tests#shape" => {}})
    Byte = IntegerShape.new(id: 'smithy.ruby.tests#Byte', traits: {"smithy.ruby.tests#shape" => {}})
    Document = DocumentShape.new(id: 'smithy.ruby.tests#Document', traits: {"smithy.ruby.tests#shape" => {}})
    Double = FloatShape.new(id: 'smithy.ruby.tests#Double', traits: {"smithy.ruby.tests#shape" => {}})
    Enum = EnumShape.new(id: 'smithy.ruby.tests#Enum', traits: {"smithy.ruby.tests#shape" => {}})
    Float = FloatShape.new(id: 'smithy.ruby.tests#Float', traits: {"smithy.ruby.tests#shape" => {}})
    IntEnum = IntEnumShape.new(id: 'smithy.ruby.tests#IntEnum', traits: {"smithy.ruby.tests#shape" => {}})
    Integer = IntegerShape.new(id: 'smithy.ruby.tests#Integer', traits: {"smithy.ruby.tests#shape" => {}})
    List = ListShape.new(id: 'smithy.ruby.tests#List', traits: {"smithy.ruby.tests#shape" => {}})
    Long = IntegerShape.new(id: 'smithy.ruby.tests#Long', traits: {"smithy.ruby.tests#shape" => {}})
    Map = MapShape.new(id: 'smithy.ruby.tests#Map', traits: {"smithy.ruby.tests#shape" => {}})
    OperationInputOutput = StructureShape.new(id: 'smithy.ruby.tests#OperationInputOutput')
    Short = IntegerShape.new(id: 'smithy.ruby.tests#Short', traits: {"smithy.ruby.tests#shape" => {}})
    String = StringShape.new(id: 'smithy.ruby.tests#String', traits: {"smithy.ruby.tests#shape" => {}})
    Structure = StructureShape.new(id: 'smithy.ruby.tests#Structure', traits: {"smithy.ruby.tests#shape" => {}})
    Timestamp = TimestampShape.new(id: 'smithy.ruby.tests#Timestamp', traits: {"smithy.ruby.tests#shape" => {}})
    Union = UnionShape.new(id: 'smithy.ruby.tests#Union', traits: {"smithy.ruby.tests#shape" => {}})

    Enum.add_member(:foo, 'FOO', ShapeRef.new(target: Prelude::Unit, traits: {"smithy.api#enumValue" => "bar"}))
    IntEnum.add_member(:baz, 'BAZ', ShapeRef.new(target: Prelude::Unit, traits: {"smithy.api#enumValue" => 1}))
    List.member = ShapeRef.new(target: String, traits: {"smithy.ruby.tests#shape" => {}})
    Map.key = ShapeRef.new(target: String, traits: {"smithy.ruby.tests#shape" => {}})
    Map.value = ShapeRef.new(target: String, traits: {"smithy.ruby.tests#shape" => {}})
    OperationInputOutput.add_member(:blob, 'blob', ShapeRef.new(target: Blob))
    OperationInputOutput.add_member(:boolean, 'boolean', ShapeRef.new(target: Boolean))
    OperationInputOutput.add_member(:string, 'string', ShapeRef.new(target: String))
    OperationInputOutput.add_member(:byte, 'byte', ShapeRef.new(target: Byte))
    OperationInputOutput.add_member(:short, 'short', ShapeRef.new(target: Short))
    OperationInputOutput.add_member(:integer, 'integer', ShapeRef.new(target: Integer))
    OperationInputOutput.add_member(:long, 'long', ShapeRef.new(target: Long))
    OperationInputOutput.add_member(:float, 'float', ShapeRef.new(target: Float))
    OperationInputOutput.add_member(:double, 'double', ShapeRef.new(target: Double))
    OperationInputOutput.add_member(:big_integer, 'bigInteger', ShapeRef.new(target: BigInteger))
    OperationInputOutput.add_member(:big_decimal, 'bigDecimal', ShapeRef.new(target: BigDecimal))
    OperationInputOutput.add_member(:timestamp, 'timestamp', ShapeRef.new(target: Timestamp))
    OperationInputOutput.add_member(:document, 'document', ShapeRef.new(target: Document))
    OperationInputOutput.add_member(:enum, 'enum', ShapeRef.new(target: Enum))
    OperationInputOutput.add_member(:int_enum, 'intEnum', ShapeRef.new(target: IntEnum))
    OperationInputOutput.add_member(:list, 'list', ShapeRef.new(target: List))
    OperationInputOutput.add_member(:map, 'map', ShapeRef.new(target: Map))
    OperationInputOutput.add_member(:structure, 'structure', ShapeRef.new(target: Structure))
    OperationInputOutput.add_member(:union, 'union', ShapeRef.new(target: Union))
    OperationInputOutput.type = Types::OperationInputOutput
    Structure.add_member(:member, 'member', ShapeRef.new(target: String, traits: {"smithy.ruby.tests#shape" => {}}))
    Structure.type = Types::Structure
    Union.add_member(:string, 'string', Types::Union::String, ShapeRef.new(target: String, traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:structure, 'structure', Types::Union::Structure, ShapeRef.new(target: Structure, traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:unit, 'unit', Types::Union::Unit, ShapeRef.new(target: Prelude::Unit, traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:unknown, 'unknown', Prelude::Unit, Types::Union::Unknown)
    Union.type = Types::Union

    SERVICE = ServiceShape.new do |service|
      service.id = "smithy.ruby.tests#ShapeService"
      service.name = "ShapeService"
      service.version = "2018-10-31"
      service.traits = {"smithy.ruby.tests#shape" => {}}
      service.add_operation(:operation, OperationShape.new do |operation|
        operation.id = "smithy.ruby.tests#Operation"
        operation.name = "Operation"
        operation.input = ShapeRef.new(target: OperationInputOutput)
        operation.output = ShapeRef.new(target: OperationInputOutput)
        operation.traits = {"smithy.ruby.tests#shape" => {}}
      end)
    end
  end
end
