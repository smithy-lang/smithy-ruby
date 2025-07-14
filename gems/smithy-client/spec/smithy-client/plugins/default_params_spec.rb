# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module Plugins
      describe ParamValidator do
        let(:sample_client) { ClientHelper.sample_client }
        let(:client_class) { sample_client.const_get(:Client) }
        let(:client) { client_class.new(stub_responses: true) }

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
