# frozen_string_literal: true

module Hearth
  module HTTP
    describe Fields do
      let(:header_field) { Field.new('X-Header', 'foo') }
      let(:trailer_field) { Field.new('X-Trailer', 'bar', kind: :trailer) }

      let(:fields) { Fields.new([header_field, trailer_field]) }
      subject { fields }

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
          expect(subject['x-header']).to eq(header_field)
        end
      end

      describe '#[]=' do
        it 'raises when field is not a Field' do
          expect { subject['x-header'] = 'not a field' }
            .to raise_error(ArgumentError)
        end

        it 'sets the field' do
          subject['x-header'] = Field.new('X-Header', 'bar')
          expect(subject['x-header'].value).to eq('bar')
        end
      end

      describe '#key?' do
        it 'returns true if the field exists' do
          expect(subject.key?('x-header')).to eq(true)
          expect(subject.key?('x-trailer')).to eq(true)
          expect(subject.key?('x-foo')).to eq(false)
        end
      end

      describe '#delete' do
        it 'deletes the field' do
          field = subject['x-header']
          deleted = subject.delete('x-header')
          expect(deleted).to eq(field)
          expect(subject.key?('x-header')).to eq(false)
          expect(subject['x-header']).to eq(nil)
        end
      end

      describe '#each' do
        it 'includes Enumerable' do
          expect(subject).to be_a(Enumerable)
        end

        it 'enumerates over its contents' do
          subject.each { |k, v| expect(subject[k]).to eq(v) }
        end
      end

      describe '#size' do
        it 'returns the number of fields' do
          expect(subject.size).to eq(2)
        end
      end

      describe '#clear' do
        it 'clears the fields' do
          subject.clear
          expect(subject.size).to eq(0)
        end
      end

      describe Fields::Proxy do
        subject { Fields::Proxy.new(fields, :header) }

        describe '#[]' do
          it 'returns the field value' do
            expect(subject['x-header']).to eq(header_field.value)
          end

          it 'returns nil if the kind of field does not exist' do
            expect(subject['x-trailer']).to be_nil
          end
        end

        describe '#[]=' do
          it 'sets the field value and kind' do
            subject['x-foo'] = 'bar'
            expect(fields['x-foo']).to be_a(Field)
            expect(fields['x-foo'].value).to eq('bar')
            expect(fields['x-foo'].kind).to eq(:header)
          end
        end

        describe '#key?' do
          it 'returns true if the field of that kind exists' do
            expect(subject.key?('x-header')).to eq(true)
            expect(subject.key?('x-trailer')).to eq(false)
          end
        end

        describe '#each' do
          it 'includes Enumerable' do
            expect(subject).to be_a(Enumerable)
          end

          it 'returns the Field name and value for each field kind' do
            # not downcased header name
            expect(subject.each.to_h).to eq('X-Header' => 'foo')
          end
        end
      end
    end
  end
end
