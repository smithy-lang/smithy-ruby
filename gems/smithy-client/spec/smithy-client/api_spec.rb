# frozen_string_literal: true

module Smithy
  module Client
    describe API do
      subject { API.new }

      it 'is enumerable' do
        expect(subject).to be_kind_of(Enumerable)
      end

      describe '#initialize' do
        it 'yields itself' do
          yielded = nil
          subject = API.new { |api| yielded = api }
          expect(yielded).to be(subject)
        end
      end

      describe '#version' do
        it 'defaults to nil' do
          expect(subject.version).to be(nil)
        end

        it 'can be set' do
          subject.version = '2015-01-01'
          expect(subject.version).to eq('2015-01-01')
        end
      end

      describe '#metadata' do
        it 'defaults to {}' do
          expect(subject.metadata).to eq({})
        end

        it 'can be populated' do
          subject.metadata['key'] = 'value'
          expect(subject.metadata['key']).to eq('value')
        end
      end

      describe '#each' do
        it 'enumerates over operations' do
          operation = Operation.new
          subject.add_operation(:name, operation)
          expect { |b| subject.each(&b) }.to yield_successive_args([:name, operation])
        end
      end

      describe '#add_operation' do
        it 'adds an operation' do
          operation = Operation.new
          subject.add_operation(:name, operation)
          expect(subject.operation(:name)).to be(operation)
        end
      end

      describe '#operation' do
        it 'raises an ArgumentError for unknown operations' do
          expect do
            subject.operation(:unknown)
          end.to raise_error(ArgumentError, 'unknown operation :unknown')
        end

        it 'returns the operation' do
          operation = Operation.new
          subject.add_operation(:name, operation)
          expect(subject.operation(:name)).to be(operation)
        end
      end

      describe '#operation_names' do
        it 'defaults to an empty array' do
          expect(subject.operation_names).to eq([])
        end

        it 'provides operation names' do
          subject.add_operation(:operation1, Operation.new)
          subject.add_operation(:operation2, Operation.new)
          expect(subject.operation_names).to eq(%i[operation1 operation2])
        end
      end

      describe '#inspect' do
        it 'returns the class name' do
          expect(subject.inspect).to eq('#<Smithy::Client::API>')
        end
      end
    end
  end
end
