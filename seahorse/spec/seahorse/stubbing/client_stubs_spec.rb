# frozen_string_literal: true

module Seahorse
  class TestClient
    include ClientStubs

    def initialize(stubs:, stub_responses: false)
      @stub_responses = stub_responses
      @stubs = stubs
    end

    attr_accessor :stubs
  end

  describe ClientStubs do
    let(:stub_responses) { false }
    let(:stubs) { double('stubs') }

    subject do
      TestClient.new(
        stubs: stubs,
        stub_responses: stub_responses
      )
    end

    describe '#stub_responses' do
      context 'stub_responses is true' do
        let(:stub_responses) { true }
        let(:stub_data) { { data: 'value' } }

        it 'adds to stubs' do
          expect(stubs).to receive(:add_stubs).with(:operation, [stub_data])
          subject.stub_responses(:operation, stub_data)
        end

        it 'adds multiple data values to stubs' do
          expect(stubs).to receive(:add_stubs)
            .with(:operation, [stub_data, stub_data])
          subject.stub_responses(:operation, stub_data, stub_data)
        end

        context '@stubs not initialized' do
          subject do
            TestClient.new(stub_responses: stub_responses, stubs: nil)
          end

          it 'creates a new Stub and adds to it' do
            expect(Stubbing::Stubs).to receive(:new).and_return(stubs)
            expect(stubs).to receive(:add_stubs).with(:operation, [stub_data])
            subject.stub_responses(:operation, stub_data)
          end
        end
      end

      context 'stub_responses is false' do
        let(:stub_responses) { false }

        it 'raises an ArgumentError' do
          expect do
            subject.stub_responses(:operation, {})
          end.to raise_error(ArgumentError)
        end
      end
    end
  end
end
