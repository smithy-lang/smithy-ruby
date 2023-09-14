# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    describe 'client class plugins' do
      it 'applies plugins to modify config during initialize' do
        config = Config.new
        expect(config.test_config).to eq('default')
        client = Client.new
        expect(client.config.test_config).to eq('client_override')
      end
    end

    describe 'configured plugins' do
      it 'applies user configured plugins after client class plugins' do
        plugin_list = Hearth::PluginList.new
        plugin_list << WhiteLabel::Plugins::TestPlugin.new(
          override_value: 'user_override'
        )
        client = Client.new(plugins: plugin_list)
        expect(client.config.test_config).to eq('user_override')
      end
    end

    describe 'operation plugins' do
      it 'applies operation plugins' do
        client = Client.new(stub_responses: true)
        output = client.kitchen_sink(
          {},
          { plugins: [
            WhiteLabel::Plugins::TestPlugin.new(
              override_value: 'operation_override'
            )
          ] }
        )
        expect(output.metadata[:test_config]).to eq('operation_override')
        # does not modify client config
        expect(client.config.test_config).to eq('client_override')
      end
    end
  end
end
