# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/user_agent'

module Smithy
  module Client
    module Plugins
      describe UserAgent do
        let(:client_class) do
          client_class = ClientHelper.sample_client.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(DummySendPlugin)
          client_class.add_plugin(UserAgent)
          client_class
        end

        let(:client) { client_class.new }

        it 'adds user agent header to request' do
          resp = client.operation
          ua_header = resp.context.http_request.headers['user-agent']
          expect(ua_header).to_not be_nil
          expect(ua_header).to include('smithy-ruby')
          expect(ua_header).to include('os')
          expect(ua_header).to include('lang/ruby')
        end
      end
    end
  end
end