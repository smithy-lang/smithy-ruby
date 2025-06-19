# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/default_params'

module Smithy
  module Client
    module Plugins
      describe ParamValidator do
        let(:sample_client) { ClientHelper.sample_client }

        let(:client_class) do
          client_class = sample_client.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(DefaultParams)
          client_class.add_plugin(DummySendPlugin)
          client_class
        end

        let(:client) { client_class.new }

        it 'adds the handler' do
          expect(client.handlers).to include(DefaultParams::Handler)
        end

        it 'calls the default params class' do
          params = {}
          input = client.config.service.operation(:operation).input
          expect(Client::DefaultParams).to receive(:new).with(input).and_call_original
          expect_any_instance_of(Client::DefaultParams).to receive(:apply).with(params).and_call_original
          client.operation(params)
        end
      end
    end
  end
end
