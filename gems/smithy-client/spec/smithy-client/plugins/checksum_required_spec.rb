# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/checksum_required'

module Smithy
  module Client
    module Plugins
      describe ChecksumRequired do
        let(:shapes) { ClientHelper.sample_shapes }
        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }

        let(:client_class) do
          client_class = sample_client.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(sample_client::Plugins::Endpoint)
          client_class.add_plugin(ChecksumRequired)
          client_class.add_plugin(Protocol)
          client_class.add_plugin(ResolveAuth)
          client_class.add_plugin(StubResponses)
          client_class
        end

        let(:client) { client_class.new(stub_responses: true) }

        before do
          shapes['smithy.ruby.tests#Operation']['traits'] = { 'smithy.api#httpChecksumRequired' => {} }
        end

        it 'adds the handler' do
          expect(client.handlers).to include(ChecksumRequired::Handler)
        end

        it 'calculates md5 checksums in chunks and puts it in the header' do
          body = StringIO.new('.' * 5 * 1024 * 1024) # 5MB
          allow(body).to receive(:read).and_call_original # codec read
          allow(body).to receive(:read).with(1024 * 1024, any_args).and_call_original
          response = client.operation(streaming_blob: body)
          expect(response.context.http_request.headers['Content-Md5']).to eq('pAFSSYDaTfRd1BEr40kHGA==')
        end

        it 'calculates checksums before signing' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBearerAuth'] = {}
          client_class.add_plugin(HttpBearerAuth)
          checksum_handler = ChecksumRequired::Handler
          expect_any_instance_of(checksum_handler).to receive(:call).and_wrap_original do |method, context|
            expect(context.http_request.headers['Authorization']).to be_nil
            method.call(context)
          end
          auth_handler = HttpBearerAuth::Handler
          expect_any_instance_of(auth_handler).to receive(:sign).and_wrap_original do |method, context|
            expect(context.http_request.headers['Content-Md5']).to_not be_nil
            method.call(context)
          end
          client = client_class.new(stub_responses: true)
          client.operation(string: 'i am just a string')
        end
      end
    end
  end
end
