# frozen_string_literal: true

module Hearth
  module HTTP
    describe HeaderListBuilder do
      describe '.builds_list' do
        it 'builds with an array of integers' do
          expect(HeaderListBuilder.build_list([1, 2, 3]))
            .to eq('1, 2, 3')
        end

        it 'builds with an array of booleans' do
          expect(HeaderListBuilder.build_list([true, false, true]))
            .to eq('true, false, true')
        end
      end

      describe '.builds_string_list' do
        it 'builds with an array of a single string' do
          expect(HeaderListBuilder.build_string_list(['a']))
            .to eq('a')
        end

        it 'builds with an array of unquoted strings' do
          expect(HeaderListBuilder.build_string_list(%w[a b c]))
            .to eq('a, b, c')
        end

        it 'builds with an array of quoted strings' do
          expect(HeaderListBuilder.build_string_list(['b,c', '"def"', 'a']))
            .to eq('"b,c", "\"def\"", a')
        end
      end

      context 'builds with array of time objects' do
        let(:time_objects) do
          [
            Time.utc(1970, 1, 1),
            Time.at(946_845_296, 123, :millisecond)
          ]
        end

        describe '.build_http_date_list' do
          it 'builds with an array of time objects' do
            expect(HeaderListBuilder.build_http_date_list(time_objects)).to eq(
              'Thu, 01 Jan 1970 00:00:00 GMT, ' \
              'Sun, 02 Jan 2000 20:34:56.123 GMT'
            )
          end
        end

        describe '.build_date_time_list' do
          it 'builds with an array of time objects' do
            expect(HeaderListBuilder.build_date_time_list(time_objects))
              .to eq('1970-01-01T00:00:00Z, 2000-01-02T20:34:56.123Z')
          end
        end

        describe '.build_epoch_seconds_list' do
          it 'builds with an array of time objects' do
            expect(HeaderListBuilder.build_epoch_seconds_list(time_objects))
              .to eq('0.0, 946845296.123')
          end
        end
      end
    end
  end
end
