# frozen_string_literal: true

module Hearth
  module HTTP
    describe Field do
      let(:header) { Field.new('X-Header', 'foo') }
      let(:trailer) { Field.new('X-Trailer', 'bar', kind: :trailer) }

      describe '#initialize' do
        it 'raises when name is nil' do
          expect { Field.new(nil) }.to raise_error(ArgumentError)
        end

        it 'raises when name is empty' do
          expect { Field.new('') }.to raise_error(ArgumentError)
        end

        it 'defaults to header kind' do
          expect(Field.new('header').kind).to eq(:header)
        end
      end

      it 'is immutable' do
        expect { header.name = 'X-Header-2' }.to raise_error(NoMethodError)
        expect { header.value = 'bar' }.to raise_error(NoMethodError)
        expect { header.kind = :trailer }.to raise_error(NoMethodError)
      end

      describe '#value' do
        let(:time) { Time.now }

        context 'value is a Scalar type' do
          let(:header_int) { Field.new('X-HeaderInt', 42) }
          let(:header_float) { Field.new('X-HeaderFloat', 420.69) }
          let(:header_time) { Field.new('X-HeaderTime', time) }

          it 'returns the value as a String' do
            expect(header.value).to eq('foo')
            expect(header_int.value).to eq('42')
            expect(header_float.value).to eq('420.69')
            expect(header_time.value).to eq(time.to_s)
          end
        end

        context 'encoding' do
          it 'allows for different encoding' do
            expect(header.value('UTF-16').encoding).to eq(Encoding::UTF_16)
          end
        end
      end

      describe '#header?' do
        it 'returns true when kind is :header' do
          expect(header.header?).to eq(true)
          expect(trailer.header?).to eq(false)
        end
      end

      describe '#trailer?' do
        it 'returns true when kind is :trailer' do
          expect(header.trailer?).to eq(false)
          expect(trailer.trailer?).to eq(true)
        end
      end

      describe '#to_h' do
        it 'returns a hash with the field name as key and value as value' do
          # ensure value method is called
          expect(header).to receive(:value).and_call_original
          expect(header.to_h).to eq('X-Header' => 'foo')
        end
      end

      describe '.escape_value' do
        context 'an unescaped string value' do
          it 'returns escaped string value' do
            expect(Field.escape_value('"def"')).to eq('"\"def\""')
          end
        end
      end
    end
  end
end
