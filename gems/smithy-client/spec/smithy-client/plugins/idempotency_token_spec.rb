# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/idempotency_token'

module Smithy
  module Client
    module Plugins
      describe IdempotencyToken do
        let(:shapes) { ClientHelper.sample_shapes }
        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }
        let(:client_class) { sample_client.const_get(:Client) }
        let(:client) { client_class.new(stub_responses: true) }

        before do
          shapes['smithy.ruby.tests#Structure']['members']['string'] = {
            'target' => 'smithy.api#String',
            'traits' => { 'smithy.api#idempotencyToken' => {} }
          }
        end

        it 'adds the handler' do
          expect(client.handlers).to include(IdempotencyToken::Handler)
        end

        it 'applies the idempotency token to params' do
          expect(SecureRandom).to receive(:uuid).and_return('uuid')
          output = client.operation
          expect(output.context.params[:string]).to eq('uuid')
        end

        it 'does not overwrite an existing idempotency token' do
          expect(SecureRandom).not_to receive(:uuid)
          output = client.operation(string: 'existing_token')
          expect(output.context.params[:string]).to eq('existing_token')
        end

        it 'applies the idempotency token before building the request' do
          expect(SecureRandom).to receive(:uuid).and_return('uuid')
          expect_any_instance_of(Protocol::BuildHandler).to receive(:call).and_wrap_original do |method, context|
            expect(context.params[:string]).to eq('uuid')
            method.call(context)
          end
          client.operation
        end
      end
    end
  end
end
