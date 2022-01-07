# frozen_string_literal: true

require_relative 'spec_helper'

module SampleService
  module Params
    describe GetHighScoreInput do
      let(:id) { 'string'}
      let(:params) { {id: id} }

      it 'accepts a string' do
        shape = GetHighScoreInput.build(params, context: 'params')
        expect(shape).to be_a(Types::GetHighScoreInput)
        expect(shape.id).to eq(id)
      end
    end

    describe UpdateHighScoreInput do
      let(:id) { 'string' }
      let(:high_score) { nil }
      let(:params) { {id: id, high_score: high_score} }

      context ':high_score not set' do
        it 'does not build :high_score' do
          expect(HighScoreParams).not_to receive(:build)
          UpdateHighScoreInput.build(params, context: 'params')
        end
      end

      context ':high_score set' do
        let(:high_score) { {} }
        it 'builds with :high_score' do
          shape = UpdateHighScoreInput.build(params, context: 'params')
          expect(shape).to be_a(Types::UpdateHighScoreInput)
          expect(shape.high_score).to be_a(Types::HighScoreParams)
        end
      end
    end

    describe SimpleList do
      it 'raises when not an array' do
        expect do
          SimpleList.build({}, context: 'params')
        end.to raise_error(ArgumentError, 'Expected params to be in [Array], got Hash.')
      end

      it 'builds all of the members' do
        shape = SimpleList.build(['a', 'b', 'c'], context: 'params')
        expect(shape).to be_a(Array)
        expect(shape).to eq ['a', 'b', 'c']
      end
    end

    describe ComplexList do
      let(:high_score) { Types::HighScoreAttributes.new }
      it 'raises when not an array' do
        expect do
          ComplexList.build({}, context: 'params')
        end.to raise_error(ArgumentError, 'Expected params to be in [Array], got Hash.')
      end

      it 'builds all of the members' do
        shape = ComplexList.build([high_score, high_score], context: 'params')
        expect(shape).to be_a(Array)
        expect(shape).to eq [high_score, high_score]
      end

      it 'builds all of the members and raises when any are invalid' do
        expect do
          ComplexList.build([high_score, high_score, 1], context: 'params')
        end.to raise_error(ArgumentError, 'Expected params[2] to be in [Hash, SampleService::Types::HighScoreAttributes(keyword_init: true)], got Integer.')
      end
    end

    describe SimpleSet do
      it 'raises when not an array or set' do
        expect do
          SimpleSet.build({}, context: 'params')
        end.to raise_error(ArgumentError, 'Expected params to be in [Set, Array], got Hash.')
      end

      it 'accepts a set and builds all of the members' do
        shape = SimpleSet.build(Set.new(['a', 'b', 'c']), context: 'params')
        expect(shape).to be_a(Set)
        expect(shape).to include('a', 'b', 'c')
      end

      it 'accepts an array with duplicates and builds all of the members' do
        shape = SimpleSet.build(['a', 'a', 'b'], context: 'params')
        expect(shape).to be_a(Set)
        expect(shape.size).to be 2
        expect(shape).to include('a', 'b')
      end
    end

    describe ComplexSet do
      let(:high_score) { Types::HighScoreAttributes.new }
      it 'raises when not an array or set' do
        expect do
          ComplexSet.build({}, context: 'params')
        end.to raise_error(ArgumentError, 'Expected params to be in [Set, Array], got Hash.')
      end

      it 'builds all of the members' do
        shape = ComplexSet.build([high_score, high_score], context: 'params')
        expect(shape).to be_a(Set)
        expect(shape).to include(high_score)
      end

      it 'builds all of the members and raises when any are invalid' do
        expect do
          ComplexSet.build([high_score, 1], context: 'params')
        end.to raise_error(ArgumentError, 'Expected params[1] to be in [Hash, SampleService::Types::HighScoreAttributes(keyword_init: true)], got Integer.')
      end
    end


    describe SimpleMap do
      it 'raises when not a hash' do
        expect do
          SimpleMap.build([], context: 'params')
        end.to raise_error(ArgumentError, 'Expected params to be in [Hash], got Array.')
      end

      it 'builds all of the members' do
        h = {'a' => 1, 'b' => 2}
        shape = SimpleMap.build(h, context: 'params')
        expect(shape).to be_a(Hash)
        expect(shape).to eq h
      end
    end
  end
end
