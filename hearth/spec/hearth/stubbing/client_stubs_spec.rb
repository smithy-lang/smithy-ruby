# frozen_string_literal: true

module Hearth
  module TestClientStubs
    class Config
      MEMBERS = %i[
        stub_responses
        stubs
      ].freeze

      include Hearth::Configuration

      attr_accessor(*MEMBERS)

      private

      def _defaults
        {
          stubs: [Hearth::Stubs.new]
        }.freeze
      end
    end

    class Client
      include ClientStubs

      def initialize(config = Config.new)
        @config = config
      end

      attr_accessor :config
    end
  end

  describe ClientStubs do
    let(:config) do
      TestClientStubs::Config.new(stub_responses: stub_responses)
    end

    subject { TestClientStubs::Client.new(config) }

    describe '#stub_responses' do
      context 'stub_responses is true' do
        let(:stub_responses) { true }
        let(:stub_data) { { data: 'value' } }

        it 'adds to stubs' do
          expect(subject.config.stubs).to receive(:set_stubs)
            .with(:operation, [stub_data])
          subject.stub_responses(:operation, stub_data)
        end

        it 'adds multiple data values to stubs' do
          expect(subject.config.stubs).to receive(:set_stubs)
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
