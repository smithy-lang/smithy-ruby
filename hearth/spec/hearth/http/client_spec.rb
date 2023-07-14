# frozen_string_literal: true

require 'webmock/rspec'

module Hearth
  module HTTP
    describe Client do
      before { WebMock.disable_net_connect! }
      before do
        ConnectionPool.instance_variable_set(:@pools, {})
      end

      let(:debug_output) { false }
      let(:logger) { double('logger') }
      let(:proxy) { nil }
      let(:ssl_timeout) { nil }
      let(:verify_peer) { false }
      let(:ca_file) { nil }
      let(:ca_path) { nil }
      let(:cert_store) { nil }
      let(:host_resolver) { nil }

      subject do
        Client.new(
          logger: logger,
          debug_output: debug_output,
          proxy: proxy,
          read_timeout: 1,
          open_timeout: 1,
          write_timeout: 1,
          keep_alive_timeout: 1,
          continue_timeout: 1,
          ssl_timeout: ssl_timeout,
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

        it 'rescues StandardError and raises HTTP::NetworkingError' do
          stub_request(:any, uri.to_s).to_raise(StandardError)
          expect do
            subject.transmit(request: request, response: response)
          end.to raise_error(NetworkingError)
        end

        it 'configures timeouts' do
          stub_request(:any, uri.to_s)
          expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
            expect(http.open_timeout).to eq(1)
            expect(http.read_timeout).to eq(1)
            expect(http.write_timeout).to eq(1)
            expect(http.continue_timeout).to eq(1)
            expect(http.keep_alive_timeout).to eq(1)
          end

          subject.transmit(request: request, response: response)
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

            context 'ssl_timeout' do
              let(:ssl_timeout) { 1 }

              it 'sets ssl_timeout' do
                stub_request(:any, uri.to_s)
                expect_any_instance_of(Net::HTTP).to receive(:start) do |http|
                  expect(http.ssl_timeout).to eq 1
                end

                subject.transmit(request: request, response: response)
              end
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

        context 'debug_output: true' do
          let(:debug_output) { true }
          let(:request_logger) { double('request_logger') }

          it 'sets the logger on debug_output' do
            stub_request(:any, uri.to_s)
            expect_any_instance_of(Net::HTTP)
              .to receive(:set_debug_output).with(logger)
            subject.transmit(
              request: request,
              response: response
            )
          end

          it 'allows logger per request' do
            stub_request(:any, uri.to_s)
            expect_any_instance_of(Net::HTTP)
              .to receive(:set_debug_output).with(request_logger)
            subject.transmit(
              request: request,
              response: response,
              logger: request_logger
            )
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

        context 'connection pooling' do
          it 'gets a connection from the pool' do
            stub_request(http_method, uri.to_s)
            expect(ConnectionPool).to receive(:for).and_call_original
            expect_any_instance_of(ConnectionPool).to receive(:connection_for)
              .and_call_original
            subject.transmit(request: request, response: response)
          end

          it 'offers the connection back to the pool' do
            stub_request(http_method, uri.to_s)
            expect_any_instance_of(ConnectionPool).to receive(:offer)
              .with(uri, an_instance_of(Hearth::HTTP::Client::HTTP))
              .and_call_original
            subject.transmit(request: request, response: response)
          end

          it 'finishes the connection if there is a networking error' do
            stub_request(http_method, uri.to_s)
            error = StandardError.new('failed')
            expect_any_instance_of(Net::HTTP).to receive(:request)
              .and_raise(error)
            expect_any_instance_of(Net::HTTP).to receive(:finish)
            expect do
              subject.transmit(request: request, response: response)
            end.to raise_error(NetworkingError, /#{error.message}/)
          end
        end
      end

      describe HTTP do
        let(:http) { Hearth::HTTP::Client::HTTP.new(net_http) }
        let(:net_http) { Net::HTTP.new(request.uri.host, request.uri.port) }

        it 'delegates to Net::HTTP' do
          expect(http).to be_a(Delegator)
          expect(http.__getobj__).to be(net_http)
        end

        describe '#stale?' do
          let(:base_time_ms) { 0 }
          let(:fresh_time_ms) { 1000 }
          let(:stale_time_ms) { 3000 }

          before do
            net_http.keep_alive_timeout = 2
            allow(net_http).to receive(:request)
          end

          it 'uses last used time to determine staleness' do
            expect(Process).to receive(:clock_gettime).and_return(base_time_ms)
            http.request(request)
            expect(Process).to receive(:clock_gettime).and_return(fresh_time_ms)
            expect(http.stale?).to be(false)
            expect(Process).to receive(:clock_gettime).and_return(stale_time_ms)
            expect(http.stale?).to be(true)
          end

          it 'is stale if not used' do
            expect(http.stale?).to be(true)
          end
        end

        describe '#finish' do
          it 'closes the connection without errors' do
            expect(net_http).to receive(:finish).and_raise(IOError)
            expect { http.finish }.not_to raise_error
          end
        end
      end
    end
  end
end
