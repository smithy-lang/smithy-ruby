# frozen_string_literal: true

module Hearth
  module Query
    describe ParamList do
      subject { ParamList.new }

      describe '#set' do
        it 'returns a param' do
          expect(subject.set('name', 'value')).to be_kind_of(Param)
        end

        it 'sets a param with name and value' do
          param = subject.set('name', 'value')
          expect(param.name).to eq('name')
          expect(param.value).to eq('value')
        end

        it 'can set a param without a value' do
          param = subject.set('name')
          expect(param.name).to eq('name')
          expect(param.value).to be(nil)
        end
      end

      describe '#[]' do
        it 'gets the param by name' do
          param = subject.set('name')
          expect(subject['name']).to eq(param)
        end
      end

      describe '#delete' do
        it 'removes a returns a param' do
          param = subject.set('name', 'value')
          expect(subject.delete('name')).to be(param)
        end

        it 'returns nil if the param was not set' do
          expect(subject.delete('name')).to be(nil)
        end
      end

      describe '#empty?' do
        it 'returns true when empty' do
          expect(subject.empty?).to be(true)
        end

        it 'returns false when not empty' do
          subject.set('name', 'value')
          expect(subject.empty?).to be(false)
        end
      end

      describe '#each' do
        it 'returns an enumerable' do
          subject.set('name', 'value')
          subject.set('other_name', 'other_value')
          expect(subject.each).to be_a(Enumerable)
          expect(subject.each.to_a).to eq(subject.to_a)
        end
      end

      describe '#to_a' do
        it 'returns an array of sorted Param objects' do
          p1 = subject.set('name2')
          p2 = subject.set('name1', 'value')
          expect(subject.to_a).to eq([p2, p1])
        end
      end

      describe '#to_s' do
        it 'returns the params as a string' do
          subject.set('name', 'value')
          expect(subject.to_s).to eq('name=value')
        end

        it 'joins multiple params with an ampersand' do
          subject.set('name1', 'value')
          subject.set('name2', 'value')
          expect(subject.to_s).to eq('name1=value&name2=value')
        end

        it 'sorts params' do
          subject.set('name2', 'value')
          subject.set('name1', 'value')
          expect(subject.to_s).to eq('name1=value&name2=value')
        end

        it 'escapes names and values' do
          subject.set('param name', 'val=u!')
          expect(subject.to_s).to eq('param%20name=val%3Du%21')
        end
      end
    end
  end
end
