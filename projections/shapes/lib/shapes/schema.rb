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

    Enum.add_member(:foo, 'FOO', Prelude::Unit, traits: {"smithy.api#enumValue" => "bar"})

    IntEnum.add_member(:baz, 'BAZ', Prelude::Unit, traits: {"smithy.api#enumValue" => 1})

    List.set_member(String, traits: {"smithy.ruby.tests#shape" => {}})

    Map.set_key(String, traits: {"smithy.ruby.tests#shape" => {}})
    Map.set_value(String, traits: {"smithy.ruby.tests#shape" => {}})

    OperationInputOutput.add_member(:blob, 'blob', Blob)
    OperationInputOutput.add_member(:boolean, 'boolean', Boolean)
    OperationInputOutput.add_member(:string, 'string', String)
    OperationInputOutput.add_member(:byte, 'byte', Byte)
    OperationInputOutput.add_member(:short, 'short', Short)
    OperationInputOutput.add_member(:integer, 'integer', Integer)
    OperationInputOutput.add_member(:long, 'long', Long)
    OperationInputOutput.add_member(:float, 'float', Float)
    OperationInputOutput.add_member(:double, 'double', Double)
    OperationInputOutput.add_member(:big_integer, 'bigInteger', BigInteger)
    OperationInputOutput.add_member(:big_decimal, 'bigDecimal', BigDecimal)
    OperationInputOutput.add_member(:timestamp, 'timestamp', Timestamp)
    OperationInputOutput.add_member(:document, 'document', Document)
    OperationInputOutput.add_member(:enum, 'enum', Enum)
    OperationInputOutput.add_member(:int_enum, 'intEnum', IntEnum)
    OperationInputOutput.add_member(:list, 'list', List)
    OperationInputOutput.add_member(:map, 'map', Map)
    OperationInputOutput.add_member(:structure, 'structure', Structure)
    OperationInputOutput.add_member(:union, 'union', Union)
    OperationInputOutput.type = Types::OperationInputOutput

    Structure.add_member(:member, 'member', String, traits: {"smithy.ruby.tests#shape" => {}})
    Structure.type = Types::Structure

    Union.add_member(:string, 'string', String, Types::Union::String, traits: {"smithy.ruby.tests#shape" => {}})
    Union.add_member(:structure, 'structure', Structure, Types::Union::Structure, traits: {"smithy.ruby.tests#shape" => {}})
    Union.add_member(:unit, 'unit', Prelude::Unit, Types::Union::Unit, traits: {"smithy.ruby.tests#shape" => {}})
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
        operation.input = OperationInputOutput
        operation.output = OperationInputOutput
        operation.traits = {"smithy.ruby.tests#shape" => {}}

      end)
    end
  end
end
