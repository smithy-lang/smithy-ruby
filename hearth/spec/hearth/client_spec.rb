# frozen_string_literal: true

module Hearth
  module Test
    Config = Struct.new(
      :stub_responses, :stubs, :plugins, :interceptors, keyword_init: true
    ) do
      include Hearth::Configuration
      def validate!
        Hearth::Validator.validate_types!(
          stub_responses, TrueClass,
          FalseClass, context: 'config[:stub_responses]'
        )
        Hearth::Validator.validate_types!(
          stubs, Hearth::Stubs,
          context: 'config[:stubs]'
        )
        Hearth::Validator.validate_types!(
          plugins, Hearth::PluginList,
          context: 'config[:plugins]'
        )
        Hearth::Validator.validate_types!(
          interceptors,
          Hearth::InterceptorList, context: 'config[:interceptors]'
        )
      end

      private

      def _defaults
        {
          interceptors: [Hearth::InterceptorList.new],
          plugins: [Hearth::PluginList.new],
          stub_responses: [false],
          stubs: [Hearth::Stubs.new]
        }.freeze
      end
    end

    class Client < Hearth::Client
      def initialize(options = {})
        super(options, Config)
      end

      def operation(_params = {}, options = {})
        operation_config(options)
      end

      def operation_body_stream(_params = {}, options = {}, &block)
        output_stream(options, &block)
      end
    end
  end

  describe Client do
    let(:subject) { Test::Client.new(stub_responses: true) }
    let(:plugin) { proc { |_cfg| } }
    let(:interceptor) do
      Class.new do
        def read_before_signing(*args); end
      end.new
    end

    after(:each) do
      # cleanup any class plugins
      Test::Client.instance_variable_set(:@plugins, nil)
    end

    describe '#initialize' do
      it 'creates config from provided options' do
        expect(subject.config.stub_responses).to be(true)
      end

      it 'validates config' do
        expect do
          Test::Client.new(stub_responses: 'not a boolean')
        end.to raise_error(ArgumentError, /config\[:stub_responses\]/)
      end

      it 'calls each Class plugin' do
        Test::Client.plugins << plugin
        expect(plugin).to receive(:call)
        Test::Client.new
      end

      it 'calls each plugin from initialize' do
        expect(plugin).to receive(:call)
        Test::Client.new(plugins: PluginList.new([plugin]))
      end

      it 'appends interceptors' do
        client = Test::Client.new(interceptors: [interceptor])
        expect(client.config.interceptors.to_a).to include(interceptor)
      end
    end

    describe '#inspect' do
      it 'is the class name without instance variables' do
        expect(subject.inspect).to eq('#<Hearth::Test::Client>')
      end
    end

    describe '#operation_config' do
      it 'raises errors if stub_responses is set' do
        expect do
          subject.operation({}, stub_responses: true)
        end.to raise_error(ArgumentError, /not allowed/)
      end

      it 'raises errors if stubs is set' do
        expect do
          subject.operation({}, stubs: {})
        end.to raise_error(ArgumentError, /not allowed/)
      end

      it 'returns a config object' do
        expect(subject.operation).to be_a(Test::Config)
      end

      it 'has the same values as the client config' do
        expect(subject.operation).to eq(subject.config)
      end

      it 'calls operation plugins' do
        expect(plugin).to receive(:call)
        subject.operation({}, plugins: [plugin])
      end

      it 'appends operation interceptors' do
        config = subject.operation({}, interceptors: [interceptor])
        expect(config.interceptors.to_a).to eq([interceptor])
      end
    end

    describe '#output_stream' do
      let(:output_stream) { double }

      it 'uses the given output_stream when provided' do
        expect(
          subject.operation_body_stream(
            {}, output_stream: output_stream
          )
        ).to eq(output_stream)
      end

      it 'creates a blockIO when a block is given' do
        expect(
          subject.operation_body_stream { nil }
        ).to be_a(Hearth::BlockIO)
      end

      it 'defaults to a StringIO' do
        expect(subject.operation_body_stream).to be_a(StringIO)
      end
    end
  end
end
