# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe ParamValidator do
      let(:shapes) { SchemaHelper.sample_shapes }
      let(:sample_client) { ClientHelper.sample_client }
      let(:service_shape) { sample_client.const_get(:Schema).const_get(:SampleSchema) }
      let(:input) { service_shape.operation(:operation).input }

      def validate(params, expected_errors = [])
        if expected_errors.empty?
          ParamValidator.new(input).validate!(params)
        else
          expect { ParamValidator.new(input).validate!(params) }
            .to raise_error(ArgumentError) { |error| match_errors(error, expected_errors) }
        end
      end

      def match_errors(error, expected_errors)
        expected_errors = [expected_errors] unless expected_errors.is_a?(Array)
        expected_errors.each do |expected_error|
          expect(error.message).to include(expected_error)
        end
      end

      context 'no params' do
        it 'accepts an empty hash of params' do
          expect(validate({}))
        end
      end

      context 'big decimals' do
        it 'accepts a big decimal' do
          validate(big_decimal: BigDecimal('1.0'))
          validate({ big_decimal: '123' },
                   'expected params[:big_decimal] to be a BigDecimal, got class String instead.')
        end
      end

      context 'big integers' do
        it 'accepts a big integer' do
          validate(big_integer: 1 << 65)
          validate({ big_integer: '123' },
                   'expected params[:big_integer] to be an Integer, got class String instead.')
        end
      end

      context 'blobs' do
        it 'accepts a string' do
          validate({ blob: 'abc' })
        end

        it 'accepts io objects that support read, rewind, and size' do
          validate(blob: StringIO.new('abc'))
          validate(blob: double('io', read: 'abc', rewind: 0, size: 3))
          expect = 'expected params[:blob] to be a String or IO like object that supports ' \
                   'read, rewind, and size, got class Integer instead.'
          validate({ blob: 123 }, [expect])
        end

        it 'accepts io objects that support read and rewind for streaming blobs' do
          validate(streaming_blob: StringIO.new('abc'))
          validate(streaming_blob: double('io', read: 'abc', rewind: 0))
          expected = 'expected params[:streaming_blob] to be a String or IO like object that supports read and ' \
                     'rewind, got class Integer instead.'
          validate({ streaming_blob: 123 }, [expected])
        end
      end

      context 'booleans' do
        it 'accepts TrueClass and FalseClass' do
          validate(boolean: true)
          validate(boolean: false)
          validate({ boolean: 'true' },
                   'expected params[:boolean] to be true or false, got class String instead.')
        end
      end

      context 'bytes' do
        it 'accepts a byte' do
          validate(byte: 123)
          validate({ byte: '123' },
                   'expected params[:byte] to be an Integer, got class String instead.')
        end
      end

      context 'documents' do
        it 'accepts numeric objects' do
          validate(document: 123)
          validate(document: 3.14159)
        end

        it 'accepts string objects' do
          validate(document: 'test string')
        end

        it 'accepts booleans' do
          validate(document: true)
          validate(document: false)
        end

        it 'accepts nil' do
          validate(document: nil)
        end

        it 'rejects Objects' do
          expect = 'expected params[:document] to be one of Hash, Array, Numeric, String, TrueClass, ' \
                   'FalseClass, NilClass, got class Object instead'
          validate({ document: Object.new }, [expect])
        end

        context 'Hash' do
          it 'accepts a flat Hash' do
            validate(document: { a: 1, b: 2 })
          end

          it 'accepts a nested Hash' do
            validate(document: { a: 1, b: { c: 'nested' } })
          end

          it 'recursively validates and rejects a nested arbitrary Object' do
            expect = 'expected params[:document][b][c] to be one of Hash, Array, Numeric, String, ' \
                     'TrueClass, FalseClass, NilClass, got class Object instead'
            validate({ document: { a: 1, b: { c: Object.new } } }, [expect])
          end
        end

        context 'Array' do
          it 'accepts an array' do
            validate(document: [1, 2, 3])
          end

          it 'rejects an array with arbitrary Objects' do
            expect = 'expected params[:document] to be one of Hash, Array, Numeric, String, TrueClass, ' \
                     'FalseClass, NilClass, got class Object instead'
            validate({ document: [1, 2, Object.new] }, [expect])
          end
        end
      end

      context 'doubles' do
        it 'accepts a double' do
          validate(double: 123.0)
          validate({ double: 123 },
                   'expected params[:double] to be a Float, got class Integer instead.')
        end
      end

      context 'enums' do
        it 'accepts a string' do
          validate(enum: 'abc')
          validate({ enum: 123 },
                   'expected params[:enum] to be a String, got class Integer instead.')
        end
      end

      context 'floats' do
        it 'accepts a float' do
          validate(float: 123.0)
          validate({ float: 123 },
                   'expected params[:float] to be a Float, got class Integer instead.')
        end
      end

      context 'integer enums' do
        it 'accepts an integer' do
          validate(int_enum: 123)
          validate({ int_enum: '123' },
                   'expected params[:int_enum] to be an Integer, got class String instead.')
        end
      end

      context 'integers' do
        it 'accepts an integer' do
          validate(integer: 123)
          validate({ integer: '123' },
                   'expected params[:integer] to be an Integer, got class String instead.')
        end
      end

      context 'lists' do
        it 'accepts arrays' do
          validate(list: [])
          validate(structure_list: [{}, {}])
        end

        it 'excepts the value to be an array' do
          validate({ list: 'abc' },
                   'expected params[:list] to be an Array, got class String instead.')
          validate({ structure_list: 'abc' },
                   'expected params[:structure_list] to be an Array, got class String instead.')
        end

        it 'validates each member of the list' do
          validate({ structure_list: [{}, 'abc'] },
                   'expected params[:structure_list][1] to be a Hash, got class String instead.')
          validate({ structure_list: [{ structure_list: ['abc'] }] },
                   'expected params[:structure_list][0][:structure_list][0] to be a Hash, got class String instead.')
          validate({ structure_list: [{ foo: 'abc' }] },
                   'unexpected value at params[:structure_list][0][:foo]')
        end
      end

      context 'maps' do
        it 'accepts hashes' do
          validate({ map: {} })
          validate({ map: 'abc' },
                   'expected params[:map] to be a Hash, got class String instead.')
        end

        it 'validates map keys' do
          validate({ map: { 'abc' => 'mno' } })
          validate({ map: { 123 => 'xyz' } },
                   ['expected params[:map] 123 key to be a String, got class Integer instead.'])
        end

        it 'validates map values' do
          validate({ map: { 'foo' => 'bar' } })
          validate({ map: { 'foo' => 123 } },
                   ['expected params[:map]["foo"] to be a String, got class Integer instead.'])
          validate({ structure_map: { 'foo' => { foo: 'bar' } } },
                   'unexpected value at params[:structure_map]["foo"]')
        end
      end

      context 'strings' do
        it 'accepts strings' do
          validate(string: 'abc')
          validate({ string: 123 },
                   ['expected params[:string] to be a String, got class Integer instead.'])
        end
      end

      context 'structures' do
        it 'validates nested structures' do
          validate('abc',
                   'expected params to be a Hash, got class String instead.')
          validate({ structure: 'abc' },
                   'expected params[:structure] to be a Hash, got class String instead.')
          validate({ structure: { structure: 'abc' } },
                   'expected params[:structure][:structure] to be a Hash, got class String instead.')
        end

        it 'accepts hashes' do
          validate({})
        end

        it 'raises an error when a required parameter is missing' do
          shapes['smithy.ruby.tests#Structure']['members']['string']['traits'] = { 'smithy.api#required' => {} }
          validate({}, 'missing required parameter params[:string]')
        end

        it 'raises an error when a given parameter is unexpected' do
          validate({ foo: 'bar' }, 'unexpected value at params[:foo]')
        end

        it 'accepts members that pass validation' do
          shapes['smithy.ruby.tests#Structure']['members']['string']['traits'] = { 'smithy.api#required' => {} }
          validate(string: 'abc')
        end

        it 'aggregates errors for members' do
          shapes['smithy.ruby.tests#Structure']['members']['string']['traits'] = { 'smithy.api#required' => {} }
          validate({ structure: { foo: 'bar' } }, [
                     'missing required parameter params[:string]',
                     'unexpected value at params[:structure][:foo]'
                   ])
        end

        it 'accepts a modeled type' do
          structure = sample_client.const_get(:Types).const_get(:Structure).new
          validate({ structure: structure })
        end
      end

      context 'timestamps' do
        it 'accepts time objects' do
          validate(timestamp: Time.now)
          validate({ timestamp: Date.new },
                   ['expected params[:timestamp] to be a Time object, got class Date instead.'])
        end
      end

      context 'unions' do
        it 'accepts members' do
          validate(union: { string: 'abc' })
          validate(union: { structure: {} })
          validate({ union: 'abc' },
                   'expected params[:union] to be a Hash, got class String instead.')
        end

        it 'raises an error when a given parameter is unexpected' do
          validate({ union: { foo: 'bar' } }, 'unexpected value at params[:union][:foo]')
        end

        it 'raises an error when given the wrong type' do
          validate({ union: { string: 123 } },
                   'expected params[:union][:string] to be a String, got class Integer instead.')
        end

        it 'raises an error when multiple values are set' do
          expect = 'expected params[:union] to be a Hash with one of string, structure, unit, unknown, ' \
                   'got 2 keys instead.'
          validate({ union: { string: 's', structure: {} } }, [expect])
        end

        it 'allows for nil union values' do
          validate(union: { string: nil })
        end

        it 'accepts a modeled type' do
          union_structure = sample_client.const_get(:Types).const_get(:Union).const_get(:Structure)
          validate({ union: union_structure.new(structure: { string: 'string' }) })
        end

        it 'raises an error when given the wrong modeled type' do
          union_structure = sample_client.const_get(:Types).const_get(:Union).const_get(:Structure)
          validate({ union: union_structure.new(structure: { structure: 'abc' }) },
                   'expected params[:union][:structure] to be a Hash, got class String instead.')
        end
      end
    end
  end
end
