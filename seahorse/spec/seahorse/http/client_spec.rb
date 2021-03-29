require 'webmock/rspec'
require 'seahorse/http'

module Seahorse
  module HTTP
    describe Client do
      before(:each) { WebMock.disable_net_connect! }

      let(:wire_trace) { false }
      let(:logger) { double('logger') }

      subject { Client.new(http_wire_trace: wire_trace, logger: logger) }

      let(:http_method) { :get }
      let(:url) { 'http://example.com' }
      let(:headers) { {} }
      let(:request_body) { StringIO.new('') }

      let(:request) do
        Request.new(
          http_method: http_method,
          url: url,
          headers: headers,
          body: request_body
        )
      end

      let(:response) { Response.new }

      describe '#transmit' do
        it 'sends the request to the url' do
          stub_request(:any, url)
          subject.transmit(request: request, response: response)
        end

        %i[get post put patch delete].each do |http_method|
          it "sends a #{http_method} request" do
            request = Request.new(http_method: http_method, url: url)

            stub_request(http_method, url)
            subject.transmit(request: request, response: response)
          end
        end

        context 'request body is set' do
          let(:request_body) { StringIO.new('TEST_STRING') }
          it 'transmits the body' do
            stub_request(http_method, url)
              .with(body: 'TEST_STRING')
            subject.transmit(request: request, response: response)
          end
        end

        context 'request headers are set' do
          let(:headers) { { 'Header-Name' => 'Header-Value' } }
          it 'transmits the headers' do
            stub_request(http_method, url)
              .with(headers: headers)
            subject.transmit(request: request, response: response)
          end
        end

        it 'sets the response status code' do
          stub_request(http_method, url)
            .to_return(status: 242)
          subject.transmit(request: request, response: response)
          expect(response.status_code).to eq(242)
        end

        it 'sets the response headers' do
          response_headers = {
            'test-header' => 'value',
            'test-header-2' => 'value2'
          }
          stub_request(http_method, url)
            .to_return(headers: response_headers)
          subject.transmit(request: request, response: response)
          expect(response.headers).to eq(response_headers)
        end

        it 'writes the response body' do
          response_body = 'TEST-BODY'
          stub_request(http_method, url)
            .to_return(body: response_body)
          expect(response.body).to receive(:write).with(response_body)

          subject.transmit(request: request, response: response)
        end

        it 'rewinds the body' do
          stub_request(http_method, url)
          expect(response.body).to receive(:rewind)

          subject.transmit(request: request, response: response)
        end

        it 'raises ArgumentError on invalid http verbs' do
          expect do
            request = Request.new(http_method: :invalid_verb, url: url)
            subject.transmit(request: request, response: response)
          end.to raise_error(ArgumentError)
        end

        Client::NETWORK_ERRORS.each do |error|
          if error == Net::HTTPFatalError
            error = Net::HTTPFatalError.new(nil, nil)
          end

          it "rescues #{error} and converts to a NetworkingError" do
            stub_request(:any, url).to_raise(error)
            expect do
              subject.transmit(request: request, response: response)
            end.to raise_error(NetworkingError)
          end
        end

        context 'http_wire_trace: true' do
          let(:wire_trace) { true }

          it 'sets the logger on debug_output' do
            stub_request(:any, url)
            expect_any_instance_of(Net::HTTP)
              .to receive(:set_debug_output).with(logger)
            subject.transmit(request: request, response: response)
          end
        end
      end
    end
  end
end
