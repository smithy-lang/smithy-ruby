# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    let(:interceptor_class) do
      Class.new do
        def initialize(name = 'NA')
          @name = name
        end

        def read_before_execution(context); end
      end
    end

    let(:interceptor) { interceptor_class.new }
    let(:hook) { :read_before_execution }

    describe 'client configured interceptor' do
      it 'calls interceptor hook' do
        client = Client.new(
          stub_responses: true,
          interceptors: Hearth::InterceptorList.new([interceptor])
        )

        expect(interceptor).to receive(hook)
          .with(instance_of(Hearth::InterceptorContext))

        client.kitchen_sink
      end
    end

    describe 'operation configured interceptor' do
      it 'calls interceptor hook' do
        client = Client.new(stub_responses: true)

        expect(interceptor).to receive(hook)
          .with(instance_of(Hearth::InterceptorContext))

        client.kitchen_sink({}, interceptors: [interceptor])
      end
    end

    describe 'interceptor precedence' do
      # * Interceptors registered via Class level plugins
      # * Interceptors registered via config plugins (eg config.plugins)
      # * Interceptors registered via config (eg, config.interceptors).
      # * Interceptors registered via operation-level plugins.
      # * Interceptors registered via operation-level options (passed directly).

      let(:config_plugin_interceptor) { interceptor_class.new('cfg_plg') }
      let(:config_interceptor) { interceptor_class.new('cfg_int') }
      let(:operation_plugin_interceptor) { interceptor_class.new('op_plg') }
      let(:operation_interceptor) { interceptor_class.new('op') }

      let(:config_plugin) do
        proc { |cfg| cfg.interceptors << config_plugin_interceptor }
      end

      let(:operation_plugin) do
        proc { |cfg| cfg.interceptors << operation_plugin_interceptor }
      end

      let(:client) do
        Client.new(
          stub_responses: true,
          plugins: Hearth::PluginList.new([config_plugin]),
          interceptors: Hearth::InterceptorList.new([config_interceptor])
        )
      end

      it 'applies interceptors in expected order' do
        expect(Plugins::TestPlugin::TEST_CLASS_INTERCEPTOR)
          .to receive(hook).ordered
        expect(config_plugin_interceptor).to receive(hook).ordered
        expect(config_interceptor).to receive(hook).ordered
        expect(operation_plugin_interceptor).to receive(hook).ordered
        expect(operation_interceptor).to receive(hook).ordered

        client.kitchen_sink(
          {},
          plugins: [operation_plugin],
          interceptors: [operation_interceptor]
        )
      end
    end
  end
end
