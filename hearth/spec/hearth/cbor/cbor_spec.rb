# frozen_string_literal: true

require_relative '../../spec_helper'

module Hearth
  describe Cbor do
    context 'decode success tests' do
      file = File.expand_path('decode-success-tests.json', __dir__)
      test_cases = ::JSON.load_file(file)

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
        else
          raise "unexpected expect value: #{expect}"
        end
      end

      def assert(actual, expected)
        if expected.is_a?(Float) && expected.nan?
          expect(actual.nan?).to be true
        elsif expected.is_a?(Array)
          expected.each_with_index do |item, i|
            assert(actual[i], item)
          end
        elsif expected.is_a?(Hash)
          expected.each do |key, value|
            assert(actual[key], value)
          end
        else
          expect(actual).to eq(expected)
        end
      end

      test_cases.each do |test_case|
        it "passes #{test_case['description']}" do
          input = [test_case['input']].pack('H*')
          actual = Cbor.decode(input)
          expected = expected_value(test_case['expect'])
          assert(actual, expected)
        end
      end
    end

    context 'decode error tests' do
      file = File.expand_path('decode-error-tests.json', __dir__)
      test_cases = ::JSON.load_file(file)

      test_cases.each do |test_case|
        it "passes #{test_case['description']}" do
          input = [test_case['input']].pack('H*')

          expect { Cbor.decode(input) }
            .to raise_error(Cbor::CborError)
        end
      end
    end

    context 'encode/decode pair tests' do
      it 'encodes and decodes a complex ruby object' do
        h = {
          'a' => [1, 2, 3],
          'b' => Time.parse('2000-01-01')
        }
        expect(Cbor.decode(Cbor.encode(h))).to eq(h)
      end
    end
  end
end
