# frozen_string_literal: true

module Seahorse
  module HTTP
    module Middleware

      describe ContentLength do
        let(:app) { double('app', call: output) }

        subject { ContentLength.new(app) }

        describe '#call' do
          let(:input) { double('input') }
          let(:output) { double('output') }

          let(:request) do
            Request.new(
              http_method: :get,
              url: 'http://example.com',
              body: body
            )
          end

          let(:response) { double('response') }
          let(:context) do
            Context.new(
              request: request,
              response: response
            )
          end

          context 'body is not set' do
            let(:body) { nil }

            it 'does nothing and calls next middleware' do
              expect(app).to receive(:call).with(input, context)
              resp = subject.call(input, context)
              expect(request.headers['Content-Length']).to be_nil
              expect(resp).to be output
            end
          end

          context 'body is set' do
            context 'body responds to size' do
              let(:body) { StringIO.new('test-body') }

              it 'sets the content-length header on the request' do
                expect(app).to receive(:call).with(input, context)

                resp = subject.call(input, context)
                expect(request.headers['Content-Length'].to_i).to eq(body.size)
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
