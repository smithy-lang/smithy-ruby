# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module Plugins
      describe TransferEncoding do
        let(:shapes) { ClientHelper.sample_shapes }
        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }
        let(:client_class) { sample_client.const_get(:Client) }
        let(:client) { client_class.new(stub_responses: true, endpoint: 'https://example.com') }

        it 'adds the handler' do
          expect(client.handlers).to include(TransferEncoding::Handler)
        end

        describe TransferEncoding::Handler do
          let(:noop) { ->(_context) {} }
          let(:handler) { TransferEncoding::Handler.new(noop) }

          let(:unsizable_body) do
            io = StringIO.new('data')
            io.singleton_class.undef_method(:size)
            io.singleton_class.undef_method(:length)
            io
          end

          def build_context(traits: {}, operation_traits: {}, body: StringIO.new('data'))
            blob_shape = Schema::Shapes::BlobShape.new(
              traits: { 'smithy.api#streaming' => {} }.merge(traits)
            )
            input_shape = Schema::Shapes::StructureShape.new
            input_shape.add_member(:body, Schema::Shapes::ShapeRef.new(shape: blob_shape))
            operation = Schema::Shapes::OperationShape.new(
              input: Schema::Shapes::ShapeRef.new(shape: input_shape),
              traits: operation_traits
            )
            context = HandlerContext.new(operation: operation)
            context.http_request.body = body
            context
          end

          context 'non-streaming payload' do
            it 'does not set Transfer-Encoding' do
              input_shape = Schema::Shapes::StructureShape.new
              input_shape.add_member(:name, Schema::Shapes::ShapeRef.new(
                                              shape: Schema::Shapes::StringShape.new
                                            ))
              operation = Schema::Shapes::OperationShape.new(
                input: Schema::Shapes::ShapeRef.new(shape: input_shape),
                traits: {}
              )
              context = HandlerContext.new(operation: operation)
              handler.call(context)
              expect(context.http_request.headers['Transfer-Encoding']).to be_nil
            end
          end

          context 'streaming payload with known size' do
            it 'does not set Transfer-Encoding' do
              context = build_context
              handler.call(context)
              expect(context.http_request.headers['Transfer-Encoding']).to be_nil
            end
          end

          context 'streaming payload with unknown size' do
            context 'when requiresLength' do
              it 'raises error' do
                context = build_context(
                  traits: { 'smithy.api#requiresLength' => {} },
                  body: unsizable_body
                )
                expect { handler.call(context) }.to raise_error(
                  RuntimeError, 'Required `Content-Length` value missing for the request.'
                )
              end
            end

            context 'when unsignedPayload' do
              it 'sets Transfer-Encoding chunked' do
                context = build_context(
                  operation_traits: { 'aws.auth#unsignedPayload' => {} },
                  body: unsizable_body
                )
                handler.call(context)
                expect(context.http_request.headers['Transfer-Encoding']).to eq('chunked')
              end
            end

            context 'when signed and no requiresLength' do
              it 'does not set Transfer-Encoding' do
                context = build_context(body: unsizable_body)
                handler.call(context)
                expect(context.http_request.headers['Transfer-Encoding']).to be_nil
              end
            end
          end
        end
      end
    end
  end
end
