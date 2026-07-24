# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module Plugins
      describe TransferEncoding do
        let(:shapes) { ClientHelper.sample_shapes }
        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }
        let(:client_class) do
          klass = sample_client.const_get(:Client)
          # Replace the RPC protocol plugin (which serializes all params into the body)
          # with a passthrough that pipes the streaming member directly to the
          # HTTP body, mimicking REST protocol behavior.
          klass.remove_plugin(Plugins::Protocol)
          klass.add_plugin(streaming_body_plugin)
          klass
        end
        let(:client) { client_class.new(stub_responses: true, endpoint: 'https://example.com') }

        # An IO-like body without #size (simulates an unsizable streaming payload)
        let(:unsizable_body) { double('unsizable_body', read: '', rewind: nil) }

        let(:streaming_body_plugin) do
          handler_class = Class.new(Client::Handler) do
            def call(context)
              context.operation.input.members.each do |name, shape|
                if shape.target.traits.key?('smithy.api#streaming') && context.params[name.to_sym]
                  context.http_request.body = context.params[name.to_sym]
                  break
                end
              end
              @handler.call(context)
            end
          end
          Class.new(Plugin) { handler(handler_class, step: :build) }
        end

        it 'adds the handler' do
          expect(client.handlers).to include(TransferEncoding::Handler)
        end

        context 'non-streaming payload' do
          it 'does not set Transfer-Encoding' do
            response = client.operation(string: 'foo')
            expect(response.context.http_request.headers['Transfer-Encoding']).to be_nil
          end
        end

        context 'streaming payload with known size' do
          it 'does not set Transfer-Encoding' do
            response = client.operation(streaming_blob: StringIO.new('data'))
            expect(response.context.http_request.headers['Transfer-Encoding']).to be_nil
          end
        end

        context 'streaming payload with unknown size' do
          context 'when requiresLength' do
            before do
              shapes['smithy.ruby.tests#StreamingBlob']['traits']['smithy.api#requiresLength'] = {}
            end

            it 'raises MissingContentLength' do
              expect { client.operation(streaming_blob: unsizable_body) }
                .to raise_error(Client::Errors::MissingContentLength)
            end
          end

          context 'when unsignedPayload' do
            before do
              shapes['smithy.ruby.tests#Operation']['traits'] = { 'aws.auth#unsignedPayload' => {} }
            end

            it 'sets Transfer-Encoding chunked' do
              response = client.operation(streaming_blob: unsizable_body)
              expect(response.context.http_request.headers['Transfer-Encoding']).to eq('chunked')
            end
          end

          context 'when signed and no requiresLength' do
            it 'does not set Transfer-Encoding' do
              response = client.operation(streaming_blob: unsizable_body)
              expect(response.context.http_request.headers['Transfer-Encoding']).to be_nil
            end
          end
        end
      end
    end
  end
end
