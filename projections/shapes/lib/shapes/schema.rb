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

    Enum.add_member(:foo, ShapeRef.new(shape: Prelude::Unit, member_name: 'FOO', traits: {"smithy.api#enumValue" => "bar"}))
    IntEnum.add_member(:baz, ShapeRef.new(shape: Prelude::Unit, member_name: 'BAZ', traits: {"smithy.api#enumValue" => 1}))
    List.member = ShapeRef.new(shape: String, traits: {"smithy.ruby.tests#shape" => {}})
    Map.key = ShapeRef.new(shape: String, traits: {"smithy.ruby.tests#shape" => {}})
    Map.value = ShapeRef.new(shape: String, traits: {"smithy.ruby.tests#shape" => {}})
    OperationInputOutput.add_member(:blob, ShapeRef.new(shape: Blob, member_name: 'blob'))
    OperationInputOutput.add_member(:boolean, ShapeRef.new(shape: Boolean, member_name: 'boolean'))
    OperationInputOutput.add_member(:string, ShapeRef.new(shape: String, member_name: 'string'))
    OperationInputOutput.add_member(:byte, ShapeRef.new(shape: Byte, member_name: 'byte'))
    OperationInputOutput.add_member(:short, ShapeRef.new(shape: Short, member_name: 'short'))
    OperationInputOutput.add_member(:integer, ShapeRef.new(shape: Integer, member_name: 'integer'))
    OperationInputOutput.add_member(:long, ShapeRef.new(shape: Long, member_name: 'long'))
    OperationInputOutput.add_member(:float, ShapeRef.new(shape: Float, member_name: 'float'))
    OperationInputOutput.add_member(:double, ShapeRef.new(shape: Double, member_name: 'double'))
    OperationInputOutput.add_member(:big_integer, ShapeRef.new(shape: BigInteger, member_name: 'bigInteger'))
    OperationInputOutput.add_member(:big_decimal, ShapeRef.new(shape: BigDecimal, member_name: 'bigDecimal'))
    OperationInputOutput.add_member(:timestamp, ShapeRef.new(shape: Timestamp, member_name: 'timestamp'))
    OperationInputOutput.add_member(:document, ShapeRef.new(shape: Document, member_name: 'document'))
    OperationInputOutput.add_member(:enum, ShapeRef.new(shape: Enum, member_name: 'enum'))
    OperationInputOutput.add_member(:int_enum, ShapeRef.new(shape: IntEnum, member_name: 'intEnum'))
    OperationInputOutput.add_member(:list, ShapeRef.new(shape: List, member_name: 'list'))
    OperationInputOutput.add_member(:map, ShapeRef.new(shape: Map, member_name: 'map'))
    OperationInputOutput.add_member(:structure, ShapeRef.new(shape: Structure, member_name: 'structure'))
    OperationInputOutput.add_member(:union, ShapeRef.new(shape: Union, member_name: 'union'))
    OperationInputOutput.type = Types::OperationInputOutput
    Structure.add_member(:member, ShapeRef.new(shape: String, member_name: 'member', traits: {"smithy.ruby.tests#shape" => {}}))
    Structure.type = Types::Structure
    Union.add_member(:string, Types::Union::String, ShapeRef.new(shape: String, member_name: 'string', traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:structure, Types::Union::Structure, ShapeRef.new(shape: Structure, member_name: 'structure', traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:unit, Types::Union::Unit, ShapeRef.new(shape: Prelude::Unit, member_name: 'unit', traits: {"smithy.ruby.tests#shape" => {}}))
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
