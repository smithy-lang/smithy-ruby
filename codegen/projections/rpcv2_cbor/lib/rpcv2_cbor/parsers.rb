# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Rpcv2Cbor
  # @api private
  module Parsers

    class BlobList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class BooleanList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    # Error Parser for ComplexError
    class ComplexError
      def self.parse(http_resp)
        data = Types::ComplexError.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.top_level = map['TopLevel']
        data.nested = (ComplexNestedErrorData.parse(map['Nested']) unless map['Nested'].nil?)
        data
      end
    end

    class ComplexNestedErrorData
      def self.parse(map)
        data = Types::ComplexNestedErrorData.new
        data.foo = map['Foo']
        return data
      end
    end

    class DenseBooleanMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseNumberMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseSetMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = StringSet.parse(value) unless value.nil?
        end
        data
      end
    end

    class DenseStringMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseStructMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = GreetingStruct.parse(value) unless value.nil?
        end
        data
      end
    end

    class EmptyInputOutput
      def self.parse(http_resp)
        data = Types::EmptyInputOutputOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data
      end
    end

    class FooEnumList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class FractionalSeconds
      def self.parse(http_resp)
        data = Types::FractionalSecondsOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.datetime = map['datetime']
        data
      end
    end

    class GreetingStruct
      def self.parse(map)
        data = Types::GreetingStruct.new
        data.hi = map['hi']
        return data
      end
    end

    class GreetingWithErrors
      def self.parse(http_resp)
        data = Types::GreetingWithErrorsOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.greeting = map['greeting']
        data
      end
    end

    class IntegerEnumList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class IntegerList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    # Error Parser for InvalidGreeting
    class InvalidGreeting
      def self.parse(http_resp)
        data = Types::InvalidGreeting.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.message = map['Message']
        data
      end
    end

    class NestedStringList
      def self.parse(list)
        list.map do |value|
          StringList.parse(value) unless value.nil?
        end
      end
    end

    class NoInputOutput
      def self.parse(http_resp)
        data = Types::NoInputOutputOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data
      end
    end

    class OperationWithDefaults
      def self.parse(http_resp)
        data = Types::OperationWithDefaultsOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.default_string = map['defaultString']
        data.default_boolean = map['defaultBoolean']
        data.default_list = (TestStringList.parse(map['defaultList']) unless map['defaultList'].nil?)
        data.default_timestamp = map['defaultTimestamp']
        data.default_blob = map['defaultBlob']
        data.default_byte = map['defaultByte']
        data.default_short = map['defaultShort']
        data.default_integer = map['defaultInteger']
        data.default_long = map['defaultLong']
        data.default_float = map['defaultFloat']
        data.default_double = map['defaultDouble']
        data.default_map = (TestStringMap.parse(map['defaultMap']) unless map['defaultMap'].nil?)
        data.default_enum = map['defaultEnum']
        data.default_int_enum = map['defaultIntEnum']
        data.empty_string = map['emptyString']
        data.false_boolean = map['falseBoolean']
        data.empty_blob = map['emptyBlob']
        data.zero_byte = map['zeroByte']
        data.zero_short = map['zeroShort']
        data.zero_integer = map['zeroInteger']
        data.zero_long = map['zeroLong']
        data.zero_float = map['zeroFloat']
        data.zero_double = map['zeroDouble']
        data
      end
    end

    class OptionalInputOutput
      def self.parse(http_resp)
        data = Types::OptionalInputOutputOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.value = map['value']
        data
      end
    end

    class RecursiveShapes
      def self.parse(http_resp)
        data = Types::RecursiveShapesOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.nested = (RecursiveShapesInputOutputNested1.parse(map['nested']) unless map['nested'].nil?)
        data
      end
    end

    class RecursiveShapesInputOutputNested1
      def self.parse(map)
        data = Types::RecursiveShapesInputOutputNested1.new
        data.foo = map['foo']
        data.nested = (RecursiveShapesInputOutputNested2.parse(map['nested']) unless map['nested'].nil?)
        return data
      end
    end

    class RecursiveShapesInputOutputNested2
      def self.parse(map)
        data = Types::RecursiveShapesInputOutputNested2.new
        data.bar = map['bar']
        data.recursive_member = (RecursiveShapesInputOutputNested1.parse(map['recursiveMember']) unless map['recursiveMember'].nil?)
        return data
      end
    end

    class RpcV2CborDenseMaps
      def self.parse(http_resp)
        data = Types::RpcV2CborDenseMapsOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.dense_struct_map = (DenseStructMap.parse(map['denseStructMap']) unless map['denseStructMap'].nil?)
        data.dense_number_map = (DenseNumberMap.parse(map['denseNumberMap']) unless map['denseNumberMap'].nil?)
        data.dense_boolean_map = (DenseBooleanMap.parse(map['denseBooleanMap']) unless map['denseBooleanMap'].nil?)
        data.dense_string_map = (DenseStringMap.parse(map['denseStringMap']) unless map['denseStringMap'].nil?)
        data.dense_set_map = (DenseSetMap.parse(map['denseSetMap']) unless map['denseSetMap'].nil?)
        data
      end
    end

    class RpcV2CborLists
      def self.parse(http_resp)
        data = Types::RpcV2CborListsOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.string_list = (StringList.parse(map['stringList']) unless map['stringList'].nil?)
        data.string_set = (StringSet.parse(map['stringSet']) unless map['stringSet'].nil?)
        data.integer_list = (IntegerList.parse(map['integerList']) unless map['integerList'].nil?)
        data.boolean_list = (BooleanList.parse(map['booleanList']) unless map['booleanList'].nil?)
        data.timestamp_list = (TimestampList.parse(map['timestampList']) unless map['timestampList'].nil?)
        data.enum_list = (FooEnumList.parse(map['enumList']) unless map['enumList'].nil?)
        data.int_enum_list = (IntegerEnumList.parse(map['intEnumList']) unless map['intEnumList'].nil?)
        data.nested_string_list = (NestedStringList.parse(map['nestedStringList']) unless map['nestedStringList'].nil?)
        data.structure_list = (StructureList.parse(map['structureList']) unless map['structureList'].nil?)
        data.blob_list = (BlobList.parse(map['blobList']) unless map['blobList'].nil?)
        data
      end
    end

    class RpcV2CborSparseMaps
      def self.parse(http_resp)
        data = Types::RpcV2CborSparseMapsOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.sparse_struct_map = (SparseStructMap.parse(map['sparseStructMap']) unless map['sparseStructMap'].nil?)
        data.sparse_number_map = (SparseNumberMap.parse(map['sparseNumberMap']) unless map['sparseNumberMap'].nil?)
        data.sparse_boolean_map = (SparseBooleanMap.parse(map['sparseBooleanMap']) unless map['sparseBooleanMap'].nil?)
        data.sparse_string_map = (SparseStringMap.parse(map['sparseStringMap']) unless map['sparseStringMap'].nil?)
        data.sparse_set_map = (SparseSetMap.parse(map['sparseSetMap']) unless map['sparseSetMap'].nil?)
        data
      end
    end

    class SimpleScalarProperties
      def self.parse(http_resp)
        data = Types::SimpleScalarPropertiesOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.true_boolean_value = map['trueBooleanValue']
        data.false_boolean_value = map['falseBooleanValue']
        data.byte_value = map['byteValue']
        data.double_value = map['doubleValue']
        data.float_value = map['floatValue']
        data.integer_value = map['integerValue']
        data.long_value = map['longValue']
        data.short_value = map['shortValue']
        data.string_value = map['stringValue']
        data.blob_value = map['blobValue']
        data
      end
    end

    class SparseBooleanMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseNullsOperation
      def self.parse(http_resp)
        data = Types::SparseNullsOperationOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.sparse_string_list = (SparseStringList.parse(map['sparseStringList']) unless map['sparseStringList'].nil?)
        data.sparse_string_map = (SparseStringMap.parse(map['sparseStringMap']) unless map['sparseStringMap'].nil?)
        data
      end
    end

    class SparseNumberMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseSetMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = (StringSet.parse(value) unless value.nil?)
        end
        data
      end
    end

    class SparseStringList
      def self.parse(list)
        list.map do |value|
          value
        end
      end
    end

    class SparseStringMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseStructMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = (GreetingStruct.parse(value) unless value.nil?)
        end
        data
      end
    end

    class StringList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class StringSet
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class StructureList
      def self.parse(list)
        list.map do |value|
          StructureListMember.parse(value) unless value.nil?
        end
      end
    end

    class StructureListMember
      def self.parse(map)
        data = Types::StructureListMember.new
        data.a = map['a']
        data.b = map['b']
        return data
      end
    end

    class TestStringList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class TestStringMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class TimestampList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    # Error Parser for ValidationException
    class ValidationException
      def self.parse(http_resp)
        data = Types::ValidationException.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.message = map['message']
        data.field_list = (ValidationExceptionFieldList.parse(map['fieldList']) unless map['fieldList'].nil?)
        data
      end
    end

    class ValidationExceptionField
      def self.parse(map)
        data = Types::ValidationExceptionField.new
        data.path = map['path']
        data.message = map['message']
        return data
      end
    end

    class ValidationExceptionFieldList
      def self.parse(list)
        list.map do |value|
          ValidationExceptionField.parse(value) unless value.nil?
        end
      end
    end
  end
end
