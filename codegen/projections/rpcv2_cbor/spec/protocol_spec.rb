# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'base64'
require 'hearth/cbor/value_matcher'

require_relative 'spec_helper'

module Rpcv2Cbor
  describe Client do
    let(:client) do
      Client.new(
        stub_responses: true,
        validate_input: false,
        endpoint: 'http://127.0.0.1',
        retry_strategy: Hearth::Retry::Standard.new(max_attempts: 0)
      )
    end

    describe '#empty_input_output' do

      describe 'requests' do

        # When Input structure is empty we write CBOR equivalent of {}
        it 'empty_input' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/EmptyInputOutput')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['X-Amz-Target'].each { |k| expect(request.headers.key?(k)).to be(false) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v/8=')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.empty_input_output({}, **opts)
        end

      end

      describe 'responses' do

        # When output structure is empty we write CBOR equivalent of {}
        it 'empty_output' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v/8='))
          response.body.rewind
          client.stub_responses(:empty_input_output, response)
          allow(Builders::EmptyInputOutput).to receive(:build)
          output = client.empty_input_output({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({})
        end

        # When output structure is empty the client should accept an empty body
        it 'empty_output_no_body' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64(''))
          response.body.rewind
          client.stub_responses(:empty_input_output, response)
          allow(Builders::EmptyInputOutput).to receive(:build)
          output = client.empty_input_output({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({})
        end

      end

      describe 'stubs' do

        # When output structure is empty we write CBOR equivalent of {}
        it 'empty_output' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::EmptyInputOutput).to receive(:build)
          client.stub_responses(:empty_input_output, data: {})
          output = client.empty_input_output({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({})
        end

        # When output structure is empty the client should accept an empty body
        it 'empty_output_no_body' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::EmptyInputOutput).to receive(:build)
          client.stub_responses(:empty_input_output, data: {})
          output = client.empty_input_output({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({})
        end

      end

    end

    describe '#float16' do

      describe 'responses' do

        # Ensures that clients can correctly parse float16 +Inf.
        it 'RpcV2CborFloat16Inf' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('oWV2YWx1Zfl8AA=='))
          response.body.rewind
          client.stub_responses(:float16, response)
          allow(Builders::Float16).to receive(:build)
          output = client.float16({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            value: Float::INFINITY
          })
        end

        # Ensures that clients can correctly parse float16 -Inf.
        it 'RpcV2CborFloat16NegInf' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('oWV2YWx1Zfn8AA=='))
          response.body.rewind
          client.stub_responses(:float16, response)
          allow(Builders::Float16).to receive(:build)
          output = client.float16({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            value: -Float::INFINITY
          })
        end

        # Ensures that clients can correctly parse float16 NaN with high LSB.
        it 'RpcV2CborFloat16LSBNaN' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('oWV2YWx1Zfl8AQ=='))
          response.body.rewind
          client.stub_responses(:float16, response)
          allow(Builders::Float16).to receive(:build)
          output = client.float16({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            value: Float::NAN
          })
        end

        # Ensures that clients can correctly parse float16 NaN with high MSB.
        it 'RpcV2CborFloat16MSBNaN' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('oWV2YWx1Zfl+AA=='))
          response.body.rewind
          client.stub_responses(:float16, response)
          allow(Builders::Float16).to receive(:build)
          output = client.float16({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            value: Float::NAN
          })
        end

        # Ensures that clients can correctly parse a subnormal float16.
        it 'RpcV2CborFloat16Subnormal' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('oWV2YWx1ZfkAUA=='))
          response.body.rewind
          client.stub_responses(:float16, response)
          allow(Builders::Float16).to receive(:build)
          output = client.float16({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            value: 4.76837158203125E-6
          })
        end

      end

      describe 'stubs' do

        # Ensures that clients can correctly parse float16 +Inf.
        it 'RpcV2CborFloat16Inf' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::Float16).to receive(:build)
          client.stub_responses(:float16, data: {
            value: Float::INFINITY
          })
          output = client.float16({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            value: Float::INFINITY
          })
        end

        # Ensures that clients can correctly parse float16 -Inf.
        it 'RpcV2CborFloat16NegInf' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::Float16).to receive(:build)
          client.stub_responses(:float16, data: {
            value: -Float::INFINITY
          })
          output = client.float16({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            value: -Float::INFINITY
          })
        end

        # Ensures that clients can correctly parse float16 NaN with high LSB.
        it 'RpcV2CborFloat16LSBNaN' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::Float16).to receive(:build)
          client.stub_responses(:float16, data: {
            value: Float::NAN
          })
          output = client.float16({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            value: Float::NAN
          })
        end

        # Ensures that clients can correctly parse float16 NaN with high MSB.
        it 'RpcV2CborFloat16MSBNaN' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::Float16).to receive(:build)
          client.stub_responses(:float16, data: {
            value: Float::NAN
          })
          output = client.float16({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            value: Float::NAN
          })
        end

        # Ensures that clients can correctly parse a subnormal float16.
        it 'RpcV2CborFloat16Subnormal' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::Float16).to receive(:build)
          client.stub_responses(:float16, data: {
            value: 4.76837158203125E-6
          })
          output = client.float16({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            value: 4.76837158203125E-6
          })
        end

      end

    end

    describe '#fractional_seconds' do

      describe 'responses' do

        # Ensures that clients can correctly parse timestamps with fractional seconds
        it 'RpcV2CborDateTimeWithFractionalSeconds' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2hkYXRldGltZcH7Qcw32zgPvnf/'))
          response.body.rewind
          client.stub_responses(:fractional_seconds, response)
          allow(Builders::FractionalSeconds).to receive(:build)
          output = client.fractional_seconds({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            datetime: Time.at(946845296, 123, :millisecond)
          })
        end

      end

      describe 'stubs' do

        # Ensures that clients can correctly parse timestamps with fractional seconds
        it 'RpcV2CborDateTimeWithFractionalSeconds' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::FractionalSeconds).to receive(:build)
          client.stub_responses(:fractional_seconds, data: {
            datetime: Time.at(946845296, 123, :millisecond)
          })
          output = client.fractional_seconds({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            datetime: Time.at(946845296, 123, :millisecond)
          })
        end

      end

    end

    describe '#greeting_with_errors' do

      describe 'InvalidGreeting error' do

        # Parses simple RpcV2 Cbor errors
        it 'RpcV2CborInvalidGreetingError' do
          response = Hearth::HTTP::Response.new
          response.status = 400
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2ZfX3R5cGV4LnNtaXRoeS5wcm90b2NvbHRlc3RzLnJwY3YyQ2JvciNJbnZhbGlkR3JlZXRpbmdnTWVzc2FnZWJIaf8='))
          response.body.rewind
          client.stub_responses(:greeting_with_errors, response)
          allow(Builders::GreetingWithErrors).to receive(:build)
          begin
            output = client.greeting_with_errors({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          rescue Errors::InvalidGreeting => e
            expect(e.data.to_h).to eq({
              message: "Hi"
            })
          end
        end

        # Parses simple RpcV2 Cbor errors
        it 'stubs RpcV2CborInvalidGreetingError' do
          client.stub_responses(:greeting_with_errors, error: { class: Errors::InvalidGreeting, data: {
            message: "Hi"
          } })
          allow(Builders::GreetingWithErrors).to receive(:build)
          begin
            output = client.greeting_with_errors({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          rescue Errors::InvalidGreeting => e
            expect(e.http_status).to eq(400)
            expect(e.data.to_h).to eq({
              message: "Hi"
            })
          end
        end
      end

      describe 'ComplexError error' do

        # Parses a complex error with no message member
        it 'RpcV2CborComplexError' do
          response = Hearth::HTTP::Response.new
          response.status = 400
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2ZfX3R5cGV4K3NtaXRoeS5wcm90b2NvbHRlc3RzLnJwY3YyQ2JvciNDb21wbGV4RXJyb3JoVG9wTGV2ZWxpVG9wIGxldmVsZk5lc3RlZL9jRm9vY2Jhcv//'))
          response.body.rewind
          client.stub_responses(:greeting_with_errors, response)
          allow(Builders::GreetingWithErrors).to receive(:build)
          begin
            output = client.greeting_with_errors({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          rescue Errors::ComplexError => e
            expect(e.data.to_h).to eq({
              top_level: "Top level",
              nested: {
                foo: "bar"
              }
            })
          end
        end

        # Parses a complex error with no message member
        it 'stubs RpcV2CborComplexError' do
          client.stub_responses(:greeting_with_errors, error: { class: Errors::ComplexError, data: {
            top_level: "Top level",
            nested: {
              foo: "bar"
            }
          } })
          allow(Builders::GreetingWithErrors).to receive(:build)
          begin
            output = client.greeting_with_errors({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          rescue Errors::ComplexError => e
            expect(e.http_status).to eq(400)
            expect(e.data.to_h).to eq({
              top_level: "Top level",
              nested: {
                foo: "bar"
              }
            })
          end
        end

        #
        it 'RpcV2CborEmptyComplexError' do
          response = Hearth::HTTP::Response.new
          response.status = 400
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2ZfX3R5cGV4K3NtaXRoeS5wcm90b2NvbHRlc3RzLnJwY3YyQ2JvciNDb21wbGV4RXJyb3L/'))
          response.body.rewind
          client.stub_responses(:greeting_with_errors, response)
          allow(Builders::GreetingWithErrors).to receive(:build)
          begin
            output = client.greeting_with_errors({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          rescue Errors::ComplexError => e
            expect(e.data.to_h).to eq({})
          end
        end

        #
        it 'stubs RpcV2CborEmptyComplexError' do
          client.stub_responses(:greeting_with_errors, error: { class: Errors::ComplexError, data: {} })
          allow(Builders::GreetingWithErrors).to receive(:build)
          begin
            output = client.greeting_with_errors({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          rescue Errors::ComplexError => e
            expect(e.http_status).to eq(400)
            expect(e.data.to_h).to eq({})
          end
        end
      end

    end

    describe '#no_input_output' do

      describe 'requests' do

        # Body is empty and no Content-Type header if no input
        it 'no_input' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/NoInputOutput')
            { 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Type', 'X-Amz-Target'].each { |k| expect(request.headers.key?(k)).to be(false) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.no_input_output({}, **opts)
        end

      end

      describe 'responses' do

        # A `Content-Type` header should not be set if the response body is empty.
        it 'no_output' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64(''))
          response.body.rewind
          client.stub_responses(:no_input_output, response)
          allow(Builders::NoInputOutput).to receive(:build)
          output = client.no_input_output({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({})
        end

        # Clients should accept a CBOR empty struct if there is no output.
        it 'NoOutputClientAllowsEmptyCbor' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v/8='))
          response.body.rewind
          client.stub_responses(:no_input_output, response)
          allow(Builders::NoInputOutput).to receive(:build)
          output = client.no_input_output({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({})
        end

        # Clients should accept an empty body if there is no output and
        # should not raise an error if the `Content-Type` header is set.
        it 'NoOutputClientAllowsEmptyBody' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64(''))
          response.body.rewind
          client.stub_responses(:no_input_output, response)
          allow(Builders::NoInputOutput).to receive(:build)
          output = client.no_input_output({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({})
        end

      end

      describe 'stubs' do

        # A `Content-Type` header should not be set if the response body is empty.
        it 'no_output' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::NoInputOutput).to receive(:build)
          client.stub_responses(:no_input_output, data: {})
          output = client.no_input_output({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({})
        end

        # Clients should accept a CBOR empty struct if there is no output.
        it 'NoOutputClientAllowsEmptyCbor' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::NoInputOutput).to receive(:build)
          client.stub_responses(:no_input_output, data: {})
          output = client.no_input_output({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({})
        end

        # Clients should accept an empty body if there is no output and
        # should not raise an error if the `Content-Type` header is set.
        it 'NoOutputClientAllowsEmptyBody' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::NoInputOutput).to receive(:build)
          client.stub_responses(:no_input_output, data: {})
          output = client.no_input_output({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({})
        end

      end

    end

    describe '#operation_with_defaults' do

      describe 'requests' do

        # Client populates default values in input.
        it 'RpcV2CborClientPopulatesDefaultValuesInInput', skip: 'Incorrect body in protocol test. Patch: https://github.com/smithy-lang/smithy/pull/2320'  do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/OperationWithDefaults')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v2hkZWZhdWx0c79tZGVmYXVsdFN0cmluZ2JoaW5kZWZhdWx0Qm9vbGVhbvVrZGVmYXVsdExpc3Sf/3BkZWZhdWx0VGltZXN0YW1wwQBrZGVmYXVsdEJsb2JjYWJja2RlZmF1bHRCeXRlAWxkZWZhdWx0U2hvcnQBbmRlZmF1bHRJbnRlZ2VyCmtkZWZhdWx0TG9uZxhkbGRlZmF1bHRGbG9hdPo/gAAAbWRlZmF1bHREb3VibGX6P4AAAGpkZWZhdWx0TWFwv/9rZGVmYXVsdEVudW1jRk9PbmRlZmF1bHRJbnRFbnVtAWtlbXB0eVN0cmluZ2BsZmFsc2VCb29sZWFu9GllbXB0eUJsb2JgaHplcm9CeXRlAGl6ZXJvU2hvcnQAa3plcm9JbnRlZ2VyAGh6ZXJvTG9uZwBpemVyb0Zsb2F0+gAAAABqemVyb0RvdWJsZfoAAAAA//8=')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.operation_with_defaults({
            defaults: {}
          }, **opts)
        end

        # Client skips top level default values in input.
        it 'RpcV2CborClientSkipsTopLevelDefaultValuesInInput' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/OperationWithDefaults')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v/8=')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.operation_with_defaults({}, **opts)
        end

        # Client uses explicitly provided member values over defaults
        it 'RpcV2CborClientUsesExplicitlyProvidedMemberValuesOverDefaults' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/OperationWithDefaults')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v2hkZWZhdWx0c7dtZGVmYXVsdFN0cmluZ2NieWVuZGVmYXVsdEJvb2xlYW71a2RlZmF1bHRMaXN0gWFhcGRlZmF1bHRUaW1lc3RhbXDB+z/wAAAAAAAAa2RlZmF1bHRCbG9iQmhpa2RlZmF1bHRCeXRlAmxkZWZhdWx0U2hvcnQCbmRlZmF1bHRJbnRlZ2VyFGtkZWZhdWx0TG9uZxjIbGRlZmF1bHRGbG9hdPpAAAAAbWRlZmF1bHREb3VibGX7QAAAAAAAAABqZGVmYXVsdE1hcKFkbmFtZWRKYWNra2RlZmF1bHRFbnVtY0JBUm5kZWZhdWx0SW50RW51bQJrZW1wdHlTdHJpbmdjZm9vbGZhbHNlQm9vbGVhbvVpZW1wdHlCbG9iQmhpaHplcm9CeXRlAWl6ZXJvU2hvcnQBa3plcm9JbnRlZ2VyAWh6ZXJvTG9uZwFpemVyb0Zsb2F0+j+AAABqemVyb0RvdWJsZfs/8AAAAAAAAP8=')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.operation_with_defaults({
            defaults: {
              default_string: "bye",
              default_boolean: true,
              default_list: [
                "a"
              ],
              default_timestamp: Time.at(1),
              default_blob: 'hi',
              default_byte: 2,
              default_short: 2,
              default_integer: 20,
              default_long: 200,
              default_float: 2.0,
              default_double: 2.0,
              default_map: {
                'name' => "Jack"
              },
              default_enum: "BAR",
              default_int_enum: 2,
              empty_string: "foo",
              false_boolean: true,
              empty_blob: 'hi',
              zero_byte: 1,
              zero_short: 1,
              zero_integer: 1,
              zero_long: 1,
              zero_float: 1.0,
              zero_double: 1.0
            }
          }, **opts)
        end

        # Any time a value is provided for a member in the top level of input, it is used, regardless of if its the default.
        it 'RpcV2CborClientUsesExplicitlyProvidedValuesInTopLevel' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/OperationWithDefaults')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v290b3BMZXZlbERlZmF1bHRiaGl0b3RoZXJUb3BMZXZlbERlZmF1bHQA/w==')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.operation_with_defaults({
            top_level_default: "hi",
            other_top_level_default: 0
          }, **opts)
        end

        # Typically, non top-level members would have defaults filled in, but if they have the clientOptional trait, the defaults should be ignored.
        it 'RpcV2CborClientIgnoresNonTopLevelDefaultsOnMembersWithClientOptional' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/OperationWithDefaults')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v3ZjbGllbnRPcHRpb25hbERlZmF1bHRzoP8=')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.operation_with_defaults({
            client_optional_defaults: {}
          }, **opts)
        end

      end

      describe 'responses' do

        # Client populates default values when missing in response.
        it 'RpcV2CborClientPopulatesDefaultsValuesWhenMissingInResponse' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v/8='))
          response.body.rewind
          client.stub_responses(:operation_with_defaults, response)
          allow(Builders::OperationWithDefaults).to receive(:build)
          output = client.operation_with_defaults({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            default_string: "hi",
            default_boolean: true,
            default_list: [

            ],
            default_timestamp: Time.at(0),
            default_blob: 'abc',
            default_byte: 1,
            default_short: 1,
            default_integer: 10,
            default_long: 100,
            default_float: 1.0,
            default_double: 1.0,
            default_map: {

            },
            default_enum: "FOO",
            default_int_enum: 1,
            empty_string: "",
            false_boolean: false,
            empty_blob: '',
            zero_byte: 0,
            zero_short: 0,
            zero_integer: 0,
            zero_long: 0,
            zero_float: 0.0,
            zero_double: 0.0
          })
        end

        # Client ignores default values if member values are present in the response.
        it 'RpcV2CborClientIgnoresDefaultValuesIfMemberValuesArePresentInResponse' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v21kZWZhdWx0U3RyaW5nY2J5ZW5kZWZhdWx0Qm9vbGVhbvRrZGVmYXVsdExpc3SBYWFwZGVmYXVsdFRpbWVzdGFtcMH7QAAAAAAAAABrZGVmYXVsdEJsb2JCaGlrZGVmYXVsdEJ5dGUCbGRlZmF1bHRTaG9ydAJuZGVmYXVsdEludGVnZXIUa2RlZmF1bHRMb25nGMhsZGVmYXVsdEZsb2F0+kAAAABtZGVmYXVsdERvdWJsZftAAAAAAAAAAGpkZWZhdWx0TWFwoWRuYW1lZEphY2trZGVmYXVsdEVudW1jQkFSbmRlZmF1bHRJbnRFbnVtAmtlbXB0eVN0cmluZ2Nmb29sZmFsc2VCb29sZWFu9WllbXB0eUJsb2JCaGloemVyb0J5dGUBaXplcm9TaG9ydAFremVyb0ludGVnZXIBaHplcm9Mb25nAWl6ZXJvRmxvYXT6P4AAAGp6ZXJvRG91Ymxl+z/wAAAAAAAA/w=='))
          response.body.rewind
          client.stub_responses(:operation_with_defaults, response)
          allow(Builders::OperationWithDefaults).to receive(:build)
          output = client.operation_with_defaults({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            default_string: "bye",
            default_boolean: false,
            default_list: [
              "a"
            ],
            default_timestamp: Time.at(2),
            default_blob: 'hi',
            default_byte: 2,
            default_short: 2,
            default_integer: 20,
            default_long: 200,
            default_float: 2.0,
            default_double: 2.0,
            default_map: {
              'name' => "Jack"
            },
            default_enum: "BAR",
            default_int_enum: 2,
            empty_string: "foo",
            false_boolean: true,
            empty_blob: 'hi',
            zero_byte: 1,
            zero_short: 1,
            zero_integer: 1,
            zero_long: 1,
            zero_float: 1.0,
            zero_double: 1.0
          })
        end

      end

      describe 'stubs' do

        # Client populates default values when missing in response.
        it 'RpcV2CborClientPopulatesDefaultsValuesWhenMissingInResponse' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::OperationWithDefaults).to receive(:build)
          client.stub_responses(:operation_with_defaults, data: {
            default_string: "hi",
            default_boolean: true,
            default_list: [

            ],
            default_timestamp: Time.at(0),
            default_blob: 'abc',
            default_byte: 1,
            default_short: 1,
            default_integer: 10,
            default_long: 100,
            default_float: 1.0,
            default_double: 1.0,
            default_map: {

            },
            default_enum: "FOO",
            default_int_enum: 1,
            empty_string: "",
            false_boolean: false,
            empty_blob: '',
            zero_byte: 0,
            zero_short: 0,
            zero_integer: 0,
            zero_long: 0,
            zero_float: 0.0,
            zero_double: 0.0
          })
          output = client.operation_with_defaults({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            default_string: "hi",
            default_boolean: true,
            default_list: [

            ],
            default_timestamp: Time.at(0),
            default_blob: 'abc',
            default_byte: 1,
            default_short: 1,
            default_integer: 10,
            default_long: 100,
            default_float: 1.0,
            default_double: 1.0,
            default_map: {

            },
            default_enum: "FOO",
            default_int_enum: 1,
            empty_string: "",
            false_boolean: false,
            empty_blob: '',
            zero_byte: 0,
            zero_short: 0,
            zero_integer: 0,
            zero_long: 0,
            zero_float: 0.0,
            zero_double: 0.0
          })
        end

        # Client ignores default values if member values are present in the response.
        it 'RpcV2CborClientIgnoresDefaultValuesIfMemberValuesArePresentInResponse' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::OperationWithDefaults).to receive(:build)
          client.stub_responses(:operation_with_defaults, data: {
            default_string: "bye",
            default_boolean: false,
            default_list: [
              "a"
            ],
            default_timestamp: Time.at(2),
            default_blob: 'hi',
            default_byte: 2,
            default_short: 2,
            default_integer: 20,
            default_long: 200,
            default_float: 2.0,
            default_double: 2.0,
            default_map: {
              'name' => "Jack"
            },
            default_enum: "BAR",
            default_int_enum: 2,
            empty_string: "foo",
            false_boolean: true,
            empty_blob: 'hi',
            zero_byte: 1,
            zero_short: 1,
            zero_integer: 1,
            zero_long: 1,
            zero_float: 1.0,
            zero_double: 1.0
          })
          output = client.operation_with_defaults({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            default_string: "bye",
            default_boolean: false,
            default_list: [
              "a"
            ],
            default_timestamp: Time.at(2),
            default_blob: 'hi',
            default_byte: 2,
            default_short: 2,
            default_integer: 20,
            default_long: 200,
            default_float: 2.0,
            default_double: 2.0,
            default_map: {
              'name' => "Jack"
            },
            default_enum: "BAR",
            default_int_enum: 2,
            empty_string: "foo",
            false_boolean: true,
            empty_blob: 'hi',
            zero_byte: 1,
            zero_short: 1,
            zero_integer: 1,
            zero_long: 1,
            zero_float: 1.0,
            zero_double: 1.0
          })
        end

      end

    end

    describe '#optional_input_output' do

      describe 'requests' do

        # When input is empty we write CBOR equivalent of {}
        it 'optional_input' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/OptionalInputOutput')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['X-Amz-Target'].each { |k| expect(request.headers.key?(k)).to be(false) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v/8=')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.optional_input_output({}, **opts)
        end

      end

      describe 'responses' do

        # When output is empty we write CBOR equivalent of {}
        it 'optional_output' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v/8='))
          response.body.rewind
          client.stub_responses(:optional_input_output, response)
          allow(Builders::OptionalInputOutput).to receive(:build)
          output = client.optional_input_output({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({})
        end

      end

      describe 'stubs' do

        # When output is empty we write CBOR equivalent of {}
        it 'optional_output' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::OptionalInputOutput).to receive(:build)
          client.stub_responses(:optional_input_output, data: {})
          output = client.optional_input_output({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({})
        end

      end

    end

    describe '#recursive_shapes' do

      describe 'requests' do

        # Serializes recursive structures
        it 'RpcV2CborRecursiveShapes' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/RecursiveShapes')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v2ZuZXN0ZWS/Y2Zvb2RGb28xZm5lc3RlZL9jYmFyZEJhcjFvcmVjdXJzaXZlTWVtYmVyv2Nmb29kRm9vMmZuZXN0ZWS/Y2JhcmRCYXIy//////8=')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.recursive_shapes({
            nested: {
              foo: "Foo1",
              nested: {
                bar: "Bar1",
                recursive_member: {
                  foo: "Foo2",
                  nested: {
                    bar: "Bar2"
                  }
                }
              }
            }
          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes recursive structures
        it 'RpcV2CborRecursiveShapes' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2ZuZXN0ZWS/Y2Zvb2RGb28xZm5lc3RlZL9jYmFyZEJhcjFvcmVjdXJzaXZlTWVtYmVyv2Nmb29kRm9vMmZuZXN0ZWS/Y2JhcmRCYXIy//////8='))
          response.body.rewind
          client.stub_responses(:recursive_shapes, response)
          allow(Builders::RecursiveShapes).to receive(:build)
          output = client.recursive_shapes({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            nested: {
              foo: "Foo1",
              nested: {
                bar: "Bar1",
                recursive_member: {
                  foo: "Foo2",
                  nested: {
                    bar: "Bar2"
                  }
                }
              }
            }
          })
        end

        # Deserializes recursive structures encoded using a map with definite length
        it 'RpcV2CborRecursiveShapesUsingDefiniteLength' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('oWZuZXN0ZWSiY2Zvb2RGb28xZm5lc3RlZKJjYmFyZEJhcjFvcmVjdXJzaXZlTWVtYmVyomNmb29kRm9vMmZuZXN0ZWShY2JhcmRCYXIy'))
          response.body.rewind
          client.stub_responses(:recursive_shapes, response)
          allow(Builders::RecursiveShapes).to receive(:build)
          output = client.recursive_shapes({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            nested: {
              foo: "Foo1",
              nested: {
                bar: "Bar1",
                recursive_member: {
                  foo: "Foo2",
                  nested: {
                    bar: "Bar2"
                  }
                }
              }
            }
          })
        end

      end

      describe 'stubs' do

        # Serializes recursive structures
        it 'RpcV2CborRecursiveShapes' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RecursiveShapes).to receive(:build)
          client.stub_responses(:recursive_shapes, data: {
            nested: {
              foo: "Foo1",
              nested: {
                bar: "Bar1",
                recursive_member: {
                  foo: "Foo2",
                  nested: {
                    bar: "Bar2"
                  }
                }
              }
            }
          })
          output = client.recursive_shapes({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            nested: {
              foo: "Foo1",
              nested: {
                bar: "Bar1",
                recursive_member: {
                  foo: "Foo2",
                  nested: {
                    bar: "Bar2"
                  }
                }
              }
            }
          })
        end

        # Deserializes recursive structures encoded using a map with definite length
        it 'RpcV2CborRecursiveShapesUsingDefiniteLength' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RecursiveShapes).to receive(:build)
          client.stub_responses(:recursive_shapes, data: {
            nested: {
              foo: "Foo1",
              nested: {
                bar: "Bar1",
                recursive_member: {
                  foo: "Foo2",
                  nested: {
                    bar: "Bar2"
                  }
                }
              }
            }
          })
          output = client.recursive_shapes({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            nested: {
              foo: "Foo1",
              nested: {
                bar: "Bar1",
                recursive_member: {
                  foo: "Foo2",
                  nested: {
                    bar: "Bar2"
                  }
                }
              }
            }
          })
        end

      end

    end

    describe '#rpc_v2_cbor_dense_maps' do

      describe 'requests' do

        # Serializes maps
        it 'RpcV2CborMaps' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/RpcV2CborDenseMaps')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('oW5kZW5zZVN0cnVjdE1hcKJjZm9voWJoaWV0aGVyZWNiYXqhYmhpY2J5ZQ==')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.rpc_v2_cbor_dense_maps({
            dense_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            }
          }, **opts)
        end

        # Ensure that 0 and false are sent over the wire in all maps and lists
        it 'RpcV2CborSerializesZeroValuesInMaps' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/RpcV2CborDenseMaps')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('om5kZW5zZU51bWJlck1hcKFheABvZGVuc2VCb29sZWFuTWFwoWF49A==')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.rpc_v2_cbor_dense_maps({
            dense_number_map: {
              'x' => 0
            },
            dense_boolean_map: {
              'x' => false
            }
          }, **opts)
        end

        # A request that contains a dense map of sets.
        it 'RpcV2CborSerializesDenseSetMap' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/RpcV2CborDenseMaps')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('oWtkZW5zZVNldE1hcKJheIBheYJhYWFi')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.rpc_v2_cbor_dense_maps({
            dense_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          }, **opts)
        end

      end

      describe 'responses' do

        # Deserializes maps
        it 'RpcV2CborMaps' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('oW5kZW5zZVN0cnVjdE1hcKJjZm9voWJoaWV0aGVyZWNiYXqhYmhpY2J5ZQ=='))
          response.body.rewind
          client.stub_responses(:rpc_v2_cbor_dense_maps, response)
          allow(Builders::RpcV2CborDenseMaps).to receive(:build)
          output = client.rpc_v2_cbor_dense_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            dense_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            }
          })
        end

        # Ensure that 0 and false are sent over the wire in all maps and lists
        it 'RpcV2CborDeserializesZeroValuesInMaps' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('om5kZW5zZU51bWJlck1hcKFheABvZGVuc2VCb29sZWFuTWFwoWF49A=='))
          response.body.rewind
          client.stub_responses(:rpc_v2_cbor_dense_maps, response)
          allow(Builders::RpcV2CborDenseMaps).to receive(:build)
          output = client.rpc_v2_cbor_dense_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            dense_number_map: {
              'x' => 0
            },
            dense_boolean_map: {
              'x' => false
            }
          })
        end

        # A response that contains a dense map of sets
        it 'RpcV2CborDeserializesDenseSetMap' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('oWtkZW5zZVNldE1hcKJheIBheYJhYWFi'))
          response.body.rewind
          client.stub_responses(:rpc_v2_cbor_dense_maps, response)
          allow(Builders::RpcV2CborDenseMaps).to receive(:build)
          output = client.rpc_v2_cbor_dense_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            dense_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
        end

        # Clients SHOULD tolerate seeing a null value in a dense map, and they SHOULD
        # drop the null key-value pair.
        it 'RpcV2CborDeserializesDenseSetMapAndSkipsNull' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('oWtkZW5zZVNldE1hcKNheIBheYJhYWFiYXr2'))
          response.body.rewind
          client.stub_responses(:rpc_v2_cbor_dense_maps, response)
          allow(Builders::RpcV2CborDenseMaps).to receive(:build)
          output = client.rpc_v2_cbor_dense_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            dense_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
        end

      end

      describe 'stubs' do

        # Deserializes maps
        it 'RpcV2CborMaps' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RpcV2CborDenseMaps).to receive(:build)
          client.stub_responses(:rpc_v2_cbor_dense_maps, data: {
            dense_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            }
          })
          output = client.rpc_v2_cbor_dense_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            dense_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            }
          })
        end

        # Ensure that 0 and false are sent over the wire in all maps and lists
        it 'RpcV2CborDeserializesZeroValuesInMaps' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RpcV2CborDenseMaps).to receive(:build)
          client.stub_responses(:rpc_v2_cbor_dense_maps, data: {
            dense_number_map: {
              'x' => 0
            },
            dense_boolean_map: {
              'x' => false
            }
          })
          output = client.rpc_v2_cbor_dense_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            dense_number_map: {
              'x' => 0
            },
            dense_boolean_map: {
              'x' => false
            }
          })
        end

        # A response that contains a dense map of sets
        it 'RpcV2CborDeserializesDenseSetMap' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RpcV2CborDenseMaps).to receive(:build)
          client.stub_responses(:rpc_v2_cbor_dense_maps, data: {
            dense_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
          output = client.rpc_v2_cbor_dense_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            dense_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
        end

        # Clients SHOULD tolerate seeing a null value in a dense map, and they SHOULD
        # drop the null key-value pair.
        it 'RpcV2CborDeserializesDenseSetMapAndSkipsNull' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RpcV2CborDenseMaps).to receive(:build)
          client.stub_responses(:rpc_v2_cbor_dense_maps, data: {
            dense_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
          output = client.rpc_v2_cbor_dense_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            dense_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
        end

      end

    end

    describe '#rpc_v2_cbor_lists' do

      describe 'requests' do

        # Serializes RpcV2 Cbor lists
        it 'RpcV2CborLists' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/RpcV2CborLists')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v2pzdHJpbmdMaXN0gmNmb29jYmFyaXN0cmluZ1NldIJjZm9vY2JhcmtpbnRlZ2VyTGlzdIIBAmtib29sZWFuTGlzdIL19G10aW1lc3RhbXBMaXN0gsH7QdTX+/OAAADB+0HU1/vzgAAAaGVudW1MaXN0gmNGb29hMGtpbnRFbnVtTGlzdIIBAnBuZXN0ZWRTdHJpbmdMaXN0goJjZm9vY2JhcoJjYmF6Y3F1eG1zdHJ1Y3R1cmVMaXN0gqJhYWExYWJhMqJhYWEzYWJhNGhibG9iTGlzdIJDZm9vQ2Jhcv8=')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.rpc_v2_cbor_lists({
            string_list: [
              "foo",
              "bar"
            ],
            string_set: [
              "foo",
              "bar"
            ],
            integer_list: [
              1,
              2
            ],
            boolean_list: [
              true,
              false
            ],
            timestamp_list: [
              Time.at(1398796238),
              Time.at(1398796238)
            ],
            enum_list: [
              "Foo",
              "0"
            ],
            int_enum_list: [
              1,
              2
            ],
            nested_string_list: [
              [
                "foo",
                "bar"
              ],
              [
                "baz",
                "qux"
              ]
            ],
            structure_list: [
              {
                a: "1",
                b: "2"
              },
              {
                a: "3",
                b: "4"
              }
            ],
            blob_list: [
              'foo',
              'bar'
            ]
          }, **opts)
        end

        # Serializes empty JSON lists
        it 'RpcV2CborListsEmpty' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/RpcV2CborLists')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v2pzdHJpbmdMaXN0n///')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.rpc_v2_cbor_lists({
            string_list: [

            ]
          }, **opts)
        end

        # Serializes empty JSON definite length lists
        it 'RpcV2CborListsEmptyUsingDefiniteLength' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/RpcV2CborLists')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('oWpzdHJpbmdMaXN0gA==')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.rpc_v2_cbor_lists({
            string_list: [

            ]
          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes RpcV2 Cbor lists
        it 'RpcV2CborLists' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2pzdHJpbmdMaXN0n2Nmb29jYmFy/2lzdHJpbmdTZXSfY2Zvb2NiYXL/a2ludGVnZXJMaXN0nwEC/2tib29sZWFuTGlzdJ/19P9tdGltZXN0YW1wTGlzdJ/B+0HU1/vzgAAAwftB1Nf784AAAP9oZW51bUxpc3SfY0Zvb2Ew/2tpbnRFbnVtTGlzdJ8BAv9wbmVzdGVkU3RyaW5nTGlzdJ+fY2Zvb2NiYXL/n2NiYXpjcXV4//9tc3RydWN0dXJlTGlzdJ+/YWFhMWFiYTL/v2FhYTNhYmE0//9oYmxvYkxpc3SfQ2Zvb0NiYXL//w=='))
          response.body.rewind
          client.stub_responses(:rpc_v2_cbor_lists, response)
          allow(Builders::RpcV2CborLists).to receive(:build)
          output = client.rpc_v2_cbor_lists({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            string_list: [
              "foo",
              "bar"
            ],
            string_set: [
              "foo",
              "bar"
            ],
            integer_list: [
              1,
              2
            ],
            boolean_list: [
              true,
              false
            ],
            timestamp_list: [
              Time.at(1398796238),
              Time.at(1398796238)
            ],
            enum_list: [
              "Foo",
              "0"
            ],
            int_enum_list: [
              1,
              2
            ],
            nested_string_list: [
              [
                "foo",
                "bar"
              ],
              [
                "baz",
                "qux"
              ]
            ],
            structure_list: [
              {
                a: "1",
                b: "2"
              },
              {
                a: "3",
                b: "4"
              }
            ],
            blob_list: [
              'foo',
              'bar'
            ]
          })
        end

        # Serializes empty RpcV2 Cbor lists
        it 'RpcV2CborListsEmpty' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2pzdHJpbmdMaXN0n///'))
          response.body.rewind
          client.stub_responses(:rpc_v2_cbor_lists, response)
          allow(Builders::RpcV2CborLists).to receive(:build)
          output = client.rpc_v2_cbor_lists({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            string_list: [

            ]
          })
        end

        # Can deserialize indefinite length text strings inside an indefinite length list
        it 'RpcV2CborIndefiniteStringInsideIndefiniteListCanDeserialize' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2pzdHJpbmdMaXN0n394HUFuIGV4YW1wbGUgaW5kZWZpbml0ZSBzdHJpbmcsdyB3aGljaCB3aWxsIGJlIGNodW5rZWQsbiBvbiBlYWNoIGNvbW1h/394NUFub3RoZXIgZXhhbXBsZSBpbmRlZmluaXRlIHN0cmluZyB3aXRoIG9ubHkgb25lIGNodW5r/3ZUaGlzIGlzIGEgcGxhaW4gc3RyaW5n//8='))
          response.body.rewind
          client.stub_responses(:rpc_v2_cbor_lists, response)
          allow(Builders::RpcV2CborLists).to receive(:build)
          output = client.rpc_v2_cbor_lists({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            string_list: [
              "An example indefinite string, which will be chunked, on each comma",
              "Another example indefinite string with only one chunk",
              "This is a plain string"
            ]
          })
        end

        # Can deserialize indefinite length text strings inside a definite length list
        it 'RpcV2CborIndefiniteStringInsideDefiniteListCanDeserialize' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('oWpzdHJpbmdMaXN0g394HUFuIGV4YW1wbGUgaW5kZWZpbml0ZSBzdHJpbmcsdyB3aGljaCB3aWxsIGJlIGNodW5rZWQsbiBvbiBlYWNoIGNvbW1h/394NUFub3RoZXIgZXhhbXBsZSBpbmRlZmluaXRlIHN0cmluZyB3aXRoIG9ubHkgb25lIGNodW5r/3ZUaGlzIGlzIGEgcGxhaW4gc3RyaW5n'))
          response.body.rewind
          client.stub_responses(:rpc_v2_cbor_lists, response)
          allow(Builders::RpcV2CborLists).to receive(:build)
          output = client.rpc_v2_cbor_lists({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            string_list: [
              "An example indefinite string, which will be chunked, on each comma",
              "Another example indefinite string with only one chunk",
              "This is a plain string"
            ]
          })
        end

      end

      describe 'stubs' do

        # Serializes RpcV2 Cbor lists
        it 'RpcV2CborLists' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RpcV2CborLists).to receive(:build)
          client.stub_responses(:rpc_v2_cbor_lists, data: {
            string_list: [
              "foo",
              "bar"
            ],
            string_set: [
              "foo",
              "bar"
            ],
            integer_list: [
              1,
              2
            ],
            boolean_list: [
              true,
              false
            ],
            timestamp_list: [
              Time.at(1398796238),
              Time.at(1398796238)
            ],
            enum_list: [
              "Foo",
              "0"
            ],
            int_enum_list: [
              1,
              2
            ],
            nested_string_list: [
              [
                "foo",
                "bar"
              ],
              [
                "baz",
                "qux"
              ]
            ],
            structure_list: [
              {
                a: "1",
                b: "2"
              },
              {
                a: "3",
                b: "4"
              }
            ],
            blob_list: [
              'foo',
              'bar'
            ]
          })
          output = client.rpc_v2_cbor_lists({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            string_list: [
              "foo",
              "bar"
            ],
            string_set: [
              "foo",
              "bar"
            ],
            integer_list: [
              1,
              2
            ],
            boolean_list: [
              true,
              false
            ],
            timestamp_list: [
              Time.at(1398796238),
              Time.at(1398796238)
            ],
            enum_list: [
              "Foo",
              "0"
            ],
            int_enum_list: [
              1,
              2
            ],
            nested_string_list: [
              [
                "foo",
                "bar"
              ],
              [
                "baz",
                "qux"
              ]
            ],
            structure_list: [
              {
                a: "1",
                b: "2"
              },
              {
                a: "3",
                b: "4"
              }
            ],
            blob_list: [
              'foo',
              'bar'
            ]
          })
        end

        # Serializes empty RpcV2 Cbor lists
        it 'RpcV2CborListsEmpty' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RpcV2CborLists).to receive(:build)
          client.stub_responses(:rpc_v2_cbor_lists, data: {
            string_list: [

            ]
          })
          output = client.rpc_v2_cbor_lists({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            string_list: [

            ]
          })
        end

        # Can deserialize indefinite length text strings inside an indefinite length list
        it 'RpcV2CborIndefiniteStringInsideIndefiniteListCanDeserialize' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RpcV2CborLists).to receive(:build)
          client.stub_responses(:rpc_v2_cbor_lists, data: {
            string_list: [
              "An example indefinite string, which will be chunked, on each comma",
              "Another example indefinite string with only one chunk",
              "This is a plain string"
            ]
          })
          output = client.rpc_v2_cbor_lists({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            string_list: [
              "An example indefinite string, which will be chunked, on each comma",
              "Another example indefinite string with only one chunk",
              "This is a plain string"
            ]
          })
        end

        # Can deserialize indefinite length text strings inside a definite length list
        it 'RpcV2CborIndefiniteStringInsideDefiniteListCanDeserialize' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RpcV2CborLists).to receive(:build)
          client.stub_responses(:rpc_v2_cbor_lists, data: {
            string_list: [
              "An example indefinite string, which will be chunked, on each comma",
              "Another example indefinite string with only one chunk",
              "This is a plain string"
            ]
          })
          output = client.rpc_v2_cbor_lists({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            string_list: [
              "An example indefinite string, which will be chunked, on each comma",
              "Another example indefinite string with only one chunk",
              "This is a plain string"
            ]
          })
        end

      end

    end

    describe '#rpc_v2_cbor_sparse_maps' do

      describe 'requests' do

        # Serializes sparse maps
        it 'RpcV2CborSparseMaps' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/RpcV2CborSparseMaps')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v29zcGFyc2VTdHJ1Y3RNYXC/Y2Zvb79iaGlldGhlcmX/Y2Jher9iaGljYnll////')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.rpc_v2_cbor_sparse_maps({
            sparse_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            }
          }, **opts)
        end

        # Serializes null map values in sparse maps
        it 'RpcV2CborSerializesNullMapValues' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/RpcV2CborSparseMaps')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v3BzcGFyc2VCb29sZWFuTWFwv2F49v9vc3BhcnNlTnVtYmVyTWFwv2F49v9vc3BhcnNlU3RyaW5nTWFwv2F49v9vc3BhcnNlU3RydWN0TWFwv2F49v//')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.rpc_v2_cbor_sparse_maps({
            sparse_boolean_map: {
              'x' => nil
            },
            sparse_number_map: {
              'x' => nil
            },
            sparse_string_map: {
              'x' => nil
            },
            sparse_struct_map: {
              'x' => nil
            }
          }, **opts)
        end

        # A request that contains a sparse map of sets
        it 'RpcV2CborSerializesSparseSetMap' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/RpcV2CborSparseMaps')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v2xzcGFyc2VTZXRNYXC/YXif/2F5n2FhYWL///8=')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.rpc_v2_cbor_sparse_maps({
            sparse_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          }, **opts)
        end

        # A request that contains a sparse map of sets.
        it 'RpcV2CborSerializesSparseSetMapAndRetainsNull' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/RpcV2CborSparseMaps')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v2xzcGFyc2VTZXRNYXC/YXif/2F5n2FhYWL/YXr2//8=')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.rpc_v2_cbor_sparse_maps({
            sparse_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ],
              'z' => nil
            }
          }, **opts)
        end

        # Ensure that 0 and false are sent over the wire in all maps and lists
        it 'RpcV2CborSerializesZeroValuesInSparseMaps' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/RpcV2CborSparseMaps')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v29zcGFyc2VOdW1iZXJNYXC/YXgA/3BzcGFyc2VCb29sZWFuTWFwv2F49P//')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.rpc_v2_cbor_sparse_maps({
            sparse_number_map: {
              'x' => 0
            },
            sparse_boolean_map: {
              'x' => false
            }
          }, **opts)
        end

      end

      describe 'responses' do

        # Deserializes sparse maps
        it 'RpcV2CborSparseJsonMaps' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v29zcGFyc2VTdHJ1Y3RNYXC/Y2Zvb79iaGlldGhlcmX/Y2Jher9iaGljYnll////'))
          response.body.rewind
          client.stub_responses(:rpc_v2_cbor_sparse_maps, response)
          allow(Builders::RpcV2CborSparseMaps).to receive(:build)
          output = client.rpc_v2_cbor_sparse_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            sparse_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            }
          })
        end

        # Deserializes null map values
        it 'RpcV2CborDeserializesNullMapValues' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v3BzcGFyc2VCb29sZWFuTWFwv2F49v9vc3BhcnNlTnVtYmVyTWFwv2F49v9vc3BhcnNlU3RyaW5nTWFwv2F49v9vc3BhcnNlU3RydWN0TWFwv2F49v//'))
          response.body.rewind
          client.stub_responses(:rpc_v2_cbor_sparse_maps, response)
          allow(Builders::RpcV2CborSparseMaps).to receive(:build)
          output = client.rpc_v2_cbor_sparse_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            sparse_boolean_map: {
              'x' => nil
            },
            sparse_number_map: {
              'x' => nil
            },
            sparse_string_map: {
              'x' => nil
            },
            sparse_struct_map: {
              'x' => nil
            }
          })
        end

        # A response that contains a sparse map of sets
        it 'RpcV2CborDeserializesSparseSetMap' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2xzcGFyc2VTZXRNYXC/YXmfYWFhYv9heJ////8='))
          response.body.rewind
          client.stub_responses(:rpc_v2_cbor_sparse_maps, response)
          allow(Builders::RpcV2CborSparseMaps).to receive(:build)
          output = client.rpc_v2_cbor_sparse_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            sparse_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
        end

        # A response that contains a sparse map of sets with a null
        it 'RpcV2CborDeserializesSparseSetMapAndRetainsNull' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2xzcGFyc2VTZXRNYXC/YXif/2F5n2FhYWL/YXr2//8='))
          response.body.rewind
          client.stub_responses(:rpc_v2_cbor_sparse_maps, response)
          allow(Builders::RpcV2CborSparseMaps).to receive(:build)
          output = client.rpc_v2_cbor_sparse_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            sparse_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ],
              'z' => nil
            }
          })
        end

        # Ensure that 0 and false are sent over the wire in all maps and lists
        it 'RpcV2CborDeserializesZeroValuesInSparseMaps' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v29zcGFyc2VOdW1iZXJNYXC/YXgA/3BzcGFyc2VCb29sZWFuTWFwv2F49P//'))
          response.body.rewind
          client.stub_responses(:rpc_v2_cbor_sparse_maps, response)
          allow(Builders::RpcV2CborSparseMaps).to receive(:build)
          output = client.rpc_v2_cbor_sparse_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            sparse_number_map: {
              'x' => 0
            },
            sparse_boolean_map: {
              'x' => false
            }
          })
        end

      end

      describe 'stubs' do

        # Deserializes sparse maps
        it 'RpcV2CborSparseJsonMaps' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RpcV2CborSparseMaps).to receive(:build)
          client.stub_responses(:rpc_v2_cbor_sparse_maps, data: {
            sparse_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            }
          })
          output = client.rpc_v2_cbor_sparse_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            sparse_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            }
          })
        end

        # Deserializes null map values
        it 'RpcV2CborDeserializesNullMapValues' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RpcV2CborSparseMaps).to receive(:build)
          client.stub_responses(:rpc_v2_cbor_sparse_maps, data: {
            sparse_boolean_map: {
              'x' => nil
            },
            sparse_number_map: {
              'x' => nil
            },
            sparse_string_map: {
              'x' => nil
            },
            sparse_struct_map: {
              'x' => nil
            }
          })
          output = client.rpc_v2_cbor_sparse_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            sparse_boolean_map: {
              'x' => nil
            },
            sparse_number_map: {
              'x' => nil
            },
            sparse_string_map: {
              'x' => nil
            },
            sparse_struct_map: {
              'x' => nil
            }
          })
        end

        # A response that contains a sparse map of sets
        it 'RpcV2CborDeserializesSparseSetMap' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RpcV2CborSparseMaps).to receive(:build)
          client.stub_responses(:rpc_v2_cbor_sparse_maps, data: {
            sparse_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
          output = client.rpc_v2_cbor_sparse_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            sparse_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
        end

        # A response that contains a sparse map of sets with a null
        it 'RpcV2CborDeserializesSparseSetMapAndRetainsNull' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RpcV2CborSparseMaps).to receive(:build)
          client.stub_responses(:rpc_v2_cbor_sparse_maps, data: {
            sparse_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ],
              'z' => nil
            }
          })
          output = client.rpc_v2_cbor_sparse_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            sparse_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ],
              'z' => nil
            }
          })
        end

        # Ensure that 0 and false are sent over the wire in all maps and lists
        it 'RpcV2CborDeserializesZeroValuesInSparseMaps' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::RpcV2CborSparseMaps).to receive(:build)
          client.stub_responses(:rpc_v2_cbor_sparse_maps, data: {
            sparse_number_map: {
              'x' => 0
            },
            sparse_boolean_map: {
              'x' => false
            }
          })
          output = client.rpc_v2_cbor_sparse_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            sparse_number_map: {
              'x' => 0
            },
            sparse_boolean_map: {
              'x' => false
            }
          })
        end

      end

    end

    describe '#simple_scalar_properties' do

      describe 'requests' do

        # Serializes simple scalar properties
        it 'RpcV2CborSimpleScalarProperties' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/SimpleScalarProperties')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v2lieXRlVmFsdWUFa2RvdWJsZVZhbHVl+z/+OVgQYk3TcWZhbHNlQm9vbGVhblZhbHVl9GpmbG9hdFZhbHVl+kD0AABsaW50ZWdlclZhbHVlGQEAaWxvbmdWYWx1ZRkmkWpzaG9ydFZhbHVlGSaqa3N0cmluZ1ZhbHVlZnNpbXBsZXB0cnVlQm9vbGVhblZhbHVl9WlibG9iVmFsdWVDZm9v/w==')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.simple_scalar_properties({
            byte_value: 5,
            double_value: 1.889,
            false_boolean_value: false,
            float_value: 7.625,
            integer_value: 256,
            long_value: 9873,
            short_value: 9898,
            string_value: "simple",
            true_boolean_value: true,
            blob_value: 'foo'
          }, **opts)
        end

        # RpcV2 Cbor should not serialize null structure values
        it 'RpcV2CborClientDoesntSerializeNullStructureValues' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/SimpleScalarProperties')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v/8=')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.simple_scalar_properties({
            string_value: nil
          }, **opts)
        end

        # Supports handling NaN float values.
        it 'RpcV2CborSupportsNaNFloatInputs' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/SimpleScalarProperties')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v2tkb3VibGVWYWx1Zft/+AAAAAAAAGpmbG9hdFZhbHVl+n/AAAD/')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.simple_scalar_properties({
            double_value: Float::NAN,
            float_value: Float::NAN
          }, **opts)
        end

        # Supports handling Infinity float values.
        it 'RpcV2CborSupportsInfinityFloatInputs' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/SimpleScalarProperties')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v2tkb3VibGVWYWx1Zft/8AAAAAAAAGpmbG9hdFZhbHVl+n+AAAD/')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.simple_scalar_properties({
            double_value: Float::INFINITY,
            float_value: Float::INFINITY
          }, **opts)
        end

        # Supports handling Infinity float values.
        it 'RpcV2CborSupportsNegativeInfinityFloatInputs' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/SimpleScalarProperties')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v2tkb3VibGVWYWx1Zfv/8AAAAAAAAGpmbG9hdFZhbHVl+v+AAAD/')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.simple_scalar_properties({
            double_value: -Float::INFINITY,
            float_value: -Float::INFINITY
          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes simple scalar properties
        it 'RpcV2CborSimpleScalarProperties' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v3B0cnVlQm9vbGVhblZhbHVl9XFmYWxzZUJvb2xlYW5WYWx1ZfRpYnl0ZVZhbHVlBWtkb3VibGVWYWx1Zfs//jlYEGJN02pmbG9hdFZhbHVl+kD0AABsaW50ZWdlclZhbHVlGQEAanNob3J0VmFsdWUZJqprc3RyaW5nVmFsdWVmc2ltcGxlaWJsb2JWYWx1ZUNmb2//'))
          response.body.rewind
          client.stub_responses(:simple_scalar_properties, response)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          output = client.simple_scalar_properties({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            true_boolean_value: true,
            false_boolean_value: false,
            byte_value: 5,
            double_value: 1.889,
            float_value: 7.625,
            integer_value: 256,
            short_value: 9898,
            string_value: "simple",
            blob_value: 'foo'
          })
        end

        # Deserializes simple scalar properties encoded using a map with definite length
        it 'RpcV2CborSimpleScalarPropertiesUsingDefiniteLength' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('qXB0cnVlQm9vbGVhblZhbHVl9XFmYWxzZUJvb2xlYW5WYWx1ZfRpYnl0ZVZhbHVlBWtkb3VibGVWYWx1Zfs//jlYEGJN02pmbG9hdFZhbHVl+kD0AABsaW50ZWdlclZhbHVlGQEAanNob3J0VmFsdWUZJqprc3RyaW5nVmFsdWVmc2ltcGxlaWJsb2JWYWx1ZUNmb28='))
          response.body.rewind
          client.stub_responses(:simple_scalar_properties, response)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          output = client.simple_scalar_properties({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            true_boolean_value: true,
            false_boolean_value: false,
            byte_value: 5,
            double_value: 1.889,
            float_value: 7.625,
            integer_value: 256,
            short_value: 9898,
            string_value: "simple",
            blob_value: 'foo'
          })
        end

        # RpcV2 Cbor should not deserialize null structure values
        it 'RpcV2CborClientDoesntDeserializeNullStructureValues' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2tzdHJpbmdWYWx1Zfb/'))
          response.body.rewind
          client.stub_responses(:simple_scalar_properties, response)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          output = client.simple_scalar_properties({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({})
        end

        # Supports handling NaN float values.
        it 'RpcV2CborSupportsNaNFloatOutputs' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2tkb3VibGVWYWx1Zft/+AAAAAAAAGpmbG9hdFZhbHVl+n/AAAD/'))
          response.body.rewind
          client.stub_responses(:simple_scalar_properties, response)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          output = client.simple_scalar_properties({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            double_value: Float::NAN,
            float_value: Float::NAN
          })
        end

        # Supports handling Infinity float values.
        it 'RpcV2CborSupportsInfinityFloatOutputs' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2tkb3VibGVWYWx1Zft/8AAAAAAAAGpmbG9hdFZhbHVl+n+AAAD/'))
          response.body.rewind
          client.stub_responses(:simple_scalar_properties, response)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          output = client.simple_scalar_properties({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            double_value: Float::INFINITY,
            float_value: Float::INFINITY
          })
        end

        # Supports handling Negative Infinity float values.
        it 'RpcV2CborSupportsNegativeInfinityFloatOutputs' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2tkb3VibGVWYWx1Zfv/8AAAAAAAAGpmbG9hdFZhbHVl+v+AAAD/'))
          response.body.rewind
          client.stub_responses(:simple_scalar_properties, response)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          output = client.simple_scalar_properties({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            double_value: -Float::INFINITY,
            float_value: -Float::INFINITY
          })
        end

        # Supports upcasting from a smaller byte representation of the same data type.
        it 'RpcV2CborSupportsUpcastingDataOnDeserialize' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2tkb3VibGVWYWx1Zfk+AGpmbG9hdFZhbHVl+UegbGludGVnZXJWYWx1ZRg4aWxvbmdWYWx1ZRkBAGpzaG9ydFZhbHVlCv8='))
          response.body.rewind
          client.stub_responses(:simple_scalar_properties, response)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          output = client.simple_scalar_properties({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            double_value: 1.5,
            float_value: 7.625,
            integer_value: 56,
            long_value: 256,
            short_value: 10
          })
        end

        # The client should skip over additional fields that are not part of the structure. This allows a
        # client generated against an older Smithy model to be able to communicate with a server that is
        # generated against a newer Smithy model.
        it 'RpcV2CborExtraFieldsInTheBodyShouldBeSkippedByClients' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v2lieXRlVmFsdWUFa2RvdWJsZVZhbHVl+z/+OVgQYk3TcWZhbHNlQm9vbGVhblZhbHVl9GpmbG9hdFZhbHVl+kD0AABrZXh0cmFPYmplY3S/c2luZGVmaW5pdGVMZW5ndGhNYXC/a3dpdGhBbkFycmF5nwECA///cWRlZmluaXRlTGVuZ3RoTWFwo3J3aXRoQURlZmluaXRlQXJyYXmDAQIDeB1hbmRTb21lSW5kZWZpbml0ZUxlbmd0aFN0cmluZ3gfdGhhdCBoYXMsIGJlZW4gY2h1bmtlZCBvbiBjb21tYWxub3JtYWxTdHJpbmdjZm9vanNob3J0VmFsdWUZJw9uc29tZU90aGVyRmllbGR2dGhpcyBzaG91bGQgYmUgc2tpcHBlZP9saW50ZWdlclZhbHVlGQEAaWxvbmdWYWx1ZRkmkWpzaG9ydFZhbHVlGSaqa3N0cmluZ1ZhbHVlZnNpbXBsZXB0cnVlQm9vbGVhblZhbHVl9WlibG9iVmFsdWVDZm9v/w=='))
          response.body.rewind
          client.stub_responses(:simple_scalar_properties, response)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          output = client.simple_scalar_properties({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            byte_value: 5,
            double_value: 1.889,
            false_boolean_value: false,
            float_value: 7.625,
            integer_value: 256,
            long_value: 9873,
            short_value: 9898,
            string_value: "simple",
            true_boolean_value: true,
            blob_value: 'foo'
          })
        end

      end

      describe 'stubs' do

        # Serializes simple scalar properties
        it 'RpcV2CborSimpleScalarProperties' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          client.stub_responses(:simple_scalar_properties, data: {
            true_boolean_value: true,
            false_boolean_value: false,
            byte_value: 5,
            double_value: 1.889,
            float_value: 7.625,
            integer_value: 256,
            short_value: 9898,
            string_value: "simple",
            blob_value: 'foo'
          })
          output = client.simple_scalar_properties({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            true_boolean_value: true,
            false_boolean_value: false,
            byte_value: 5,
            double_value: 1.889,
            float_value: 7.625,
            integer_value: 256,
            short_value: 9898,
            string_value: "simple",
            blob_value: 'foo'
          })
        end

        # Deserializes simple scalar properties encoded using a map with definite length
        it 'RpcV2CborSimpleScalarPropertiesUsingDefiniteLength' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          client.stub_responses(:simple_scalar_properties, data: {
            true_boolean_value: true,
            false_boolean_value: false,
            byte_value: 5,
            double_value: 1.889,
            float_value: 7.625,
            integer_value: 256,
            short_value: 9898,
            string_value: "simple",
            blob_value: 'foo'
          })
          output = client.simple_scalar_properties({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            true_boolean_value: true,
            false_boolean_value: false,
            byte_value: 5,
            double_value: 1.889,
            float_value: 7.625,
            integer_value: 256,
            short_value: 9898,
            string_value: "simple",
            blob_value: 'foo'
          })
        end

        # RpcV2 Cbor should not deserialize null structure values
        it 'RpcV2CborClientDoesntDeserializeNullStructureValues' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          client.stub_responses(:simple_scalar_properties, data: {})
          output = client.simple_scalar_properties({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({})
        end

        # Supports handling NaN float values.
        it 'RpcV2CborSupportsNaNFloatOutputs' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          client.stub_responses(:simple_scalar_properties, data: {
            double_value: Float::NAN,
            float_value: Float::NAN
          })
          output = client.simple_scalar_properties({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            double_value: Float::NAN,
            float_value: Float::NAN
          })
        end

        # Supports handling Infinity float values.
        it 'RpcV2CborSupportsInfinityFloatOutputs' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          client.stub_responses(:simple_scalar_properties, data: {
            double_value: Float::INFINITY,
            float_value: Float::INFINITY
          })
          output = client.simple_scalar_properties({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            double_value: Float::INFINITY,
            float_value: Float::INFINITY
          })
        end

        # Supports handling Negative Infinity float values.
        it 'RpcV2CborSupportsNegativeInfinityFloatOutputs' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          client.stub_responses(:simple_scalar_properties, data: {
            double_value: -Float::INFINITY,
            float_value: -Float::INFINITY
          })
          output = client.simple_scalar_properties({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            double_value: -Float::INFINITY,
            float_value: -Float::INFINITY
          })
        end

        # Supports upcasting from a smaller byte representation of the same data type.
        it 'RpcV2CborSupportsUpcastingDataOnDeserialize' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          client.stub_responses(:simple_scalar_properties, data: {
            double_value: 1.5,
            float_value: 7.625,
            integer_value: 56,
            long_value: 256,
            short_value: 10
          })
          output = client.simple_scalar_properties({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            double_value: 1.5,
            float_value: 7.625,
            integer_value: 56,
            long_value: 256,
            short_value: 10
          })
        end

        # The client should skip over additional fields that are not part of the structure. This allows a
        # client generated against an older Smithy model to be able to communicate with a server that is
        # generated against a newer Smithy model.
        it 'RpcV2CborExtraFieldsInTheBodyShouldBeSkippedByClients' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          client.stub_responses(:simple_scalar_properties, data: {
            byte_value: 5,
            double_value: 1.889,
            false_boolean_value: false,
            float_value: 7.625,
            integer_value: 256,
            long_value: 9873,
            short_value: 9898,
            string_value: "simple",
            true_boolean_value: true,
            blob_value: 'foo'
          })
          output = client.simple_scalar_properties({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            byte_value: 5,
            double_value: 1.889,
            false_boolean_value: false,
            float_value: 7.625,
            integer_value: 256,
            long_value: 9873,
            short_value: 9898,
            string_value: "simple",
            true_boolean_value: true,
            blob_value: 'foo'
          })
        end

      end

    end

    describe '#sparse_nulls_operation' do

      describe 'requests' do

        # Serializes null values in maps
        it 'RpcV2CborSparseMapsSerializeNullValues' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/SparseNullsOperation')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v29zcGFyc2VTdHJpbmdNYXC/Y2Zvb/b//w==')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.sparse_nulls_operation({
            sparse_string_map: {
              'foo' => nil
            }
          }, **opts)
        end

        # Serializes null values in lists
        it 'RpcV2CborSparseListsSerializeNull' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/service/RpcV2Protocol/operation/SparseNullsOperation')
            { 'Content-Type' => 'application/cbor', 'smithy-protocol' => 'rpc-v2-cbor' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(Hearth::CBOR.decode(request.body.read)).to match_cbor(Hearth::CBOR.decode(::Base64.decode64('v3BzcGFyc2VTdHJpbmdMaXN0n/b//w==')))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.sparse_nulls_operation({
            sparse_string_list: [
              nil
            ]
          }, **opts)
        end

      end

      describe 'responses' do

        # Deserializes null values in maps
        it 'RpcV2CborSparseMapsDeserializeNullValues' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v29zcGFyc2VTdHJpbmdNYXC/Y2Zvb/b//w=='))
          response.body.rewind
          client.stub_responses(:sparse_nulls_operation, response)
          allow(Builders::SparseNullsOperation).to receive(:build)
          output = client.sparse_nulls_operation({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            sparse_string_map: {
              'foo' => nil
            }
          })
        end

        # Deserializes null values in lists
        it 'RpcV2CborSparseListsDeserializeNull' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/cbor'
          response.headers['smithy-protocol'] = 'rpc-v2-cbor'
          response.body.write(::Base64.decode64('v3BzcGFyc2VTdHJpbmdMaXN0n/b//w=='))
          response.body.rewind
          client.stub_responses(:sparse_nulls_operation, response)
          allow(Builders::SparseNullsOperation).to receive(:build)
          output = client.sparse_nulls_operation({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            sparse_string_list: [
              nil
            ]
          })
        end

      end

      describe 'stubs' do

        # Deserializes null values in maps
        it 'RpcV2CborSparseMapsDeserializeNullValues' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SparseNullsOperation).to receive(:build)
          client.stub_responses(:sparse_nulls_operation, data: {
            sparse_string_map: {
              'foo' => nil
            }
          })
          output = client.sparse_nulls_operation({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            sparse_string_map: {
              'foo' => nil
            }
          })
        end

        # Deserializes null values in lists
        it 'RpcV2CborSparseListsDeserializeNull' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SparseNullsOperation).to receive(:build)
          client.stub_responses(:sparse_nulls_operation, data: {
            sparse_string_list: [
              nil
            ]
          })
          output = client.sparse_nulls_operation({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to match_cbor({
            sparse_string_list: [
              nil
            ]
          })
        end

      end

    end

  end
end
