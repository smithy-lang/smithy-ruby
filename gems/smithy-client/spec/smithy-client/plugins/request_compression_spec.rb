# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module Plugins
      describe RequestCompression do
        let(:shapes) { ClientHelper.sample_shapes }
        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }
        let(:client_class) { sample_client.const_get(:Client) }
        let(:client) { client_class.new(stub_responses: true, endpoint: 'https://example.com') }

        it 'adds a :disable_request_compression option to config' do
          expect(client.config).to respond_to(:disable_request_compression)
        end

        it 'adds a :request_min_compression_size_bytes option to config' do
          expect(client.config).to respond_to(:request_min_compression_size_bytes)
        end

        it 'adds the handler if :disable_request_compression is false' do
          expect(client.handlers).to include(RequestCompression::Handler)
        end

        it 'does not add the handler if :disable_request_compression is true' do
          client = client_class.new(disable_request_compression: true)
          expect(client.handlers).not_to include(RequestCompression::Handler)
        end

        it 'validates :disable_request_compression option as a boolean' do
          client_class.new(disable_request_compression: true)
          client_class.new(disable_request_compression: false)
          expect { client_class.new(disable_request_compression: 'foo') }
            .to raise_error(ArgumentError, ':disable_request_compression must be either `true` or `false`')
        end

        it 'allows :disable_request_compression to be set via ENV' do
          ENV['DISABLE_REQUEST_COMPRESSION'] = 'true'
          client = client_class.new
          expect(client.config.disable_request_compression).to be(true)
        end

        it 'validates :request_min_compression_size_bytes option as an integer within a range' do
          msg = /must be a non-negative integer value between `0` and `10,485,760` bytes inclusive/
          client_class.new(request_min_compression_size_bytes: 0)
          client_class.new(request_min_compression_size_bytes: 10_485_760)
          expect { client_class.new(request_min_compression_size_bytes: 'foo') }
            .to raise_error(ArgumentError, msg)
          expect { client_class.new(request_min_compression_size_bytes: -1) }
            .to raise_error(ArgumentError, msg)
          expect { client_class.new(request_min_compression_size_bytes: 10_485_761) }
            .to raise_error(ArgumentError, msg)
        end

        it 'allows :request_min_compression_size_bytes to be set via ENV' do
          ENV['REQUEST_MIN_COMPRESSION_SIZE_BYTES'] = '123'
          client = client_class.new
          expect(client.config.request_min_compression_size_bytes).to eq(123)
        end

        context 'handler' do
          let(:large_body) { 'a' * 10_240 }
          let(:small_body) { 'a' * 128 }

          before do
            shapes['smithy.ruby.tests#Operation']['traits'] = {
              'smithy.api#requestCompression' => { 'encodings' => ['gzip'] }
            }
          end

          it 'compresses the body using gzip and sets the content-encoding header' do
            response = client.operation(string: large_body)
            expect(response.context.http_request.headers['Content-Encoding']).to eq('gzip')
          end

          it 'caches the request compression encodings on the operation' do
            response = client.operation(string: large_body)

            expect(response.context.operation[:request_compression_encodings]).to eq(['gzip'])
          end

          it 'preserves the uncompressed body' do
            response = client.operation(string: large_body)
            uncompressed_body = Zlib::GzipReader.new(response.context.http_request.body)
            expect(uncompressed_body.read).to include(large_body)
          end

          it 'uses the first supported encoding found' do
            shapes['smithy.ruby.tests#Operation']['traits'] = {
              'smithy.api#requestCompression' => { 'encodings' => %w[custom gzip] }
            }
            response = client.operation(string: large_body)
            expect(response.context.http_request.headers['Content-Encoding']).to eq('gzip')
          end

          it 'does not compress when no supported encoding is found' do
            shapes['smithy.ruby.tests#Operation']['traits'] = {
              'smithy.api#requestCompression' => { 'encodings' => ['custom'] }
            }
            response = client.operation(string: large_body)
            expect(response.context.http_request.headers['Content-Encoding']).to be_nil
          end

          it 'compresses the body when the size is greater than the minimum size' do
            # input with any streaming member is always compressed regardless of min size
            shapes['smithy.ruby.tests#StreamingBlob'].delete('traits')
            client.config.request_min_compression_size_bytes = 128
            response = client.operation(string: small_body)
            expect(response.context.http_request.headers['Content-Encoding']).to eq('gzip')
          end

          it 'does not compress when the body is smaller than the minimum size' do
            # input with any streaming member is always compressed regardless of min size
            shapes['smithy.ruby.tests#StreamingBlob'].delete('traits')
            response = client.operation(string: small_body)
            expect(response.context.http_request.headers['Content-Encoding']).to be_nil
          end

          it 'compresses a streaming body regardless of minimum size' do
            client.config.request_min_compression_size_bytes = 0
            client.stub_responses(:operation, lambda do |context|
              headers = context.http_request.headers
              expect(headers['Content-Encoding']).to eq('gzip')
              # capture the body by reading it into a new IO object
              body = StringIO.new
              # IO.copy_stream is the same method used by Net::HTTP to write our body to the socket
              IO.copy_stream(context.http_request.body, body)
              body.rewind
              expect(Zlib::GzipReader.new(body).read).to include(large_body) # cbor
              {}
            end)
            client.operation(streaming_blob: large_body)
          end

          it 'caches the streaming member without requiresLength on the input shape' do
            response = client.operation(streaming_blob: large_body)

            expect(response.context.operation.input[:streaming_member_without_length].name).to eq('streamingBlob')
          end
        end
      end
    end
  end
end
