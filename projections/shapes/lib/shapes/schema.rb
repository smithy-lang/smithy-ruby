# frozen_string_literal: true

# This is generated code!

module ShapeService
  # This module contains a schema composed of shapes used by the client.
  module Schema

    BigDecimal = ::Smithy::Schema::Shapes::BigDecimalShape.new(id: 'smithy.ruby.tests#BigDecimal', name: 'BigDecimal', traits: {"smithy.ruby.tests#shape" => {}})
    BigInteger = ::Smithy::Schema::Shapes::IntegerShape.new(id: 'smithy.ruby.tests#BigInteger', name: 'BigInteger', traits: {"smithy.ruby.tests#shape" => {}})
    Blob = ::Smithy::Schema::Shapes::BlobShape.new(id: 'smithy.ruby.tests#Blob', name: 'Blob', traits: {"smithy.ruby.tests#shape" => {}})
    Boolean = ::Smithy::Schema::Shapes::BooleanShape.new(id: 'smithy.ruby.tests#Boolean', name: 'Boolean', traits: {"smithy.ruby.tests#shape" => {}})
    Byte = ::Smithy::Schema::Shapes::IntegerShape.new(id: 'smithy.ruby.tests#Byte', name: 'Byte', traits: {"smithy.ruby.tests#shape" => {}})
    Document = ::Smithy::Schema::Shapes::DocumentShape.new(id: 'smithy.ruby.tests#Document', name: 'Document', traits: {"smithy.ruby.tests#shape" => {}})
    Double = ::Smithy::Schema::Shapes::FloatShape.new(id: 'smithy.ruby.tests#Double', name: 'Double', traits: {"smithy.ruby.tests#shape" => {}})
    Enum = ::Smithy::Schema::Shapes::EnumShape.new(id: 'smithy.ruby.tests#Enum', name: 'Enum', traits: {"smithy.ruby.tests#shape" => {}})
    Float = ::Smithy::Schema::Shapes::FloatShape.new(id: 'smithy.ruby.tests#Float', name: 'Float', traits: {"smithy.ruby.tests#shape" => {}})
    IntEnum = ::Smithy::Schema::Shapes::IntEnumShape.new(id: 'smithy.ruby.tests#IntEnum', name: 'IntEnum', traits: {"smithy.ruby.tests#shape" => {}})
    Integer = ::Smithy::Schema::Shapes::IntegerShape.new(id: 'smithy.ruby.tests#Integer', name: 'Integer', traits: {"smithy.ruby.tests#shape" => {}})
    List = ::Smithy::Schema::Shapes::ListShape.new(id: 'smithy.ruby.tests#List', name: 'List', traits: {"smithy.ruby.tests#shape" => {}})
    Long = ::Smithy::Schema::Shapes::IntegerShape.new(id: 'smithy.ruby.tests#Long', name: 'Long', traits: {"smithy.ruby.tests#shape" => {}})
    Map = ::Smithy::Schema::Shapes::MapShape.new(id: 'smithy.ruby.tests#Map', name: 'Map', traits: {"smithy.ruby.tests#shape" => {}})
    OperationInput = ::Smithy::Schema::Shapes::StructureShape.new(id: 'smithy.ruby.tests#OperationInput', name: 'OperationInput')
    OperationOutput = ::Smithy::Schema::Shapes::StructureShape.new(id: 'smithy.ruby.tests#OperationOutput', name: 'OperationOutput')
    Short = ::Smithy::Schema::Shapes::IntegerShape.new(id: 'smithy.ruby.tests#Short', name: 'Short', traits: {"smithy.ruby.tests#shape" => {}})
    String = ::Smithy::Schema::Shapes::StringShape.new(id: 'smithy.ruby.tests#String', name: 'String', traits: {"smithy.ruby.tests#shape" => {}})
    Structure = ::Smithy::Schema::Shapes::StructureShape.new(id: 'smithy.ruby.tests#Structure', name: 'Structure', traits: {"smithy.ruby.tests#shape" => {}})
    Timestamp = ::Smithy::Schema::Shapes::TimestampShape.new(id: 'smithy.ruby.tests#Timestamp', name: 'Timestamp', traits: {"smithy.ruby.tests#shape" => {}})
    Union = ::Smithy::Schema::Shapes::UnionShape.new(id: 'smithy.ruby.tests#Union', name: 'Union', traits: {"smithy.ruby.tests#shape" => {}})

    Enum.add_member(:foo, ::Smithy::Schema::Shapes::ShapeRef.new(shape: ::Smithy::Schema::Shapes::Prelude::Unit, location_name: 'FOO', traits: {"smithy.api#enumValue" => "bar"}))
    IntEnum.add_member(:baz, ::Smithy::Schema::Shapes::ShapeRef.new(shape: ::Smithy::Schema::Shapes::Prelude::Unit, location_name: 'BAZ', traits: {"smithy.api#enumValue" => 1}))
    List.member = ::Smithy::Schema::Shapes::ShapeRef.new(shape: String, traits: {"smithy.ruby.tests#shape" => {}})
    Map.key = ::Smithy::Schema::Shapes::ShapeRef.new(shape: String, traits: {"smithy.ruby.tests#shape" => {}})
    Map.value = ::Smithy::Schema::Shapes::ShapeRef.new(shape: String, traits: {"smithy.ruby.tests#shape" => {}})
    OperationInput.add_member(:blob, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Blob, location_name: 'blob'))
    OperationInput.add_member(:boolean, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Boolean, location_name: 'boolean'))
    OperationInput.add_member(:string, ::Smithy::Schema::Shapes::ShapeRef.new(shape: String, location_name: 'string'))
    OperationInput.add_member(:byte, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Byte, location_name: 'byte'))
    OperationInput.add_member(:short, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Short, location_name: 'short'))
    OperationInput.add_member(:integer, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Integer, location_name: 'integer'))
    OperationInput.add_member(:long, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Long, location_name: 'long'))
    OperationInput.add_member(:float, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Float, location_name: 'float'))
    OperationInput.add_member(:double, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Double, location_name: 'double'))
    OperationInput.add_member(:big_integer, ::Smithy::Schema::Shapes::ShapeRef.new(shape: BigInteger, location_name: 'bigInteger'))
    OperationInput.add_member(:big_decimal, ::Smithy::Schema::Shapes::ShapeRef.new(shape: BigDecimal, location_name: 'bigDecimal'))
    OperationInput.add_member(:timestamp, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Timestamp, location_name: 'timestamp'))
    OperationInput.add_member(:document, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Document, location_name: 'document'))
    OperationInput.add_member(:enum, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Enum, location_name: 'enum'))
    OperationInput.add_member(:int_enum, ::Smithy::Schema::Shapes::ShapeRef.new(shape: IntEnum, location_name: 'intEnum'))
    OperationInput.add_member(:list, ::Smithy::Schema::Shapes::ShapeRef.new(shape: List, location_name: 'list'))
    OperationInput.add_member(:map, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Map, location_name: 'map'))
    OperationInput.add_member(:structure, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Structure, location_name: 'structure'))
    OperationInput.add_member(:union, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Union, location_name: 'union'))
    OperationInput.type = Types::OperationInput
    OperationOutput.add_member(:blob, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Blob, location_name: 'blob'))
    OperationOutput.add_member(:boolean, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Boolean, location_name: 'boolean'))
    OperationOutput.add_member(:string, ::Smithy::Schema::Shapes::ShapeRef.new(shape: String, location_name: 'string'))
    OperationOutput.add_member(:byte, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Byte, location_name: 'byte'))
    OperationOutput.add_member(:short, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Short, location_name: 'short'))
    OperationOutput.add_member(:integer, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Integer, location_name: 'integer'))
    OperationOutput.add_member(:long, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Long, location_name: 'long'))
    OperationOutput.add_member(:float, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Float, location_name: 'float'))
    OperationOutput.add_member(:double, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Double, location_name: 'double'))
    OperationOutput.add_member(:big_integer, ::Smithy::Schema::Shapes::ShapeRef.new(shape: BigInteger, location_name: 'bigInteger'))
    OperationOutput.add_member(:big_decimal, ::Smithy::Schema::Shapes::ShapeRef.new(shape: BigDecimal, location_name: 'bigDecimal'))
    OperationOutput.add_member(:timestamp, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Timestamp, location_name: 'timestamp'))
    OperationOutput.add_member(:document, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Document, location_name: 'document'))
    OperationOutput.add_member(:enum, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Enum, location_name: 'enum'))
    OperationOutput.add_member(:int_enum, ::Smithy::Schema::Shapes::ShapeRef.new(shape: IntEnum, location_name: 'intEnum'))
    OperationOutput.add_member(:list, ::Smithy::Schema::Shapes::ShapeRef.new(shape: List, location_name: 'list'))
    OperationOutput.add_member(:map, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Map, location_name: 'map'))
    OperationOutput.add_member(:structure, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Structure, location_name: 'structure'))
    OperationOutput.add_member(:union, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Union, location_name: 'union'))
    OperationOutput.type = Types::OperationOutput
    Structure.add_member(:member, ::Smithy::Schema::Shapes::ShapeRef.new(shape: String, location_name: 'member', traits: {"smithy.ruby.tests#shape" => {}}))
    Structure.type = Types::Structure
    Union.add_member(:string, Types::Union::String, ::Smithy::Schema::Shapes::ShapeRef.new(shape: String, location_name: 'string', traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:structure, Types::Union::Structure, ::Smithy::Schema::Shapes::ShapeRef.new(shape: Structure, location_name: 'structure', traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:unit, Types::Union::Unit, ::Smithy::Schema::Shapes::ShapeRef.new(shape: ::Smithy::Schema::Shapes::Prelude::Unit, location_name: 'unit', traits: {"smithy.ruby.tests#shape" => {}}))
    Union.add_member(:unknown, Types::Union::Unknown, ::Smithy::Schema::Shapes::ShapeRef.new(shape: ::Smithy::Schema::Shapes::Prelude::Unit))
    Union.type = Types::Union

    ShapeService = ::Smithy::Schema::Shapes::ServiceShape.new do |service|
      service.id = "smithy.ruby.tests#ShapeService"
      service.name = "ShapeService"
      service.version = "2018-10-31"
      service.traits = {"smithy.ruby.tests#shape" => {}}
      service.add_operation(:operation, ::Smithy::Schema::Shapes::OperationShape.new do |operation|
        operation.id = "smithy.ruby.tests#Operation"
        operation.name = "Operation"
        operation.input = ::Smithy::Schema::Shapes::ShapeRef.new(shape: OperationInput)
        operation.output = ::Smithy::Schema::Shapes::ShapeRef.new(shape: OperationOutput)
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
