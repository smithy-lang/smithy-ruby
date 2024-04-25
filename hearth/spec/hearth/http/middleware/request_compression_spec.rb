# frozen_string_literal: true

module Hearth
  module HTTP
    module Middleware
      describe RequestCompression do
        let(:app) { double('app', call: output) }
        let(:input) { double('input') }
        let(:output) { double('output') }
        let(:disable_request_compression) { false }
        let(:request_min_compression_size_bytes) { 10_240 } # default min
        let(:encodings) { ['gzip'] } # currently supported
        let(:streaming) { false }

        subject do
          RequestCompression.new(
            app,
            disable_request_compression: disable_request_compression,
            request_min_compression_size_bytes:
              request_min_compression_size_bytes,
            encodings: encodings,
            streaming: streaming
          )
        end

        def expect_uncompressed_body(request, body)
          expect(request.headers['Content-Encoding']).to be_nil
          expect(request.body.size).to eql(body.size)
        end

        describe '#call' do
          let(:body) { 'a' * 10_241 }
          let(:request) do
            Request.new(
              http_method: 'PUT',
              body: body
            )
          end
          let(:response) { double('response') }
          let(:logger) { Logger.new(IO::NULL) }
          let(:context) do
            Context.new(
              request: request,
              response: response,
              logger: logger
            )
          end

          context 'disable_request_compression is true' do
            let(:disable_request_compression) { true }

            it 'does not compress body' do
              expect(app).to receive(:call).with(input, context)
              resp = subject.call(input, context)
              expect_uncompressed_body(request, body)
              expect(resp).to be output
            end
          end

          context 'request_min_compression_size_bytes' do
            context 'body size is over the minimum' do
              it 'compresses the body and sets the content-encoding header' do
                expect(app).to receive(:call).with(input, context)
                resp = subject.call(input, context)
                expect(request.headers['Content-Encoding']).to eq('gzip')
                uncompressed = Zlib::GzipReader.new(request.body)
                expect(uncompressed.read).to eq(body)
                expect(resp).to be output
              end
            end

            context 'body size is less than the minimum' do
              let(:body) { 'a' * 128 }

              it 'does not compress' do
                expect(app).to receive(:call).with(input, context)
                resp = subject.call(input, context)
                expect_uncompressed_body(request, body)
                expect(resp).to be output
              end
            end
          end

          context 'encodings' do
            context 'none supported by client' do
              let(:encodings) { ['custom'] }

              it 'skips compression' do
                expect(app).to receive(:call).with(input, context)
                resp = subject.call(input, context)
                expect_uncompressed_body(request, body)
                expect(resp).to be output
              end
            end

            context 'multiple encodings' do
              let(:encodings) { %w[custom gzip] }
              let(:body) { StringIO.new('a' * 16_385) }

              it 'processes the first supported encoding found' do
                expect(app).to receive(:call).with(input, context)
                resp = subject.call(input, context)
                expect(request.headers['Content-Encoding']).to eq('gzip')
                expect(resp).to be output
              end
            end
          end

          context 'Content-Encoding header already exists' do
            it 'adds an encoding to the header' do
              request.headers['Content-Encoding'] = 'foo'
              expect(app).to receive(:call).with(input, context)
              resp = subject.call(input, context)
              expect(request.headers['Content-Encoding']).to eq('foo, gzip')
              expect(resp).to be output
            end
          end

          context 'streaming is set true' do
            let(:streaming) { true }
            let(:sent_data) { StringIO.new }

            let(:app) do
              proc do |_input, context|
                # IO.copy_stream is the same method used by Net::Http to
                # write our body to the socket
                IO.copy_stream(context.request.body, sent_data)
                output
              end
            end

            context 'a small streaming body' do
              let(:body) { StringIO.new('Hello World') }
              it 'compresses and preserves the original body' do
                subject.call(input, context)
                headers = context.request.headers
                expect(headers['Content-Encoding']).to eq('gzip')
                body.rewind
                sent_data.rewind
                uncompressed = Zlib::GzipReader.new(sent_data)
                expect(uncompressed.read).to eq(body.read)
              end
            end

            context 'a large streaming body' do
              let(:body) { StringIO.new('.' * 16_385) }
              it 'compresses and preserves the original body' do
                subject.call(input, context)
                headers = context.request.headers
                expect(headers['Content-Encoding']).to eq('gzip')
                body.rewind
                sent_data.rewind
                uncompressed = Zlib::GzipReader.new(sent_data)
                expect(uncompressed.read).to eq(body.read)
              end
            end
          end
        end
      end
    end
  end
end
