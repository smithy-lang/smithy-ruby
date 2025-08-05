# frozen_string_literal: true

require_relative 'spec_helper'

module Smithy
  describe Cbor do
    it 'supports the smithy engine' do
      subject.engine = :smithy
      expect(subject.engine).to eq(Smithy::Cbor::SmithyEngine)
    end

    it 'raises when there is no supported engines' do
      Smithy::Cbor.instance_variable_set(:@engine, nil)
      expect(Cbor).to receive(:require).with('smithy-cbor/smithy_engine').and_raise(LoadError)
      expect { Smithy::Cbor.set_default_engine }.to raise_error(/Unable to find a compatible cbor library/)
    end

    %i[smithy].each do |engine|
      describe "ENGINE: #{engine};" do
        before do
          subject.engine = engine
        rescue LoadError
          skip "Skipping #{engine} tests because it is not installed"
        end

        it 'encodes and decodes a complex ruby object' do
          h = {
            'a' => [1, 2, 3],
            'b' => Time.parse('2000-01-01')
          }
          expect(Cbor.decode(Cbor.encode(h))).to eq(h)
        end

        context '.decode' do
          success_tests = File.expand_path('decode-success-tests.json', __dir__.to_s)
          success_test_cases = ::JSON.load_file(success_tests)
          error_tests = File.expand_path('decode-error-tests.json', __dir__.to_s)
          error_test_cases = ::JSON.load_file(error_tests)

          def expected_value(expect)
            raise 'invalid test case' if expect.keys.size != 1

            case expect.keys.first
            when 'uint' then expect['uint']
            when 'negint' then expect['negint']
            when 'bytestring' then expect['bytestring'].pack('c*')
            when 'string' then expect['string']
            when 'list'
              expect['list'].map { |item| expected_value(item) }
            when 'map'
              expect['map'].transform_values do |value|
                expected_value(value)
              end
            when 'tag'
              value = expected_value(expect['tag']['value'])
              Cbor::Tagged.new(expect['tag']['id'], value)
            when 'bool' then expect['bool']
            when 'null' then nil
            when 'undefined' then :undefined
            when 'float32' then [expect['float32']].pack('L').unpack1('f')
            when 'float64' then [expect['float64']].pack('Q').unpack1('d')
            else raise "unexpected expect value: #{expect}"
            end
          end

          def assert(actual, expected)
            case expected
            when Array
              expected.each_with_index do |item, i|
                assert(actual[i], item)
              end
            when Hash
              expected.each do |key, value|
                assert(actual[key], value)
              end
            when Float
              expect(actual.nan?).to be true if expected.nan?
            when Cbor::Tagged
              expect(actual.tag).to eq(expected.tag)
              expect(actual.value).to eq(expected.value)
            else
              expect(actual).to eq(expected)
            end
          end

          success_test_cases.each do |test_case|
            it "passes #{test_case['description']}" do
              input = [test_case['input']].pack('H*')
              actual = Cbor.decode(input)
              expected = expected_value(test_case['expect'])
              assert(actual, expected)
            end
          end

          error_test_cases.each do |test_case|
            it "passes #{test_case['description']}" do
              input = [test_case['input']].pack('H*')
              expect { Cbor.decode(input) }.to raise_error(Cbor::ParseError)
            end
          end
        end
      end
    end
  end
end
