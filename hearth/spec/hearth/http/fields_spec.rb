# frozen_string_literal: true

module Hearth
  module HTTP
    describe Fields do
      let(:header_field) { Field.new('X-Header', 'foo') }
      let(:trailer_field) { Field.new('X-Trailer', 'bar', kind: :trailer) }

      let(:fields) { Fields.new([header_field, trailer_field]) }

      describe '#initialize' do
        it 'defaults encoding to UTF-8' do
          expect(Fields.new.encoding).to eq('utf-8')
        end

        it 'raises when fields is not an Array' do
          expect { Fields.new(nil) }.to raise_error(ArgumentError)
          expect { Fields.new('not an array') }.to raise_error(ArgumentError)
        end

        it 'defaults to empty' do
          expect(Fields.new.size).to eq(0)
        end

        it 'initializes with fields' do
          expect(Fields.new([header_field]).size).to eq(1)
        end
      end

      describe '#[]' do
        it 'returns the field' do
          expect(fields['x-header']).to eq(header_field)
        end
      end

      describe '#[]=' do
        it 'raises when field is not a Field' do
          expect { fields['x-header'] = 'not a field' }
            .to raise_error(ArgumentError)
        end

        it 'sets the field' do
          fields['x-header'] = Field.new('X-Header', 'bar')
          expect(fields['x-header'].value).to eq('bar')
        end
      end

      describe '#key?' do
        it 'returns true if the field exists' do
          expect(fields.key?('x-header')).to eq(true)
          expect(fields.key?('x-trailer')).to eq(true)
          expect(fields.key?('x-foo')).to eq(false)
        end
      end

      describe '#delete' do
        it 'deletes the field' do
          fields.delete('x-header')
          expect(fields.key?('x-header')).to eq(false)
        end

        it 'returns the deleted field' do
          field = fields['x-header']
          deleted = fields.delete('x-header')
          expect(deleted).to eq(field)
        end
      end

      describe '#each' do
        it 'includes Enumerable' do
          expect(fields).to be_a(Enumerable)
        end

        it 'enumerates over its contents' do
          fields.each { |k, v| expect(fields[k]).to eq(v) }
        end
      end

      describe '#size' do
        it 'returns the number of fields' do
          expect(fields.size).to eq(2)
        end
      end

      describe '#clear' do
        it 'clears the fields' do
          fields.clear
          expect(fields.size).to eq(0)
        end
      end

      describe Fields::Proxy do
        let(:proxy) { Fields::Proxy.new(fields, :header) }

        describe '#[]' do
          it 'returns the field value' do
            expect(proxy['x-header']).to eq(header_field.value)
          end

          it 'returns nil if the kind of field does not exist' do
            expect(proxy['x-trailer']).to be_nil
          end

          context 'encoding' do
            let(:fields) { Fields.new([header_field], encoding: 'UTF-16') }

            it 'applies the encoding' do
              expect(proxy['x-header'].encoding).to eq(Encoding::UTF_16)
            end
          end
        end

        describe '#[]=' do
          it 'sets the field value and kind' do
            proxy['x-foo'] = 'bar'
            expect(fields['x-foo']).to be_a(Field)
            expect(fields['x-foo'].value).to eq('bar')
            expect(fields['x-foo'].kind).to eq(:header)
          end
        end

        describe '#key?' do
          it 'returns true if the field of that kind exists' do
            expect(proxy.key?('x-header')).to eq(true)
            expect(proxy.key?('x-trailer')).to eq(false)
          end
        end

        describe '#delete' do
          it 'deletes the kind of field' do
            proxy.delete('x-header')
            expect(fields.key?('x-header')).to eq(false)
            proxy.delete('x-trailer')
            expect(fields.key?('x-trailer')).to eq(true)
          end

          it 'returns the value of the deleted field' do
            header = proxy['x-header']
            deleted = proxy.delete('x-header')
            expect(deleted).to eq(header)
          end

          context 'encoding' do
            let(:fields) { Fields.new([header_field], encoding: 'UTF-16') }

            it 'applies the encoding' do
              expect(proxy.delete('x-header').encoding)
                .to eq(Encoding::UTF_16)
            end
          end
        end

        describe '#each' do
          it 'includes Enumerable' do
            expect(proxy).to be_a(Enumerable)
          end

          it 'returns the Field name and value for each field kind' do
            # not downcased header name
            expect(proxy.each.to_h).to eq('X-Header' => 'foo')
          end

          context 'encoding' do
            let(:fields) { Fields.new([header_field], encoding: 'UTF-16') }

            it 'applies the encoding' do
              expect(proxy.each.to_h['X-Header'].encoding)
                .to eq(Encoding::UTF_16)
            end
          end
        end
      end
    end
  end
end
