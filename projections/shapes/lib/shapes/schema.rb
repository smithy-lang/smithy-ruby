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

    Enum.add_member(:foo, ShapeRef.new(target: Prelude::Unit, location: 'FOO', traits: {"smithy.api#enumValue" => "bar"}))
    IntEnum.add_member(:baz, ShapeRef.new(target: Prelude::Unit, location: 'BAZ', traits: {"smithy.api#enumValue" => 1}))
    List.member = ShapeRef.new(target: String, traits: {"smithy.ruby.tests#shape" => {}})
    Map.key = ShapeRef.new(target: String, traits: {"smithy.ruby.tests#shape" => {}})
    Map.value = ShapeRef.new(target: String, traits: {"smithy.ruby.tests#shape" => {}})
    OperationInputOutput.add_member(:blob, ShapeRef.new(target: Blob, location: 'blob'))
    OperationInputOutput.add_member(:boolean, ShapeRef.new(target: Boolean, location: 'boolean'))
    OperationInputOutput.add_member(:string, ShapeRef.new(target: String, location: 'string'))
    OperationInputOutput.add_member(:byte, ShapeRef.new(target: Byte, location: 'byte'))
    OperationInputOutput.add_member(:short, ShapeRef.new(target: Short, location: 'short'))
    OperationInputOutput.add_member(:integer, ShapeRef.new(target: Integer, location: 'integer'))
    OperationInputOutput.add_member(:long, ShapeRef.new(target: Long, location: 'long'))
    OperationInputOutput.add_member(:float, ShapeRef.new(target: Float, location: 'float'))
    OperationInputOutput.add_member(:double, ShapeRef.new(target: Double, location: 'double'))
    OperationInputOutput.add_member(:big_integer, ShapeRef.new(target: BigInteger, location: 'bigInteger'))
    OperationInputOutput.add_member(:big_decimal, ShapeRef.new(target: BigDecimal, location: 'bigDecimal'))
    OperationInputOutput.add_member(:timestamp, ShapeRef.new(target: Timestamp, location: 'timestamp'))
    OperationInputOutput.add_member(:document, ShapeRef.new(target: Document, location: 'document'))
    OperationInputOutput.add_member(:enum, ShapeRef.new(target: Enum, location: 'enum'))
    OperationInputOutput.add_member(:int_enum, ShapeRef.new(target: IntEnum, location: 'intEnum'))
    OperationInputOutput.add_member(:list, ShapeRef.new(target: List, location: 'list'))
    OperationInputOutput.add_member(:map, ShapeRef.new(target: Map, location: 'map'))
    OperationInputOutput.add_member(:structure, ShapeRef.new(target: Structure, location: 'structure'))
    OperationInputOutput.add_member(:union, ShapeRef.new(target: Union, location: 'union'))
    OperationInputOutput.type = Types::OperationInputOutput
    Structure.add_member(:member, ShapeRef.new(target: String, location: 'member', traits: {"smithy.ruby.tests#shape" => {}}))
    Structure.type = Types::Structure
    Union.add_member(:string, Types::Union::String, ShapeRef.new(target: String, location: 'string', traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:structure, Types::Union::Structure, ShapeRef.new(target: Structure, location: 'structure', traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:unit, Types::Union::Unit, ShapeRef.new(target: Prelude::Unit, location: 'unit', traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:unknown, Prelude::Unit, ShapeRef.new(target: Types::Union::Unknown))
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
