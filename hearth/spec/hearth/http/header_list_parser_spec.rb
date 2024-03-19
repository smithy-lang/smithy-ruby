# frozen_string_literal: true

module Hearth
  module Http
    describe HeaderListParser do
      describe '.parser_string_list' do
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
          expect(HeaderListParser.parse_http_date_list(
                   'Mon, 16 Dec 2019 23:48:18 GMT'
                 ))
            .to eq([Time.parse('Mon, 16 Dec 2019 23:48:18 GMT')])
        end

        it 'parses multiple  items' do
          expect(HeaderListParser.parse_http_date_list(
                   'Mon, 16 Dec 2019 23:48:18 GMT,' \
                   'Mon, 16 Dec 2019 23:48:18 GMT'
                 ))
            .to eq([
                     Time.parse('Mon, 16 Dec 2019 23:48:18 GMT'),
                     Time.parse('Mon, 16 Dec 2019 23:48:18 GMT')
                   ])
        end
      end
    end
  end
end
