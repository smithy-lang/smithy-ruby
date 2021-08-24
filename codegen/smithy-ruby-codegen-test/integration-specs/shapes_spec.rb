# frozen_string_literal: true

require_relative 'spec_helper'

module SampleService
  module Shapes
    describe GetHighScoreInput do
      let(:id) { 'string'}
      let(:params) { {id: id} }

      it 'accepts a string' do
        shape = GetHighScoreInput.build(params, 'params')
        expect(shape).to be_a(GetHighScoreInput)
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
          UpdateHighScoreInput.build(params, 'params')
        end
      end

      context ':high_score set' do
        let(:high_score) { {} }
        it 'builds with :high_score' do
          shape = UpdateHighScoreInput.build(params, 'params')
          expect(shape).to be_a(UpdateHighScoreInput)
          expect(shape.high_score).to be_a(HighScoreParams)
        end
      end
    end

    describe SimpleList do
      it 'raises when not an array' do
        expect do
          SimpleList.build({}, 'input')
        end.to raise_error(ArgumentError, 'Expected input to be in [Array], got Hash.')
      end

      it 'builds all of the members' do
        shape = SimpleList.build(['a', 'b', 'c'], 'input')
        expect(shape).to be_a(SimpleList)
        expect(shape).to eq ['a', 'b', 'c']
      end
    end

    describe ComplexList do
      let(:high_score) { Shapes::HighScoreAttributes.new }
      it 'raises when not an array' do
        expect do
          ComplexList.build({}, 'input')
        end.to raise_error(ArgumentError, 'Expected input to be in [Array], got Hash.')
      end

      it 'builds all of the members' do
        shape = ComplexList.build([high_score, high_score], 'input')
        expect(shape).to be_a(ComplexList)
        expect(shape).to eq [high_score, high_score]
      end

      it 'builds all of the members and raises when any are invalid' do
        expect do
          ComplexList.build([high_score, high_score, 1], 'input')
        end.to raise_error(ArgumentError, 'Expected input[2] to be Hash like, got Integer.')
      end
    end

    describe SimpleMap do
      it 'raises when not a hash' do
        expect do
          SimpleMap.build([], 'input')
        end.to raise_error(ArgumentError, 'Expected input to be in [Hash], got Array.')
      end

      it 'builds all of the members' do
        h = {'a' => 1, 'b' => 2}
        shape = SimpleMap.build(h, 'input')
        expect(shape).to be_a(SimpleMap)
        expect(shape).to eq h
      end
    end
  end
end
