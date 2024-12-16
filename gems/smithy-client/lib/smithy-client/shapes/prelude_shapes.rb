# frozen_string_literal: true

module Smithy
  module Client
    module Shapes
      module PreludeShapes
        String = StringShape.new(shape_id: 'smithy.api#String')
        Blob = BlobShape.new(shape_id: 'smithy.api#Blob')
        Boolean = BooleanShape.new(shape_id: 'smithy.api#Boolean')
        BigInteger = IntegerShape.new(shape_id: 'smithy.api#BigInteger')
        BigDecimal = BigDecimal.new(shape_id: 'smithy.api#BigDecimal')
        Byte = IntegerShape.new(shape_id: 'smithy.api#Byte')
        Timestamp = TimestampShape.new(shape_id: 'smithy.api#Timestamp')
        Document = DocumentShape.new(shape_id: 'smithy.api#Document')
        Short = IntegerShape.new(shape_id: 'smithy.api#Short')
        Integer = IntegerShape.new(shape_id: 'smithy.api#Integer')
        Long = IntegerShape.new(shape_id: 'smithy.api#Long')
        Float = FloatShape.new(shape_id: 'smithy.api#Float')
        Double = FloatShape.new(shape_id: 'smithy.api#Double')
        PrimitiveBoolean = BooleanShape.new(
          shape_id: 'smithy.api#PrimitiveBoolean',
          traits: { 'smithy.api#default' => false }
        )
        PrimitiveByte = IntegerShape.new(
          shape_id: 'smithy.api#PrimitiveByte',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveShort = IntegerShape.new(
          shape_id: 'smithy.api#PrimitiveShort',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveInteger = IntegerShape.new(
          shape_id: 'smithy.api#PrimitiveInteger',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveLong = IntegerShape.new(
          shape_id: 'smithy.api#PrimitiveLong',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveFloat = FloatShape.new(
          shape_id: 'smithy.api#PrimitiveFloat',
          traits: { 'smithy.api#default' => 0 }
        )
        PrimitiveDouble = FloatShape.new(
          shape_id: 'smithy.api#PrimitiveDouble',
          traits: { 'smithy.api#default' => 0 }
        )
        Unit = StructureShape.new(
          shape_id: 'smithy.api#Unit',
          traits: { 'smithy.api#unitType'=>{} }
        )
      end
    end
  end
end
