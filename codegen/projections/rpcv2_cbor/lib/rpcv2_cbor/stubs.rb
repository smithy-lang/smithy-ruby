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
  module Stubs

    class BlobList
      def self.default(visited = [])
        return nil if visited.include?('BlobList')
        visited = visited + ['BlobList']
        [
          'member'
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << ((String === element ? element : element.read).encode(Encoding::BINARY)) unless element.nil?
        end
        data
      end
    end

    class BooleanList
      def self.default(visited = [])
        return nil if visited.include?('BooleanList')
        visited = visited + ['BooleanList']
        [
          false
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class ComplexError
      def self.build(params, context:)
        Params::ComplexError.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ComplexError.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          top_level: 'top_level',
          nested: ComplexNestedErrorData.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.status = 400
        data = {}
        data['__type'] = 'ComplexError'
        data['TopLevel'] = stub[:top_level] unless stub[:top_level].nil?
        data['Nested'] = ComplexNestedErrorData.stub(stub[:nested]) unless stub[:nested].nil?
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
      end
    end

    class ComplexNestedErrorData
      def self.default(visited = [])
        return nil if visited.include?('ComplexNestedErrorData')
        visited = visited + ['ComplexNestedErrorData']
        {
          foo: 'foo',
        }
      end

      def self.stub(stub)
        stub ||= Types::ComplexNestedErrorData.new
        data = {}
        data['Foo'] = stub[:foo] unless stub[:foo].nil?
        data
      end
    end

    class DenseBooleanMap
      def self.default(visited = [])
        return nil if visited.include?('DenseBooleanMap')
        visited = visited + ['DenseBooleanMap']
        {
          key: false
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseNumberMap
      def self.default(visited = [])
        return nil if visited.include?('DenseNumberMap')
        visited = visited + ['DenseNumberMap']
        {
          key: 1
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseSetMap
      def self.default(visited = [])
        return nil if visited.include?('DenseSetMap')
        visited = visited + ['DenseSetMap']
        {
          key: StringSet.default(visited)
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = StringSet.stub(value) unless value.nil?
        end
        data
      end
    end

    class DenseStringMap
      def self.default(visited = [])
        return nil if visited.include?('DenseStringMap')
        visited = visited + ['DenseStringMap']
        {
          key: 'value'
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseStructMap
      def self.default(visited = [])
        return nil if visited.include?('DenseStructMap')
        visited = visited + ['DenseStructMap']
        {
          key: GreetingStruct.default(visited)
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = GreetingStruct.stub(value) unless value.nil?
        end
        data
      end
    end

    class EmptyInputOutput
      def self.build(params, context:)
        Params::EmptyInputOutputOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::EmptyInputOutputOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
        http_resp.status = 200
      end
    end

    class Float16
      def self.build(params, context:)
        Params::Float16Output.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::Float16Output.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          value: 1.0,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['value'] = stub[:value] unless stub[:value].nil?
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
        http_resp.status = 200
      end
    end

    class FooEnumList
      def self.default(visited = [])
        return nil if visited.include?('FooEnumList')
        visited = visited + ['FooEnumList']
        [
          'member'
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class FractionalSeconds
      def self.build(params, context:)
        Params::FractionalSecondsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::FractionalSecondsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          datetime: Time.now,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['datetime'] = stub[:datetime] unless stub[:datetime].nil?
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
        http_resp.status = 200
      end
    end

    class GreetingStruct
      def self.default(visited = [])
        return nil if visited.include?('GreetingStruct')
        visited = visited + ['GreetingStruct']
        {
          hi: 'hi',
        }
      end

      def self.stub(stub)
        stub ||= Types::GreetingStruct.new
        data = {}
        data['hi'] = stub[:hi] unless stub[:hi].nil?
        data
      end
    end

    class GreetingWithErrors
      def self.build(params, context:)
        Params::GreetingWithErrorsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::GreetingWithErrorsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          greeting: 'greeting',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['greeting'] = stub[:greeting] unless stub[:greeting].nil?
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
        http_resp.status = 200
      end
    end

    class IntegerEnumList
      def self.default(visited = [])
        return nil if visited.include?('IntegerEnumList')
        visited = visited + ['IntegerEnumList']
        [
          1
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class IntegerList
      def self.default(visited = [])
        return nil if visited.include?('IntegerList')
        visited = visited + ['IntegerList']
        [
          1
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class InvalidGreeting
      def self.build(params, context:)
        Params::InvalidGreeting.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::InvalidGreeting.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          message: 'message',
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.status = 400
        data = {}
        data['__type'] = 'InvalidGreeting'
        data['Message'] = stub[:message] unless stub[:message].nil?
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
      end
    end

    class NestedStringList
      def self.default(visited = [])
        return nil if visited.include?('NestedStringList')
        visited = visited + ['NestedStringList']
        [
          StringList.default(visited)
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << StringList.stub(element) unless element.nil?
        end
        data
      end
    end

    class NoInputOutput
      def self.build(params, context:)
        Params::NoInputOutputOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::NoInputOutputOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
        http_resp.status = 200
      end
    end

    class OperationWithDefaults
      def self.build(params, context:)
        Params::OperationWithDefaultsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::OperationWithDefaultsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          default_string: 'default_string',
          default_boolean: false,
          default_list: TestStringList.default(visited),
          default_timestamp: Time.now,
          default_blob: 'default_blob',
          default_byte: 1,
          default_short: 1,
          default_integer: 1,
          default_long: 1,
          default_float: 1.0,
          default_double: 1.0,
          default_map: TestStringMap.default(visited),
          default_enum: 'default_enum',
          default_int_enum: 1,
          empty_string: 'empty_string',
          false_boolean: false,
          empty_blob: 'empty_blob',
          zero_byte: 1,
          zero_short: 1,
          zero_integer: 1,
          zero_long: 1,
          zero_float: 1.0,
          zero_double: 1.0,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['defaultString'] = stub[:default_string] unless stub[:default_string].nil?
        data['defaultBoolean'] = stub[:default_boolean] unless stub[:default_boolean].nil?
        data['defaultList'] = TestStringList.stub(stub[:default_list]) unless stub[:default_list].nil?
        data['defaultTimestamp'] = stub[:default_timestamp] unless stub[:default_timestamp].nil?
        data['defaultBlob'] = ((String === stub[:default_blob] ? stub[:default_blob] : stub[:default_blob].read).encode(Encoding::BINARY)) unless stub[:default_blob].nil?
        data['defaultByte'] = stub[:default_byte] unless stub[:default_byte].nil?
        data['defaultShort'] = stub[:default_short] unless stub[:default_short].nil?
        data['defaultInteger'] = stub[:default_integer] unless stub[:default_integer].nil?
        data['defaultLong'] = stub[:default_long] unless stub[:default_long].nil?
        data['defaultFloat'] = stub[:default_float] unless stub[:default_float].nil?
        data['defaultDouble'] = stub[:default_double] unless stub[:default_double].nil?
        data['defaultMap'] = TestStringMap.stub(stub[:default_map]) unless stub[:default_map].nil?
        data['defaultEnum'] = stub[:default_enum] unless stub[:default_enum].nil?
        data['defaultIntEnum'] = stub[:default_int_enum] unless stub[:default_int_enum].nil?
        data['emptyString'] = stub[:empty_string] unless stub[:empty_string].nil?
        data['falseBoolean'] = stub[:false_boolean] unless stub[:false_boolean].nil?
        data['emptyBlob'] = ((String === stub[:empty_blob] ? stub[:empty_blob] : stub[:empty_blob].read).encode(Encoding::BINARY)) unless stub[:empty_blob].nil?
        data['zeroByte'] = stub[:zero_byte] unless stub[:zero_byte].nil?
        data['zeroShort'] = stub[:zero_short] unless stub[:zero_short].nil?
        data['zeroInteger'] = stub[:zero_integer] unless stub[:zero_integer].nil?
        data['zeroLong'] = stub[:zero_long] unless stub[:zero_long].nil?
        data['zeroFloat'] = stub[:zero_float] unless stub[:zero_float].nil?
        data['zeroDouble'] = stub[:zero_double] unless stub[:zero_double].nil?
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
        http_resp.status = 200
      end
    end

    class OptionalInputOutput
      def self.build(params, context:)
        Params::OptionalInputOutputOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::OptionalInputOutputOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          value: 'value',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['value'] = stub[:value] unless stub[:value].nil?
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
        http_resp.status = 200
      end
    end

    class RecursiveShapes
      def self.build(params, context:)
        Params::RecursiveShapesOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::RecursiveShapesOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          nested: RecursiveShapesInputOutputNested1.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['nested'] = RecursiveShapesInputOutputNested1.stub(stub[:nested]) unless stub[:nested].nil?
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
        http_resp.status = 200
      end
    end

    class RecursiveShapesInputOutputNested1
      def self.default(visited = [])
        return nil if visited.include?('RecursiveShapesInputOutputNested1')
        visited = visited + ['RecursiveShapesInputOutputNested1']
        {
          foo: 'foo',
          nested: RecursiveShapesInputOutputNested2.default(visited),
        }
      end

      def self.stub(stub)
        stub ||= Types::RecursiveShapesInputOutputNested1.new
        data = {}
        data['foo'] = stub[:foo] unless stub[:foo].nil?
        data['nested'] = RecursiveShapesInputOutputNested2.stub(stub[:nested]) unless stub[:nested].nil?
        data
      end
    end

    class RecursiveShapesInputOutputNested2
      def self.default(visited = [])
        return nil if visited.include?('RecursiveShapesInputOutputNested2')
        visited = visited + ['RecursiveShapesInputOutputNested2']
        {
          bar: 'bar',
          recursive_member: RecursiveShapesInputOutputNested1.default(visited),
        }
      end

      def self.stub(stub)
        stub ||= Types::RecursiveShapesInputOutputNested2.new
        data = {}
        data['bar'] = stub[:bar] unless stub[:bar].nil?
        data['recursiveMember'] = RecursiveShapesInputOutputNested1.stub(stub[:recursive_member]) unless stub[:recursive_member].nil?
        data
      end
    end

    class RpcV2CborDenseMaps
      def self.build(params, context:)
        Params::RpcV2CborDenseMapsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::RpcV2CborDenseMapsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          dense_struct_map: DenseStructMap.default(visited),
          dense_number_map: DenseNumberMap.default(visited),
          dense_boolean_map: DenseBooleanMap.default(visited),
          dense_string_map: DenseStringMap.default(visited),
          dense_set_map: DenseSetMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['denseStructMap'] = DenseStructMap.stub(stub[:dense_struct_map]) unless stub[:dense_struct_map].nil?
        data['denseNumberMap'] = DenseNumberMap.stub(stub[:dense_number_map]) unless stub[:dense_number_map].nil?
        data['denseBooleanMap'] = DenseBooleanMap.stub(stub[:dense_boolean_map]) unless stub[:dense_boolean_map].nil?
        data['denseStringMap'] = DenseStringMap.stub(stub[:dense_string_map]) unless stub[:dense_string_map].nil?
        data['denseSetMap'] = DenseSetMap.stub(stub[:dense_set_map]) unless stub[:dense_set_map].nil?
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
        http_resp.status = 200
      end
    end

    class RpcV2CborLists
      def self.build(params, context:)
        Params::RpcV2CborListsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::RpcV2CborListsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          string_list: StringList.default(visited),
          string_set: StringSet.default(visited),
          integer_list: IntegerList.default(visited),
          boolean_list: BooleanList.default(visited),
          timestamp_list: TimestampList.default(visited),
          enum_list: FooEnumList.default(visited),
          int_enum_list: IntegerEnumList.default(visited),
          nested_string_list: NestedStringList.default(visited),
          structure_list: StructureList.default(visited),
          blob_list: BlobList.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['stringList'] = StringList.stub(stub[:string_list]) unless stub[:string_list].nil?
        data['stringSet'] = StringSet.stub(stub[:string_set]) unless stub[:string_set].nil?
        data['integerList'] = IntegerList.stub(stub[:integer_list]) unless stub[:integer_list].nil?
        data['booleanList'] = BooleanList.stub(stub[:boolean_list]) unless stub[:boolean_list].nil?
        data['timestampList'] = TimestampList.stub(stub[:timestamp_list]) unless stub[:timestamp_list].nil?
        data['enumList'] = FooEnumList.stub(stub[:enum_list]) unless stub[:enum_list].nil?
        data['intEnumList'] = IntegerEnumList.stub(stub[:int_enum_list]) unless stub[:int_enum_list].nil?
        data['nestedStringList'] = NestedStringList.stub(stub[:nested_string_list]) unless stub[:nested_string_list].nil?
        data['structureList'] = StructureList.stub(stub[:structure_list]) unless stub[:structure_list].nil?
        data['blobList'] = BlobList.stub(stub[:blob_list]) unless stub[:blob_list].nil?
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
        http_resp.status = 200
      end
    end

    class RpcV2CborSparseMaps
      def self.build(params, context:)
        Params::RpcV2CborSparseMapsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::RpcV2CborSparseMapsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          sparse_struct_map: SparseStructMap.default(visited),
          sparse_number_map: SparseNumberMap.default(visited),
          sparse_boolean_map: SparseBooleanMap.default(visited),
          sparse_string_map: SparseStringMap.default(visited),
          sparse_set_map: SparseSetMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['sparseStructMap'] = SparseStructMap.stub(stub[:sparse_struct_map]) unless stub[:sparse_struct_map].nil?
        data['sparseNumberMap'] = SparseNumberMap.stub(stub[:sparse_number_map]) unless stub[:sparse_number_map].nil?
        data['sparseBooleanMap'] = SparseBooleanMap.stub(stub[:sparse_boolean_map]) unless stub[:sparse_boolean_map].nil?
        data['sparseStringMap'] = SparseStringMap.stub(stub[:sparse_string_map]) unless stub[:sparse_string_map].nil?
        data['sparseSetMap'] = SparseSetMap.stub(stub[:sparse_set_map]) unless stub[:sparse_set_map].nil?
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
        http_resp.status = 200
      end
    end

    class SimpleScalarProperties
      def self.build(params, context:)
        Params::SimpleScalarPropertiesOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::SimpleScalarPropertiesOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          true_boolean_value: false,
          false_boolean_value: false,
          byte_value: 1,
          double_value: 1.0,
          float_value: 1.0,
          integer_value: 1,
          long_value: 1,
          short_value: 1,
          string_value: 'string_value',
          blob_value: 'blob_value',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['trueBooleanValue'] = stub[:true_boolean_value] unless stub[:true_boolean_value].nil?
        data['falseBooleanValue'] = stub[:false_boolean_value] unless stub[:false_boolean_value].nil?
        data['byteValue'] = stub[:byte_value] unless stub[:byte_value].nil?
        data['doubleValue'] = stub[:double_value] unless stub[:double_value].nil?
        data['floatValue'] = stub[:float_value] unless stub[:float_value].nil?
        data['integerValue'] = stub[:integer_value] unless stub[:integer_value].nil?
        data['longValue'] = stub[:long_value] unless stub[:long_value].nil?
        data['shortValue'] = stub[:short_value] unless stub[:short_value].nil?
        data['stringValue'] = stub[:string_value] unless stub[:string_value].nil?
        data['blobValue'] = ((String === stub[:blob_value] ? stub[:blob_value] : stub[:blob_value].read).encode(Encoding::BINARY)) unless stub[:blob_value].nil?
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
        http_resp.status = 200
      end
    end

    class SparseBooleanMap
      def self.default(visited = [])
        return nil if visited.include?('SparseBooleanMap')
        visited = visited + ['SparseBooleanMap']
        {
          key: false
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseNullsOperation
      def self.build(params, context:)
        Params::SparseNullsOperationOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::SparseNullsOperationOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          sparse_string_list: SparseStringList.default(visited),
          sparse_string_map: SparseStringMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['sparseStringList'] = SparseStringList.stub(stub[:sparse_string_list]) unless stub[:sparse_string_list].nil?
        data['sparseStringMap'] = SparseStringMap.stub(stub[:sparse_string_map]) unless stub[:sparse_string_map].nil?
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
        http_resp.status = 200
      end
    end

    class SparseNumberMap
      def self.default(visited = [])
        return nil if visited.include?('SparseNumberMap')
        visited = visited + ['SparseNumberMap']
        {
          key: 1
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseSetMap
      def self.default(visited = [])
        return nil if visited.include?('SparseSetMap')
        visited = visited + ['SparseSetMap']
        {
          key: StringSet.default(visited)
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = (StringSet.stub(value) unless value.nil?)
        end
        data
      end
    end

    class SparseStringList
      def self.default(visited = [])
        return nil if visited.include?('SparseStringList')
        visited = visited + ['SparseStringList']
        [
          'member'
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << element
        end
        data
      end
    end

    class SparseStringMap
      def self.default(visited = [])
        return nil if visited.include?('SparseStringMap')
        visited = visited + ['SparseStringMap']
        {
          key: 'value'
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseStructMap
      def self.default(visited = [])
        return nil if visited.include?('SparseStructMap')
        visited = visited + ['SparseStructMap']
        {
          key: GreetingStruct.default(visited)
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = (GreetingStruct.stub(value) unless value.nil?)
        end
        data
      end
    end

    class StringList
      def self.default(visited = [])
        return nil if visited.include?('StringList')
        visited = visited + ['StringList']
        [
          'member'
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class StringSet
      def self.default(visited = [])
        return nil if visited.include?('StringSet')
        visited = visited + ['StringSet']
        [
          'member'
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class StructureList
      def self.default(visited = [])
        return nil if visited.include?('StructureList')
        visited = visited + ['StructureList']
        [
          StructureListMember.default(visited)
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << StructureListMember.stub(element) unless element.nil?
        end
        data
      end
    end

    class StructureListMember
      def self.default(visited = [])
        return nil if visited.include?('StructureListMember')
        visited = visited + ['StructureListMember']
        {
          a: 'a',
          b: 'b',
        }
      end

      def self.stub(stub)
        stub ||= Types::StructureListMember.new
        data = {}
        data['a'] = stub[:a] unless stub[:a].nil?
        data['b'] = stub[:b] unless stub[:b].nil?
        data
      end
    end

    class TestStringList
      def self.default(visited = [])
        return nil if visited.include?('TestStringList')
        visited = visited + ['TestStringList']
        [
          'member'
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class TestStringMap
      def self.default(visited = [])
        return nil if visited.include?('TestStringMap')
        visited = visited + ['TestStringMap']
        {
          key: 'value'
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class TimestampList
      def self.default(visited = [])
        return nil if visited.include?('TimestampList')
        visited = visited + ['TimestampList']
        [
          Time.now
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class ValidationException
      def self.build(params, context:)
        Params::ValidationException.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ValidationException.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          message: 'message',
          field_list: ValidationExceptionFieldList.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.status = 400
        data = {}
        data['__type'] = 'ValidationException'
        data['message'] = stub[:message] unless stub[:message].nil?
        data['fieldList'] = ValidationExceptionFieldList.stub(stub[:field_list]) unless stub[:field_list].nil?
        http_resp.body = ::StringIO.new(Hearth::Cbor.encode(data))
      end
    end

    class ValidationExceptionField
      def self.default(visited = [])
        return nil if visited.include?('ValidationExceptionField')
        visited = visited + ['ValidationExceptionField']
        {
          path: 'path',
          message: 'message',
        }
      end

      def self.stub(stub)
        stub ||= Types::ValidationExceptionField.new
        data = {}
        data['path'] = stub[:path] unless stub[:path].nil?
        data['message'] = stub[:message] unless stub[:message].nil?
        data
      end
    end

    class ValidationExceptionFieldList
      def self.default(visited = [])
        return nil if visited.include?('ValidationExceptionFieldList')
        visited = visited + ['ValidationExceptionFieldList']
        [
          ValidationExceptionField.default(visited)
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << ValidationExceptionField.stub(element) unless element.nil?
        end
        data
      end
    end
  end
end
