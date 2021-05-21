# frozen_string_literal: true

module Seahorse
  module HTTP
    module Middleware
      describe ContentLength do
        let(:app) { double('app', call: nil) }
        let(:headers) { {} }
        let(:body) { nil }
        let(:context) { {} }

        let(:response) { Response.new }
        let(:request) do
          Request.new(
            http_method: :get,
            url: 'http://example.com',
            headers: headers,
            body: body
          )
        end

        subject { ContentLength.new(app) }

        it 'calls the next middleware and returns the result' do
          out = Seahorse::Output.new
          expect(app).to receive(:call)
            .with(request: request, response: response, context: context)
            .and_return(out)

          resp = subject.call(
            request: request,
            response: response,
            context: context
          )
          expect(resp).to eq(out)
        end

        context 'body responds to size' do
          let(:body) { StringIO.new('test-body') }

          it 'sets the content-length header on the request' do
            subject.call(
              request: request,
              response: response,
              context: context
            )
            expect(request.headers['Content-Length']).to eq(body.size)
          end
        end

        context 'body does not respond to size' do
          let(:body) { double('streaming-body', read: 'data') }

          it 'does not set the content-length header on the request' do
            expect(body).to receive(:respond_to?).with(:size).and_return(false)

            subject.call(
              request: request,
              response: response,
              context: context
            )
            expect(request.headers['Content-Length']).to be_nil
          end
        end

        context 'body is not set' do
          let(:body) { nil }
          it 'does not set the content-length header on the request' do
            subject.call(
              request: request,
              response: response,
              context: context
            )
            expect(request.headers['Content-Length']).to be_nil
          end
        end
      end
    end
  end
end
