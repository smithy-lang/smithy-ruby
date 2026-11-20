# frozen_string_literal: true

require_relative 'spec_helper'

module Smithy
  describe Cbor do
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

      # The error each malformed vector must raise, by the cause at the end of its description. The message shows
      # that the named fault is the one detected, including in vectors that also lack a break code after it.
      # decoder_spec.rb has complete single-fault fixtures for the same checks.
      error_causes = {
        /greater than remaining buf len|incomplete float|unexpected end of payload|expected break marker/ =>
          /\AOut of bytes\./,
        /major7.* unexpected minor value 31/ => /\AUnexpected break code\z/,
        /unexpected minor value 31/ => /\AUnexpected additional information: 31\z/,
        /nested indefinite slice/ => /\AUnexpected nested indefinite-length string chunk\z/,
        /unexpected major type 2 in indefinite slice/ => /\AUnexpected major type 2, expected a text string chunk\z/,
        /unexpected major type 3 in indefinite slice/ => /\AUnexpected major type 3, expected a byte string chunk\z/
      }

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

      # Compares the whole decoded value: collection sizes and keys, every element, and every float (NaN matches
      # NaN).
      def assert(actual, expected)
        case expected
        when Array
          expect(actual).to be_an(Array)
          expect(actual.size).to eq(expected.size)
          expected.each_with_index { |item, i| assert(actual[i], item) }
        when Hash
          expect(actual).to be_a(Hash)
          expect(actual.keys).to match_array(expected.keys)
          expected.each { |key, value| assert(actual[key], value) }
        when Float
          expect(actual).to be_a(Float)
          expected.nan? ? expect(actual).to(be_nan) : expect(actual).to(eq(expected))
        when Cbor::Tagged
          expect(actual).to be_a(Cbor::Tagged)
          expect(actual.tag).to eq(expected.tag)
          assert(actual.value, expected.value)
        else
          expect(actual).to eq(expected)
          expect(actual.class).to eq(expected.class)
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
          cause = error_causes.find { |pattern, _| test_case['description'].match?(pattern) }
          raise "no expected error for #{test_case['description']}" unless cause

          expect { Cbor.decode(input) }.to raise_error(Cbor::ParseError, cause[1])
        end
      end
    end
  end
end
