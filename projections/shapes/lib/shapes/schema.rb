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

    Enum.add_member(:foo, ShapeRef.new(shape: Prelude::Unit, location_name: 'FOO', traits: {"smithy.api#enumValue" => "bar"}))
    IntEnum.add_member(:baz, ShapeRef.new(shape: Prelude::Unit, location_name: 'BAZ', traits: {"smithy.api#enumValue" => 1}))
    List.member = ShapeRef.new(shape: String, traits: {"smithy.ruby.tests#shape" => {}})
    Map.key = ShapeRef.new(shape: String, traits: {"smithy.ruby.tests#shape" => {}})
    Map.value = ShapeRef.new(shape: String, traits: {"smithy.ruby.tests#shape" => {}})
    OperationInputOutput.add_member(:blob, ShapeRef.new(shape: Blob, location_name: 'blob'))
    OperationInputOutput.add_member(:boolean, ShapeRef.new(shape: Boolean, location_name: 'boolean'))
    OperationInputOutput.add_member(:string, ShapeRef.new(shape: String, location_name: 'string'))
    OperationInputOutput.add_member(:byte, ShapeRef.new(shape: Byte, location_name: 'byte'))
    OperationInputOutput.add_member(:short, ShapeRef.new(shape: Short, location_name: 'short'))
    OperationInputOutput.add_member(:integer, ShapeRef.new(shape: Integer, location_name: 'integer'))
    OperationInputOutput.add_member(:long, ShapeRef.new(shape: Long, location_name: 'long'))
    OperationInputOutput.add_member(:float, ShapeRef.new(shape: Float, location_name: 'float'))
    OperationInputOutput.add_member(:double, ShapeRef.new(shape: Double, location_name: 'double'))
    OperationInputOutput.add_member(:big_integer, ShapeRef.new(shape: BigInteger, location_name: 'bigInteger'))
    OperationInputOutput.add_member(:big_decimal, ShapeRef.new(shape: BigDecimal, location_name: 'bigDecimal'))
    OperationInputOutput.add_member(:timestamp, ShapeRef.new(shape: Timestamp, location_name: 'timestamp'))
    OperationInputOutput.add_member(:document, ShapeRef.new(shape: Document, location_name: 'document'))
    OperationInputOutput.add_member(:enum, ShapeRef.new(shape: Enum, location_name: 'enum'))
    OperationInputOutput.add_member(:int_enum, ShapeRef.new(shape: IntEnum, location_name: 'intEnum'))
    OperationInputOutput.add_member(:list, ShapeRef.new(shape: List, location_name: 'list'))
    OperationInputOutput.add_member(:map, ShapeRef.new(shape: Map, location_name: 'map'))
    OperationInputOutput.add_member(:structure, ShapeRef.new(shape: Structure, location_name: 'structure'))
    OperationInputOutput.add_member(:union, ShapeRef.new(shape: Union, location_name: 'union'))
    OperationInputOutput.type = Types::OperationInputOutput
    Structure.add_member(:member, ShapeRef.new(shape: String, location_name: 'member', traits: {"smithy.ruby.tests#shape" => {}}))
    Structure.type = Types::Structure
    Union.add_member(:string, Types::Union::String, ShapeRef.new(shape: String, location_name: 'string', traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:structure, Types::Union::Structure, ShapeRef.new(shape: Structure, location_name: 'structure', traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:unit, Types::Union::Unit, ShapeRef.new(shape: Prelude::Unit, location_name: 'unit', traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:unknown, Types::Union::Unknown, ShapeRef.new(shape: Prelude::Unit))
    Union.type = Types::Union

    ShapeService = ServiceShape.new do |service|
      service.id = "smithy.ruby.tests#ShapeService"
      service.name = "ShapeService"
      service.version = "2018-10-31"
      service.traits = {"smithy.ruby.tests#shape" => {}}
      service.add_operation(:operation, OperationShape.new do |operation|
        operation.id = "smithy.ruby.tests#Operation"
        operation.name = "Operation"
        operation.input = ShapeRef.new(shape: OperationInputOutput)
        operation.output = ShapeRef.new(shape: OperationInputOutput)
        # TODO: support parsing errors defined at the service level
        operation.traits = {"smithy.ruby.tests#shape" => {}}
      end)
    end
  end
end
