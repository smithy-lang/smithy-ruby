# frozen_string_literal: true

module Hearth
  module HTTP
    describe HeaderListParser do
      describe '.parse_boolean_list' do
        it 'parses an empty list' do
          expect(HeaderListParser.parse_boolean_list(''))
            .to eq([])
        end

        it 'parses a single item' do
          expect(HeaderListParser.parse_boolean_list('true'))
            .to eq([true])
        end

        it 'parses multiple items' do
          expect(HeaderListParser.parse_boolean_list('true, false, true'))
            .to eq([true, false, true])
        end
      end

      describe '.parse_integer_list' do
        it 'parses an empty list' do
          expect(HeaderListParser.parse_integer_list(''))
            .to eq([])
        end

        it 'parses a single item' do
          expect(HeaderListParser.parse_integer_list('1'))
            .to eq([1])
        end

        it 'parses multiple items' do
          expect(HeaderListParser.parse_integer_list('1, 2, 3'))
            .to eq([1, 2, 3])
        end
      end

      describe '.parse_float_list' do
        it 'parses an empty list' do
          expect(HeaderListParser.parse_float_list(''))
            .to eq([])
        end

        it 'parses a single item' do
          expect(HeaderListParser.parse_float_list('1.1'))
            .to eq([1.1])
        end

        it 'parses multiple items' do
          expect(HeaderListParser.parse_float_list('1.1, 2.2, 3.3'))
            .to eq([1.1, 2.2, 3.3])
        end
      end

      describe '.parse_string_list' do
        it 'parses an empty list' do
          expect(HeaderListParser.parse_string_list(''))
            .to eq([])
        end

        it 'parses a single item' do
          expect(HeaderListParser.parse_string_list('a'))
            .to eq(['a'])
        end

        it 'parses multiple unquoted items' do
          expect(HeaderListParser.parse_string_list('a, b, c'))
            .to eq(%w[a b c])
        end

        it 'parses multiple quoted items' do
          expect(HeaderListParser.parse_string_list('"b,c", "\"def\"", a'))
            .to eq(['b,c', '"def"', 'a'])
        end

        it 'raises an error on invalid lists' do
          expect do
            HeaderListParser.parse_string_list('"a,b,c')
          end.to raise_error(ArgumentError, /No closing quote found/)
        end
      end

      describe '.parse_http_date_list' do
        it 'parses an empty list' do
          expect(HeaderListParser.parse_http_date_list(''))
            .to eq([])
        end

        it 'parses a single item' do
          expect(
            HeaderListParser.parse_http_date_list(
              'Mon, 16 Dec 2019 23:48:18 GMT'
            )
          ).to eq([Time.parse('Mon, 16 Dec 2019 23:48:18 GMT')])
        end

        it 'parses multiple items' do
          expect(
            HeaderListParser.parse_http_date_list(
              'Mon, 16 Dec 2019 23:48:18 GMT,' \
              'Mon, 16 Dec 2019 23:48:18 GMT'
            )
          ).to eq(
            [
              Time.parse('Mon, 16 Dec 2019 23:48:18 GMT'),
              Time.parse('Mon, 16 Dec 2019 23:48:18 GMT')
            ]
          )
        end
      end

      describe '.parse_date_time_list' do
        it 'parses an empty list' do
          expect(HeaderListParser.parse_date_time_list(''))
            .to eq([])
        end

        it 'parses a single item' do
          expect(
            HeaderListParser.parse_date_time_list(
              '1970-01-01T00:00:00Z'
            )
          ).to eq([Time.parse('1970-01-01T00:00:00Z')])
        end

        it 'parses multiple items' do
          expect(
            HeaderListParser.parse_date_time_list(
              '1970-01-01T00:00:00Z,' \
              '2000-01-02T20:34:56.123Z'
            )
          ).to eq(
            [
              Time.parse('1970-01-01T00:00:00Z'),
              Time.parse('2000-01-02T20:34:56.123Z')
            ]
          )
        end
      end

      describe '.parse_epoch_seconds_list' do
        it 'parses an empty list' do
          expect(HeaderListParser.parse_epoch_seconds_list(''))
            .to eq([])
        end

        it 'parses a single item' do
          expect(HeaderListParser.parse_epoch_seconds_list('0.0'))
            .to eq([Time.at(0.0)])
        end

        it 'parses multiple items' do
          expect(
            HeaderListParser.parse_epoch_seconds_list('0.0, 946845296')
          ).to eq(
            [
              Time.at(0),
              Time.at(946_845_296)
            ]
          )
        end
      end
    end
  end
end
