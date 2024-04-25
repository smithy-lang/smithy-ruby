# frozen_string_literal: true

module Hearth
  module Http
    describe HeaderListBuilder do
      describe '.builds_string_list' do
        it 'builds with a single element' do
          expect(HeaderListBuilder.build_string_list(['a']))
            .to eq('a')
        end

        it 'builds with unquoted elements' do
          expect(HeaderListBuilder.build_string_list(%w[a b c]))
            .to eq('a, b, c')
        end

        it 'builds with quoted elements' do
          expect(HeaderListBuilder.build_string_list(['b,c', '"def"', 'a']))
            .to eq('"b,c", "\"def\"", a')
        end

        it 'raises an error on invalid lists' do
          expect do
            HeaderListBuilder.build_string_list('input')
          end.to raise_error(
            ArgumentError,
            'Expected input to be an Array, got String instead'
          )
        end
      end
    end
  end
end
