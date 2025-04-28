# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/net_http'

module Smithy
  module Client
    module Plugins
      describe NetHTTP do
        let(:client_class) do
          client_class = ClientHelper.sample_client.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(NetHTTP)
          client_class
        end

        it 'adds net http options' do
          options = %i[
            http_continue_timeout
            http_keep_alive_timeout
            http_open_timeout
            http_read_timeout
            http_ssl_timeout
            http_write_timeout
            http_ca_file
            http_ca_path
            http_cert
            http_cert_store
            http_key
            http_verify_mode
            http_debug_output
            http_proxy
          ]
          client = client_class.new
          options.each do |option|
            expect(client.config).to respond_to(option)
          end
        end
      end
    end
  end
end
