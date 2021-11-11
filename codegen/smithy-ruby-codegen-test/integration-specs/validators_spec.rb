# frozen_string_literal: true

require_relative 'spec_helper'

module SampleService
  module Validators
    describe GetHighScoreInput do
      let(:id) { 'string'}
      let(:input) { Types::GetHighScoreInput.new(id: id) }

      it 'accepts a string' do
        GetHighScoreInput.validate!(input, context: 'input')
      end

      context 'id is not a string' do
        let(:id) { 1 }

        it 'raises an ArgumentError with the context' do
          expect {
            GetHighScoreInput.validate!(input, context: 'input')
          }.to raise_error(ArgumentError, 'Expected input[:id] to be in [String], got Integer.')
        end
      end
    end
    describe UpdateHighScoreInput do
      let(:id) { 'string' }
      let(:high_score) { nil }
      let(:input) { Types::UpdateHighScoreInput.new(id: id, high_score: high_score) }

      context ':high_score not set' do
        it 'does not validate :high_score' do
          expect(HighScoreParams).not_to receive(:validate!)
          UpdateHighScoreInput.validate!(input, context: 'input')
        end
      end

      context ':high_score set' do
        let(:high_score) { Types::HighScoreParams.new }
        it 'validates :high_score' do
          expect(HighScoreParams).to receive(:validate!)
          UpdateHighScoreInput.validate!(input, context: 'input')
        end
      end
    end

    describe SimpleList do
      it 'raises when not an array' do
        expect do
          SimpleList.validate!({}, context: 'input')
        end.to raise_error(ArgumentError, 'Expected input to be in [Array], got Hash.')
      end

      it 'validates all of the members' do
        SimpleList.validate!(['a', 'b', 'c'], context: 'input')
      end

      it 'validates all of the members and raises when any are invalid' do
        expect do
          SimpleList.validate!(['a', 'b', 1], context: 'input')
        end.to raise_error(ArgumentError, 'Expected input[2] to be in [String], got Integer.')
      end
    end

    describe ComplexList do
      let(:high_score) { Types::HighScoreAttributes.new }
      it 'raises when not an array' do
        expect do
          ComplexList.validate!({}, context: 'input')
        end.to raise_error(ArgumentError, 'Expected input to be in [Array], got Hash.')
      end

      it 'validates all of the members' do
        ComplexList.validate!([high_score, high_score], context: 'input')
      end

      # TODO: This test is currently broken - requires rework of input (Shape) building + validation
      # it 'validates all of the members and raises when any are invalid' do
      #   #expect do
      #   ComplexList.validate!([high_score, high_score, 1], context: 'input')
      #     # end.to raise_error(ArgumentError, 'Expected input[2] to be in [SampleService::Types::HighScoreAttributes.], got Integer.')
      # end
    end

    describe Document do
      it 'validates an empty document' do
        Document.validate!({}, context: 'input')
      end

      it 'validates a top level String' do
        Document.validate!('string', context: 'input')
      end

      it 'validates a top level Numeric' do
        Document.validate!(1.0, context: 'input')
      end

      it 'validates a top level Array' do
        Document.validate!(['string'], context: 'input')
      end

      it 'validates a top level boolean' do
        Document.validate!(true, context: 'input')
      end

      it 'validates a top level nil' do
        Document.validate!(nil, context: 'input')
      end

      it 'validates a hash' do
        Document.validate!({'key' => 'string'}, context: 'input')
      end

      it 'raises when given a top level non Document type' do
        expect do
          Document.validate!(Types::HighScoreAttributes.new, context: 'input')
        end.to raise_error(ArgumentError, /Expected input to be in \[Hash, String, Array, TrueClass, FalseClass, Numeric\]/)
      end

      it 'raises when given a nested non Document type' do
        expect do
          Document.validate!({'key' => {'nestedKey' => [Types::HighScoreAttributes.new] } }, context: 'input')
        end.to raise_error(ArgumentError, /Expected input\[key\]\[nestedKey\]\[0\] to be in \[Hash, String, Array, TrueClass, FalseClass, Numeric\]/)
      end
    end
  end
end
