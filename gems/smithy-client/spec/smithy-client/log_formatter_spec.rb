# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe LogFormatter do
      let(:client_class) { ClientHelper.sample_client.const_get(:Client) }
      let(:client) { client_class.new(stub_responses: true) }
      let(:response) { client.operation }

      def formatted(pattern, options = {})
        LogFormatter.new(pattern, options).format(response)
      end

      describe '#format' do
        it 'can format the client class' do
          response.context.client = Object.new
          expect(formatted(':client_class')).to eq('Object')
        end

        it 'can format the operation name' do
          response.context.operation_name = 'operation-name'
          expect(formatted(':operation')).to eq('operation-name')
        end

        it 'can format request parameters' do
          file = File.new('log-formatter', 'w')
          file.write('This has 17 bytes')
          file.rewind
          tempfile = Tempfile.new('log-formatter')
          tempfile.write('This has 17 bytes')
          tempfile.rewind
          response.context.params = {
            blob: file,
            list: %w[one two],
            map: {
              'color' => 'red',
              'size' => 'large'
            },
            string: 'this string is very long and exceeds the max size',
            structure: {
              blob: tempfile,
              string: Pathname.new(file.path)
            }
          }
          expected = <<~FORMATTED.strip
            { blob: #<File:#{file.path} (17 bytes)>, list: ["one", "two"], map: { "color" => "red", "size" => "large" }, string: #<String "this string is very " ... (49 bytes)>, structure: { blob: #<Tempfile:#{tempfile.path} (17 bytes)>, string: #<Pathname:#{file.path} (17 bytes)> } }
          FORMATTED
          expect(formatted(':request_params', max_string_size: 20)).to eq(expected)
        ensure
          file.close
          File.delete(file)
          tempfile.close
          tempfile.unlink
        end

        it 'can format the time taken for the request' do
          now = Time.now
          response.context[:logging_started_at] = now - 3.141592653
          response.context[:logging_completed_at] = now
          expect(formatted(':time')).to eq('3.141593')
        end

        it 'can format the number of retries' do
          response.context.retries = 3
          expect(formatted(':retries')).to eq('3')
        end

        it 'can format the HTTP request endpoint' do
          response.context.http_request = HTTP::Request.new(endpoint: 'https://example.com:8080')
          expect(formatted(':http_request_endpoint')).to eq('https://example.com:8080')
        end

        it 'can format the HTTP request scheme' do
          response.context.http_request = HTTP::Request.new(endpoint: 'https://example.com')
          expect(formatted(':http_request_scheme')).to eq('https')
        end

        it 'can format the HTTP request host' do
          response.context.http_request = HTTP::Request.new(endpoint: 'https://example.com')
          expect(formatted(':http_request_host')).to eq('example.com')
        end

        it 'can format the HTTP request port' do
          response.context.http_request = HTTP::Request.new(endpoint: 'https://example.com:8080')
          expect(formatted(':http_request_port')).to eq('8080')
        end

        it 'can format the HTTP request method' do
          response.context.http_request = HTTP::Request.new(http_method: 'GET')
          expect(formatted(':http_request_method')).to eq('GET')
        end

        it 'can format the HTTP request headers' do
          response.context.http_request = HTTP::Request.new(headers: { 'foo' => 'bar' })
          expect(formatted(':http_request_headers')).to eq('{"foo" => "bar"}')
        end

        it 'can format the HTTP request body' do
          response.context.http_request = HTTP::Request.new(body: 'This is the request body')
          expect(formatted(':http_request_body', max_string_size: 20))
            .to eq('#<String "This is the request " ... (24 bytes)>')
        end

        it 'formats with a blank body when request body is not rewindable' do
          response.context.http_request = HTTP::Request.new(body: Object.new)
          expect(formatted(':http_request_body')).to eq('')
        end

        it 'can format the HTTP response status code' do
          response.context.http_response = HTTP::Response.new(status_code: 200)
          expect(formatted(':http_response_status_code')).to eq('200')
        end

        it 'can format the HTTP response headers' do
          response.context.http_response = HTTP::Response.new(headers: { 'foo' => 'bar' })
          expect(formatted(':http_response_headers')).to eq('{"foo" => "bar"}')
        end

        it 'can format the HTTP response body' do
          response.context.http_response = HTTP::Response.new(body: 'This is the response body')
          expect(formatted(':http_response_body', max_string_size: 20))
            .to eq('#<String "This is the response" ... (25 bytes)>')
        end

        it 'formats with a blank body when response body is not rewindable' do
          response.context.http_response = HTTP::Response.new(body: Object.new)
          expect(formatted(':http_response_body')).to eq('')
        end

        it 'can format the error class' do
          response.error = StandardError.new('An error occurred')
          expect(formatted(':error_class')).to eq('StandardError')
        end

        it 'can format the error message' do
          response.error = StandardError.new('An error occurred')
          expect(formatted(':error_message')).to eq('An error occurred')
        end
      end

      context 'canned loggers' do
        before(:each) do
          now = Time.now
          response.context.client = String
          response.context.operation_name = 'operation'
          response.context.retries = 3
          response.context.params = { string: 'string' }
          response.error = RuntimeError.new('error-message')
          response.context.http_response.status_code = 200
          response.context[:logging_started_at] = now - 3.141592653
          response.context[:logging_completed_at] = now
        end

        it 'provides a default pattern' do
          formatted = LogFormatter.default.format(response)
          expect(formatted).to eq(<<~FORMATTED)
            [Class 200 3.141593 3 retries] operation({ string: "string" }) RuntimeError error-message
          FORMATTED
        end

        it 'provides a short pattern' do
          formatted = LogFormatter.short.format(response)
          expect(formatted).to eq(<<~FORMATTED)
            [Class 200 3.141593] operation RuntimeError
          FORMATTED
        end

        it 'provides a colored pattern' do
          formatted = LogFormatter.colored.format(response)
          expect(formatted).to eq(<<~FORMATTED)
            \e[1m\e[34m[Class 200 3.141593 3 retries]\e[0m\e[1m operation({ string: "string" }) RuntimeError error-message\e[0m
          FORMATTED
        end
      end
    end
  end
end
