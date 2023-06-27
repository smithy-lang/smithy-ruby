# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Client do

    describe 'client class plugins' do
      it 'adds plugins to the client class' do
        expect(Client.plugins.size).to eq(1)
        expect(Client.plugins.first.class).to eq(Plugins::TestPlugin)
      end

      it 'applies plugins to modify config during initialize' do
        config = Config.new
        expect(config.test_config).to eq('default')
        client = Client.new(config)
        expect(client.instance_variable_get(:@config).test_config).to eq('client_override')
        expect(config.test_config).to eq('default')
      end
    end

    describe 'configured plugins' do
      it 'applies user configured plugins after client class plugins' do
        config = Config.new(plugins: [WhiteLabel::Plugins::TestPlugin.new(override_value: 'user_override')])
        client = Client.new(config)
        expect(client.instance_variable_get(:@config).test_config).to eq('user_override')
      end
    end

    describe 'operation plugins' do
      it 'applies operation plugins' do
        config = Config.new(stub_responses: true)
        client = Client.new(config)
        output = client.kitchen_sink(
          {},
          {plugins: [
            WhiteLabel::Plugins::TestPlugin.new(override_value: 'operation_override')]
          })
        expect(output.metadata[:test_config]).to eq('operation_override')
        # does not modify client config
        expect(client.instance_variable_get(:@config).test_config).to eq('client_override')
      end
    end
  end
end
