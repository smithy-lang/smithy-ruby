# frozen_string_literal: true

require 'webmock/rspec'

module Hearth
  module HTTP
    describe Client do
      before { WebMock.disable_net_connect! }

      let(:wire_trace) { false }
      let(:logger) { double('logger') }
      let(:http_proxy) { nil }
      let(:ssl_verify_peer) { true }
      let(:ssl_ca_bundle) { nil }
      let(:ssl_ca_directory) { nil }
      let(:ssl_ca_store) { nil }

      subject do
        Client.new(
          http_wire_trace: wire_trace, logger: logger,
          http_proxy: http_proxy,
          ssl_verify_peer: ssl_verify_peer,
          ssl_ca_bundle: ssl_ca_bundle,
          ssl_ca_directory: ssl_ca_directory,
          ssl_ca_store: ssl_ca_store
        )
      end

      let(:http_method) { :get }
      let(:uri) { URI('http://example.com') }
      let(:fields) { Fields.new }
      let(:request_body) { StringIO.new('') }

      let(:request) do
        Request.new(
          http_method: http_method,
          uri: uri,
          fields: fields,
          body: request_body
        )
      end
      let(:response) { Response.new }

      describe '#transmit' do
        it 'sends the request to the uri' do
          stub_request(:any, uri.to_s)
          subject.transmit(request: request, response: response)
        end

        %i[get post put patch delete].each do |http_method|
          it "sends a #{http_method} request" do
            request = Request.new(http_method: http_method, uri: uri)

            stub_request(http_method, uri.to_s)
            subject.transmit(request: request, response: response)
          end
        end

        context 'request body is set' do
          let(:request_body) { StringIO.new('TEST_STRING') }
          it 'transmits the body' do
            expect_any_instance_of(Net::HTTP::Get)
              .to receive(:body_stream=).with(request_body).and_call_original
            # webmock sets to nil
            expect_any_instance_of(Net::HTTP::Get)
              .to receive(:body_stream=).with(nil).and_call_original
            stub_request(http_method, uri.to_s)
              .with(body: 'TEST_STRING')
            subject.transmit(request: request, response: response)
          end

          context 'body is empty' do
            let(:request_body) { StringIO.new('') }
            it 'does not set the body stream' do
              expect_any_instance_of(Net::HTTP::Get)
                .to_not receive(:body_stream=)
              stub_request(http_method, uri.to_s)
              subject.transmit(request: request, response: response)
            end
          end
        end

        context 'request body does not respond to size' do
          it 'does not set the body stream' do
            rd, wr = IO.pipe
            wr.puts 'test'
            wr.close
            request = Request.new(
              http_method: http_method,
              uri: uri,
              fields: fields,
              body: rd
            )
            # webmock sets to nil
            expect_any_instance_of(Net::HTTP::Get)
              .to receive(:body_stream=).with(nil).and_call_original
            expect_any_instance_of(Net::HTTP::Get)
              .to receive(:body_stream=).with(rd).and_call_original
            stub_request(http_method, uri.to_s)
            subject.transmit(request: request, response: response)
          end
        end

        context 'request headers are set' do
          before { fields['Header-Name'] = 'Header-Value' }

          it 'transmits the headers' do
            stub_request(http_method, uri.to_s)
              .with(headers: fields.to_h)
            subject.transmit(request: request, response: response)
          end
        end

        context 'request trailers are set' do
          let(:field) do
            Field.new('Trailer-Name', ['Trailer-Value'], kind: :trailer)
          end
          before { fields['Trailer-Name'] = field }

          it 'raises NotImplementedError' do
            expect do
              subject.transmit(request: request, response: response)
            end.to raise_error(NotImplementedError)
          end
        end

        it 'sets the response status code' do
          stub_request(http_method, uri.to_s)
            .to_return(status: 242)
          subject.transmit(request: request, response: response)
          expect(response.status).to eq(242)
        end

        it 'sets the response headers' do
          response_headers = {
            'test-header' => 'value',
            'test-header-2' => 'value2'
          }
          stub_request(http_method, uri.to_s)
            .to_return(headers: response_headers)
          subject.transmit(request: request, response: response)
          expect(response.fields.to_h).to eq(response_headers)
        end

        it 'writes the response body' do
          response_body = 'TEST-BODY'
          stub_request(http_method, uri.to_s)
            .to_return(body: response_body)
          expect(response.body).to receive(:write).with(response_body)

          subject.transmit(request: request, response: response)
        end

        it 'rewinds the body' do
          stub_request(http_method, uri.to_s)
          expect(response.body).to receive(:rewind)

          subject.transmit(request: request, response: response)
        end

        it 'raises ArgumentError on invalid http verbs' do
          expect do
            request = Request.new(http_method: :invalid_verb, uri: uri)
            subject.transmit(request: request, response: response)
          end.to raise_error(ArgumentError)
        end

        it 'rescues StandardError and converts to a NetworkingError' do
          stub_request(:any, uri.to_s).to_raise(StandardError)
          expect do
            subject.transmit(request: request, response: response)
          end.to raise_error(NetworkingError)
        end

        context 'https' do
          let(:uri) { URI('https://example.com') }

          it 'sets use_ssl' do
            stub_request(:any, uri.to_s)
            expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
              expect(http.use_ssl?).to be true
              http
            end

            subject.transmit(request: request, response: response)
          end

          context 'ssl_verify_peer: false' do
            let(:ssl_verify_peer) { false }

            it 'sets verify_peer to NONE' do
              stub_request(:any, uri.to_s)
              expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
                expect(http.verify_mode).to eq OpenSSL::SSL::VERIFY_NONE
                http
              end

              subject.transmit(request: request, response: response)
            end
          end

          context 'ssl_verify_peer: true' do
            let(:ssl_verify_peer) { true }

            it 'sets verify_peer to VERIFY_PEER' do
              stub_request(:any, uri.to_s)
              expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
                expect(http.verify_mode).to eq OpenSSL::SSL::VERIFY_PEER
                http
              end

              subject.transmit(request: request, response: response)
            end

            context 'ssl_ca_bundle' do
              let(:ssl_ca_bundle) { 'ca_bundle' }

              it 'sets ca_file' do
                stub_request(:any, uri.to_s)
                expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
                  expect(http.ca_file).to eq 'ca_bundle'
                  http
                end

                subject.transmit(request: request, response: response)
              end
            end

            context 'ssl_ca_directory' do
              let(:ssl_ca_directory) { 'ca_directory' }

              it 'sets ca_path' do
                stub_request(:any, uri.to_s)
                expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
                  expect(http.ca_path).to eq 'ca_directory'
                  http
                end

                subject.transmit(request: request, response: response)
              end
            end

            context 'ssl_ca_store' do
              let(:ssl_ca_store) { 'ca_store' }

              it 'sets cert_store' do
                stub_request(:any, uri.to_s)
                expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
                  expect(http.cert_store).to eq 'ca_store'
                  http
                end

                subject.transmit(request: request, response: response)
              end
            end
          end
        end

        context 'http_proxy set' do
          let(:http_proxy) { 'http://my-proxy-host.com:88' }
          it 'sets the http proxy' do
            stub_request(:any, uri.to_s)
            expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
              expect(http.proxyaddr).to eq('my-proxy-host.com')
              expect(http.proxyport).to eq(88)
            end

            subject.transmit(request: request, response: response)
          end

          context 'user and password set on proxy' do
            let(:password) { 'pass/word' }
            let(:user) { 'my user' }
            let(:http_proxy) do
              "http://#{CGI.escape(user)}:#{CGI.escape(password)}@my-proxy-host.com:88"
            end

            it 'unescapes and sets user and password' do
              stub_request(:any, uri.to_s)
              expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
                expect(http.proxyaddr).to eq('my-proxy-host.com')
                expect(http.proxy_user).to eq(user)
                expect(http.proxy_pass).to eq(password)
              end

              subject.transmit(request: request, response: response)
            end
          end
        end

        context 'http_wire_trace: true' do
          let(:wire_trace) { true }

          it 'sets the logger on debug_output' do
            stub_request(:any, uri.to_s)
            expect_any_instance_of(Net::HTTP)
              .to receive(:set_debug_output).with(logger)
            subject.transmit(request: request, response: response)
          end
        end
      end
    end
  end
end
