# frozen_string_literal: true

module Hearth
  module Test
    Config = Struct.new(:stub_responses, keyword_init: true)

    class Client
      include ClientStubs

      def initialize(config = Config.new)
        @config = config
        @stubs = Hearth::Stubs.new
      end

      # for testing
      attr_reader :stubs
    end
  end

  describe ClientStubs do
    let(:config) { Test::Config.new(stub_responses: stub_responses) }
    subject { Test::Client.new(config) }

    describe '#stub_responses' do
      context 'stub_responses is true' do
        let(:stub_responses) { true }
        let(:stub_data) { { data: 'value' } }

        it 'adds to stubs' do
          expect(subject.stubs).to receive(:set_stubs)
            .with(:operation, [stub_data])
          subject.stub_responses(:operation, stub_data)
        end

        it 'adds multiple data values to stubs' do
          expect(subject.stubs).to receive(:set_stubs)
            .with(:operation, [stub_data, stub_data])
          subject.stub_responses(:operation, stub_data, stub_data)
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
