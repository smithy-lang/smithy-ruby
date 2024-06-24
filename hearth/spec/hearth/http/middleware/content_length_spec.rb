# frozen_string_literal: true

module Hearth
  module HTTP
    module Middleware
      describe ContentLength do
        let(:app) { double('app', call: output) }
        let(:input) { double('input') }
        let(:output) { double('output') }

        subject { ContentLength.new(app) }

        describe '#call' do
          let(:request) do
            Request.new(
              http_method: 'GET',
              body: body
            )
          end
          let(:response) { double('response') }
          let(:logger) { Logger.new(IO::NULL) }
          let(:config) { double('config', logger: logger) }
          let(:context) do
            Context.new(request: request, response: response, config: config)
          end

          context 'body is not set' do
            let(:body) { nil }

            it 'does not set the content-length and calls next middleware' do
              expect(app).to receive(:call).with(input, context)
              resp = subject.call(input, context)
              expect(request.headers['Content-Length']).to be_nil
              expect(resp).to be output
            end
          end

          context 'body is set' do
            context 'body has a positive size' do
              let(:body) { StringIO.new('test-body') }

              it 'sets the content-length header on the request' do
                expect(app).to receive(:call).with(input, context)

                resp = subject.call(input, context)
                expect(request.headers['Content-Length'])
                  .to eq(body.size.to_s)
                expect(resp).to be output
              end
            end

            context 'body is empty' do
              let(:body) { StringIO.new('') }

              it 'does not set the content-length header on the request' do
                expect(app).to receive(:call).with(input, context)
                resp = subject.call(input, context)
                expect(request.headers['Content-Length']).to be_nil
                expect(resp).to be output
              end
            end

            context 'body does not respond to size' do
              let(:body) { double('streaming-body', read: 'data') }

              it 'does not set the content-length header on the request' do
                expect(app).to receive(:call).with(input, context)
                expect(body).to receive(:respond_to?)
                  .with(:size).and_return(false)

                resp = subject.call(input, context)
                expect(request.headers['Content-Length']).to be_nil
                expect(resp).to be output
              end
            end
          end
        end
      end
    end
  end
end
