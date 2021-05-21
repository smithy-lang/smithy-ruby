# frozen_string_literal: true

module Seahorse
  module Stubbing
    describe Stubs do
      let(:stub1) { { data: 1 } }
      let(:stub2) { { data: 2 } }

      describe '#add_stubs' do
        it 'is synchronized' do
          mutex = subject.instance_variable_get('@stub_mutex')
          expect(mutex).to receive(:synchronize)
          subject.add_stubs(:operation, [stub1])
        end

        it 'overwrites the previous stub' do
          subject.add_stubs(:operation, [stub1])
          subject.add_stubs(:operation, [stub2])
          expect(subject.next(:operation)).to eq(stub2)
        end
      end

      describe '#next' do
        context 'zero stubs' do
          it 'returns an empty hash' do
            expect(subject.next(:operation)).to eq({})
          end
        end

        context 'one stub' do
          before { subject.add_stubs(:operation, [stub1]) }

          it 'returns the stub multiple times' do
            expect(subject.next(:operation)).to eq(stub1)
            expect(subject.next(:operation)).to eq(stub1)
          end
        end

        context 'multiple stubs' do
          before { subject.add_stubs(:operation, [stub1, stub2]) }

          it 'returns the first stub and then the last multiple times' do
            expect(subject.next(:operation)).to eq(stub1)
            expect(subject.next(:operation)).to eq(stub2)
            expect(subject.next(:operation)).to eq(stub2)
          end
        end
      end
    end
  end
end
