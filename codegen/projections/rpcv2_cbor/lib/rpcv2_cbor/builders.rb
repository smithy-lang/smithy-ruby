# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'stringio'

module Rpcv2Cbor
  # @api private
  module Builders

    class BlobList
      def self.build(input)
        data = []
        input.each do |element|
          data << ((String === element ? element : element.read).encode(Encoding::BINARY)) unless element.nil?
        end
        data
      end
    end

    class BooleanList
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class ClientOptionalDefaults
      def self.build(input)
        data = {}
        data['member'] = input[:member] unless input[:member].nil?
        data
      end
    end

    class Defaults
      def self.build(input)
        data = {}
        data['defaultString'] = input[:default_string] unless input[:default_string].nil?
        data['defaultBoolean'] = input[:default_boolean] unless input[:default_boolean].nil?
        data['defaultList'] = TestStringList.build(input[:default_list]) unless input[:default_list].nil?
        data['defaultTimestamp'] = input[:default_timestamp] unless input[:default_timestamp].nil?
        data['defaultBlob'] = ((String === input[:default_blob] ? input[:default_blob] : input[:default_blob].read).encode(Encoding::BINARY)) unless input[:default_blob].nil?
        data['defaultByte'] = input[:default_byte] unless input[:default_byte].nil?
        data['defaultShort'] = input[:default_short] unless input[:default_short].nil?
        data['defaultInteger'] = input[:default_integer] unless input[:default_integer].nil?
        data['defaultLong'] = input[:default_long] unless input[:default_long].nil?
        data['defaultFloat'] = input[:default_float] unless input[:default_float].nil?
        data['defaultDouble'] = input[:default_double] unless input[:default_double].nil?
        data['defaultMap'] = TestStringMap.build(input[:default_map]) unless input[:default_map].nil?
        data['defaultEnum'] = input[:default_enum] unless input[:default_enum].nil?
        data['defaultIntEnum'] = input[:default_int_enum] unless input[:default_int_enum].nil?
        data['emptyString'] = input[:empty_string] unless input[:empty_string].nil?
        data['falseBoolean'] = input[:false_boolean] unless input[:false_boolean].nil?
        data['emptyBlob'] = ((String === input[:empty_blob] ? input[:empty_blob] : input[:empty_blob].read).encode(Encoding::BINARY)) unless input[:empty_blob].nil?
        data['zeroByte'] = input[:zero_byte] unless input[:zero_byte].nil?
        data['zeroShort'] = input[:zero_short] unless input[:zero_short].nil?
        data['zeroInteger'] = input[:zero_integer] unless input[:zero_integer].nil?
        data['zeroLong'] = input[:zero_long] unless input[:zero_long].nil?
        data['zeroFloat'] = input[:zero_float] unless input[:zero_float].nil?
        data['zeroDouble'] = input[:zero_double] unless input[:zero_double].nil?
        data
      end
    end

    class DenseBooleanMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseNumberMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseSetMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = StringSet.build(value) unless value.nil?
        end
        data
      end
    end

    class DenseStringMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseStructMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = GreetingStruct.build(value) unless value.nil?
        end
        data
      end
    end

    class EmptyInputOutput
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/RpcV2Protocol/operation/EmptyInputOutput')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        data = {}
        http_req.headers['Content-Type'] = 'application/cbor'
        http_req.body = ::StringIO.new(Hearth::CBOR.encode(data))
      end
    end

    class Float16
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/RpcV2Protocol/operation/Float16')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        data = {}
      end
    end

    class FooEnumList
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class FractionalSeconds
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/RpcV2Protocol/operation/FractionalSeconds')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        data = {}
      end
    end

    class GreetingStruct
      def self.build(input)
        data = {}
        data['hi'] = input[:hi] unless input[:hi].nil?
        data
      end
    end

    class GreetingWithErrors
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/RpcV2Protocol/operation/GreetingWithErrors')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        data = {}
      end
    end

    class IntegerEnumList
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class IntegerList
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class NestedStringList
      def self.build(input)
        data = []
        input.each do |element|
          data << StringList.build(element) unless element.nil?
        end
        data
      end
    end

    class NoInputOutput
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/RpcV2Protocol/operation/NoInputOutput')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        data = {}
      end
    end

    class OperationWithDefaults
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/RpcV2Protocol/operation/OperationWithDefaults')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        data = {}
        data['defaults'] = Defaults.build(input[:defaults]) unless input[:defaults].nil?
        data['clientOptionalDefaults'] = ClientOptionalDefaults.build(input[:client_optional_defaults]) unless input[:client_optional_defaults].nil?
        data['topLevelDefault'] = input[:top_level_default] unless input[:top_level_default].nil?
        data['otherTopLevelDefault'] = input[:other_top_level_default] unless input[:other_top_level_default].nil?
        http_req.headers['Content-Type'] = 'application/cbor'
        http_req.body = ::StringIO.new(Hearth::CBOR.encode(data))
      end
    end

    class OptionalInputOutput
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/RpcV2Protocol/operation/OptionalInputOutput')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        data = {}
        data['value'] = input[:value] unless input[:value].nil?
        http_req.headers['Content-Type'] = 'application/cbor'
        http_req.body = ::StringIO.new(Hearth::CBOR.encode(data))
      end
    end

    class RecursiveShapes
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/RpcV2Protocol/operation/RecursiveShapes')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        data = {}
        data['nested'] = RecursiveShapesInputOutputNested1.build(input[:nested]) unless input[:nested].nil?
        http_req.headers['Content-Type'] = 'application/cbor'
        http_req.body = ::StringIO.new(Hearth::CBOR.encode(data))
      end
    end

    class RecursiveShapesInputOutputNested1
      def self.build(input)
        data = {}
        data['foo'] = input[:foo] unless input[:foo].nil?
        data['nested'] = RecursiveShapesInputOutputNested2.build(input[:nested]) unless input[:nested].nil?
        data
      end
    end

    class RecursiveShapesInputOutputNested2
      def self.build(input)
        data = {}
        data['bar'] = input[:bar] unless input[:bar].nil?
        data['recursiveMember'] = RecursiveShapesInputOutputNested1.build(input[:recursive_member]) unless input[:recursive_member].nil?
        data
      end
    end

    class RpcV2CborDenseMaps
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/RpcV2Protocol/operation/RpcV2CborDenseMaps')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        data = {}
        data['denseStructMap'] = DenseStructMap.build(input[:dense_struct_map]) unless input[:dense_struct_map].nil?
        data['denseNumberMap'] = DenseNumberMap.build(input[:dense_number_map]) unless input[:dense_number_map].nil?
        data['denseBooleanMap'] = DenseBooleanMap.build(input[:dense_boolean_map]) unless input[:dense_boolean_map].nil?
        data['denseStringMap'] = DenseStringMap.build(input[:dense_string_map]) unless input[:dense_string_map].nil?
        data['denseSetMap'] = DenseSetMap.build(input[:dense_set_map]) unless input[:dense_set_map].nil?
        http_req.headers['Content-Type'] = 'application/cbor'
        http_req.body = ::StringIO.new(Hearth::CBOR.encode(data))
      end
    end

    class RpcV2CborLists
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/RpcV2Protocol/operation/RpcV2CborLists')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        data = {}
        data['stringList'] = StringList.build(input[:string_list]) unless input[:string_list].nil?
        data['stringSet'] = StringSet.build(input[:string_set]) unless input[:string_set].nil?
        data['integerList'] = IntegerList.build(input[:integer_list]) unless input[:integer_list].nil?
        data['booleanList'] = BooleanList.build(input[:boolean_list]) unless input[:boolean_list].nil?
        data['timestampList'] = TimestampList.build(input[:timestamp_list]) unless input[:timestamp_list].nil?
        data['enumList'] = FooEnumList.build(input[:enum_list]) unless input[:enum_list].nil?
        data['intEnumList'] = IntegerEnumList.build(input[:int_enum_list]) unless input[:int_enum_list].nil?
        data['nestedStringList'] = NestedStringList.build(input[:nested_string_list]) unless input[:nested_string_list].nil?
        data['structureList'] = StructureList.build(input[:structure_list]) unless input[:structure_list].nil?
        data['blobList'] = BlobList.build(input[:blob_list]) unless input[:blob_list].nil?
        http_req.headers['Content-Type'] = 'application/cbor'
        http_req.body = ::StringIO.new(Hearth::CBOR.encode(data))
      end
    end

    class RpcV2CborSparseMaps
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/RpcV2Protocol/operation/RpcV2CborSparseMaps')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        data = {}
        data['sparseStructMap'] = SparseStructMap.build(input[:sparse_struct_map]) unless input[:sparse_struct_map].nil?
        data['sparseNumberMap'] = SparseNumberMap.build(input[:sparse_number_map]) unless input[:sparse_number_map].nil?
        data['sparseBooleanMap'] = SparseBooleanMap.build(input[:sparse_boolean_map]) unless input[:sparse_boolean_map].nil?
        data['sparseStringMap'] = SparseStringMap.build(input[:sparse_string_map]) unless input[:sparse_string_map].nil?
        data['sparseSetMap'] = SparseSetMap.build(input[:sparse_set_map]) unless input[:sparse_set_map].nil?
        http_req.headers['Content-Type'] = 'application/cbor'
        http_req.body = ::StringIO.new(Hearth::CBOR.encode(data))
      end
    end

    class SimpleScalarProperties
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/RpcV2Protocol/operation/SimpleScalarProperties')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        data = {}
        data['trueBooleanValue'] = input[:true_boolean_value] unless input[:true_boolean_value].nil?
        data['falseBooleanValue'] = input[:false_boolean_value] unless input[:false_boolean_value].nil?
        data['byteValue'] = input[:byte_value] unless input[:byte_value].nil?
        data['doubleValue'] = input[:double_value] unless input[:double_value].nil?
        data['floatValue'] = input[:float_value] unless input[:float_value].nil?
        data['integerValue'] = input[:integer_value] unless input[:integer_value].nil?
        data['longValue'] = input[:long_value] unless input[:long_value].nil?
        data['shortValue'] = input[:short_value] unless input[:short_value].nil?
        data['stringValue'] = input[:string_value] unless input[:string_value].nil?
        data['blobValue'] = ((String === input[:blob_value] ? input[:blob_value] : input[:blob_value].read).encode(Encoding::BINARY)) unless input[:blob_value].nil?
        http_req.headers['Content-Type'] = 'application/cbor'
        http_req.body = ::StringIO.new(Hearth::CBOR.encode(data))
      end
    end

    class SparseBooleanMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseNullsOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/service/RpcV2Protocol/operation/SparseNullsOperation')
        http_req.headers['Smithy-Protocol'] = 'rpc-v2-cbor'
        data = {}
        data['sparseStringList'] = SparseStringList.build(input[:sparse_string_list]) unless input[:sparse_string_list].nil?
        data['sparseStringMap'] = SparseStringMap.build(input[:sparse_string_map]) unless input[:sparse_string_map].nil?
        http_req.headers['Content-Type'] = 'application/cbor'
        http_req.body = ::StringIO.new(Hearth::CBOR.encode(data))
      end
    end

    class SparseNumberMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseSetMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = (StringSet.build(value) unless value.nil?)
        end
        data
      end
    end

    class SparseStringList
      def self.build(input)
        data = []
        input.each do |element|
          data << element
        end
        data
      end
    end

    class SparseStringMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseStructMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = (GreetingStruct.build(value) unless value.nil?)
        end
        data
      end
    end

    class StringList
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class StringSet
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class StructureList
      def self.build(input)
        data = []
        input.each do |element|
          data << StructureListMember.build(element) unless element.nil?
        end
        data
      end
    end

    class StructureListMember
      def self.build(input)
        data = {}
        data['a'] = input[:a] unless input[:a].nil?
        data['b'] = input[:b] unless input[:b].nil?
        data
      end
    end

    class TestStringList
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class TestStringMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class TimestampList
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end
  end
end
