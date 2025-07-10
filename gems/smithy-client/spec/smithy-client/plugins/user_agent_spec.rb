# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/user_agent'

module Smithy
  module Client
    module Plugins
      describe UserAgent do
        let(:client_class) { ClientHelper.sample_client.const_get(:Client) }
        let(:client) { client_class.new(stub_responses: true) }

        it 'adds a user agent header to request' do
          resp = client.operation
          ua_header = resp.context.http_request.headers['user-agent']
          expect(ua_header).to_not be_nil
          expect(ua_header).to include('smithy-ruby')
          expect(ua_header).to include('macos').or include('linux').or include('windows').or include('other')
          expect(ua_header).to include('ruby')
        end

        it 'adds a user agent suffix to user agent string when configured' do
          client = client_class.new(user_agent_suffix: 'test-suffix', stub_responses: true)
          resp = client.operation
          ua_header = resp.context.http_request.headers['user-agent']
          expect(ua_header).to end_with('test-suffix')
        end
      end
    end
  end
end
