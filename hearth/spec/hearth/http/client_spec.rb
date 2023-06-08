# frozen_string_literal: true

require 'webmock/rspec'

module Hearth
  module HTTP
    describe Client do
      before { WebMock.disable_net_connect! }

      let(:wire_trace) { false }
      let(:logger) { double('logger') }
      let(:proxy) { nil }
      let(:verify_peer) { true }
      let(:ca_file) { nil }
      let(:ca_path) { nil }
      let(:cert_store) { nil }
      let(:host_resolver) { nil }

      subject do
        Client.new(
          http_wire_trace: wire_trace, logger: logger,
          proxy: proxy,
          verify_peer: verify_peer,
          ca_file: ca_file,
          ca_path: ca_path,
          cert_store: cert_store,
          host_resolver: host_resolver
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
          before { request.headers['Header-Name'] = 'Header-Value' }

          it 'transmits the headers' do
            stub_request(http_method, uri.to_s)
              .with(headers: request.headers.to_h)
            subject.transmit(request: request, response: response)
          end
        end

        context 'request trailers are set' do
          before { request.trailers['Trailer-Name'] = 'Trailer-Value' }

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
          expect(response.headers.to_h).to eq(response_headers)
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

        it 'rescues StandardError and returns an HTTP::NetworkingError' do
          stub_request(:any, uri.to_s).to_raise(StandardError)
          resp_or_error = subject.transmit(request: request, response: response)
          expect(resp_or_error).to be_a(NetworkingError)
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

          context 'verify_peer: false' do
            let(:verify_peer) { false }

            it 'sets verify_peer to NONE' do
              stub_request(:any, uri.to_s)
              expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
                expect(http.verify_mode).to eq OpenSSL::SSL::VERIFY_NONE
                http
              end

              subject.transmit(request: request, response: response)
            end
          end

          context 'verify_peer: true' do
            let(:verify_peer) { true }

            it 'sets verify_peer to VERIFY_PEER' do
              stub_request(:any, uri.to_s)
              expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
                expect(http.verify_mode).to eq OpenSSL::SSL::VERIFY_PEER
                http
              end

              subject.transmit(request: request, response: response)
            end

            context 'ca_file' do
              let(:ca_file) { 'ca_bundle' }

              it 'sets ca_file' do
                stub_request(:any, uri.to_s)
                expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
                  expect(http.ca_file).to eq 'ca_bundle'
                  http
                end

                subject.transmit(request: request, response: response)
              end
            end

            context 'ca_path' do
              let(:ca_path) { 'ca_directory' }

              it 'sets ca_path' do
                stub_request(:any, uri.to_s)
                expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
                  expect(http.ca_path).to eq 'ca_directory'
                  http
                end

                subject.transmit(request: request, response: response)
              end
            end

            context 'cert_store' do
              let(:cert_store) { 'cert_store' }

              it 'sets cert_store' do
                stub_request(:any, uri.to_s)
                expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
                  expect(http.cert_store).to eq 'cert_store'
                  http
                end

                subject.transmit(request: request, response: response)
              end
            end
          end
        end

        context 'proxy set' do
          let(:proxy) { 'http://my-proxy-host.com:88' }
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
            let(:proxy) do
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

        context 'DNS resolution' do
          let(:host_resolver) { Hearth::DNS::HostResolver.new }

          it 'sets the custom dns resolver as a thread local variable' do
            expect(Thread.current).to receive(:[]=)
              .with(:net_http_hearth_dns_resolver, host_resolver)
            expect(Thread.current).to receive(:[]=)
              .with(:net_http_hearth_dns_resolver, nil)
            stub_request(:any, uri.to_s)
            subject.transmit(request: request, response: response)
          end
        end
      end
    end
  end
end
