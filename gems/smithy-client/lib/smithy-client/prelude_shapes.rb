# frozen_string_literal: true

module Smithy
  module Client
    module PreludeShapes
      String = Shapes::StringShape.new(shape_id: 'smithy.api#String')
      Blob = Shapes::BlobShape.new(shape_id: 'smithy.api#Blob')
      Boolean = Shapes::BooleanShape.new(shape_id: 'smithy.api#Boolean')
      BigInteger = Shapes::IntegerShape.new(shape_id: 'smithy.api#BigInteger')
      BigDecimal = Shapes::BigDecimal.new(shape_id: 'smithy.api#BigDecimal')
      Timestamp = Shapes::TimestampShape.new(shape_id: 'smithy.api#Timestamp')
      Document = Shapes::DocumentShape.new(shape_id: 'smithy.api#Document')
      Short = Shapes::IntegerShape.new(shape_id: 'smithy.api#Short')
      Integer = Shapes::IntegerShape.new(shape_id: 'smithy.api#Integer')
      Long = Shapes::IntegerShape.new(shape_id: 'smithy.api#Long')
      Float = Shapes::FloatShape.new(shape_id: 'smithy.api#Float')
      Double = Shapes::FloatShape.new(shape_id: 'smithy.api#Double')

      PrimitiveBoolean =
        Shapes::BooleanShape.new(shape_id: 'smithy.api#PrimitiveBoolean')
      PrimitiveShort =
        Shapes::IntegerShape.new(shape_id: 'smithy.api#PrimitiveShort')
      PrimitiveInteger =
        Shapes::IntegerShape.new(shape_id: 'smithy.api#PrimitiveInteger')
      PrimitiveLong =
        Shapes::IntegerShape.new(shape_id: 'smithy.api#PrimitiveLong')
      PrimitiveFloat =
        Shapes::FloatShape.new(shape_id: 'smithy.api#PrimitiveFloat')
      PrimitiveDouble =
        Shapes::FloatShape.new(shape_id: 'smithy.api#PrimitiveDouble')

    end
  end
end