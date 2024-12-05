# frozen_string_literal: true

module Smithy
  module Client
    describe Operation do
      subject { Operation.new }

      describe '#initialize' do
        it 'yields itself' do
          yielded = nil
          subject = Operation.new { |api| yielded = api }
          expect(yielded).to be(subject)
        end
      end

      describe '#name' do
        it 'defaults to nil' do
          expect(subject.name).to be(nil)
        end

        it 'can be set' do
          subject.name = 'OperationName'
          expect(subject.name).to eq('OperationName')
        end
      end

      describe '#input' do
        it 'defaults to nil' do
          expect(subject.input).to be(nil)
        end

        it 'can be set' do
          shape = double('shape')
          subject.input = shape
          expect(subject.input).to be(shape)
        end
      end

      describe '#output' do
        it 'defaults to nil' do
          expect(subject.output).to be(nil)
        end

        it 'can be set' do
          shape = double('shape')
          subject.output = shape
          expect(subject.output).to be(shape)
        end
      end

      describe '#errors' do
        it 'defaults to []' do
          expect(subject.errors).to eq([])
        end

        it 'can be set' do
          shape = double('shape')
          subject.errors = [shape]
          expect(subject.errors).to eq([shape])
        end

        it 'can be appended to' do
          shape = double('shape')
          subject.errors << shape
          expect(subject.errors).to eq([shape])
        end
      end
    end
  end
end
