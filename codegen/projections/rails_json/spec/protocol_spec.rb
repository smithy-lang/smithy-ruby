# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'rails_json'

require 'hearth/xml/node_matcher'
require 'hearth/query/param_matcher'

module RailsJson
  describe Client do
    let(:endpoint) { 'http://127.0.0.1' }
    let(:client) { Client.new(stub_responses: true, endpoint: endpoint) }

    describe '#operation____789_bad_name' do

      describe 'requests' do
        # Serializes requests for operations/members with bad names
        #
        it 'rails_json_serializes_bad_names' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/BadName/abc_value')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"member":{"__123foo":"foo value"}}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.operation____789_bad_name({
            member___123abc: "abc_value",
            member: {
              member___123foo: "foo value"
            }
          }, **opts)
        end
      end

      describe 'responses' do
        # Parses responses for operations/members with bad names
        #
        it 'rails_json_parses_bad_names' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"member":{"__123foo":"foo value"}}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.operation____789_bad_name({}, middleware: middleware)
          expect(output.to_h).to eq({
            member: {
              member___123foo: "foo value"
            }
          })
        end
      end

      describe 'response stubs' do
        # Parses responses for operations/members with bad names
        #
        it 'stubs rails_json_parses_bad_names' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:operation____789_bad_name, {
            member: {
              member___123foo: "foo value"
            }
          })
          output = client.operation____789_bad_name({}, middleware: middleware)
          expect(output.to_h).to eq({
            member: {
              member___123foo: "foo value"
            }
          })
        end
      end

    end

    describe '#all_query_string_types' do

      describe 'requests' do
        # Serializes query string parameters with all supported types
        #
        it 'RailsJsonAllQueryStringTypes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/AllQueryStringTypesInput')
            expected_query = CGI.parse(['String=Hello%20there', 'StringList=a', 'StringList=b', 'StringList=c', 'StringSet=a', 'StringSet=b', 'StringSet=c', 'Byte=1', 'Short=2', 'Integer=3', 'IntegerList=1', 'IntegerList=2', 'IntegerList=3', 'IntegerSet=1', 'IntegerSet=2', 'IntegerSet=3', 'Long=4', 'Float=1.1', 'Double=1.1', 'DoubleList=1.1', 'DoubleList=2.1', 'DoubleList=3.1', 'Boolean=true', 'BooleanList=true', 'BooleanList=false', 'BooleanList=true', 'Timestamp=1970-01-01T00%3A00%3A01Z', 'TimestampList=1970-01-01T00%3A00%3A01Z', 'TimestampList=1970-01-01T00%3A00%3A02Z', 'TimestampList=1970-01-01T00%3A00%3A03Z', 'Enum=Foo', 'EnumList=Foo', 'EnumList=Baz', 'EnumList=Bar', 'QueryParamsStringKeyA=Foo', 'QueryParamsStringKeyB=Bar'].join('&'))
            actual_query = CGI.parse(request_uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.all_query_string_types({
            query_string: "Hello there",
            query_string_list: [
              "a",
              "b",
              "c"
            ],
            query_string_set: [
              "a",
              "b",
              "c"
            ],
            query_byte: 1,
            query_short: 2,
            query_integer: 3,
            query_integer_list: [
              1,
              2,
              3
            ],
            query_integer_set: [
              1,
              2,
              3
            ],
            query_long: 4,
            query_float: 1.1,
            query_double: 1.1,
            query_double_list: [
              1.1,
              2.1,
              3.1
            ],
            query_boolean: true,
            query_boolean_list: [
              true,
              false,
              true
            ],
            query_timestamp: Time.at(1),
            query_timestamp_list: [
              Time.at(1),
              Time.at(2),
              Time.at(3)
            ],
            query_enum: "Foo",
            query_enum_list: [
              "Foo",
              "Baz",
              "Bar"
            ],
            query_params_map_of_strings: {
              'QueryParamsStringKeyA' => "Foo",
              'QueryParamsStringKeyB' => "Bar"
            }
          }, **opts)
        end
      end

    end

    describe '#constant_and_variable_query_string' do

      describe 'requests' do
        # Mixes constant and variable query string parameters
        #
        it 'RailsJsonConstantAndVariableQueryStringMissingOneValue' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/ConstantAndVariableQueryString')
            expected_query = CGI.parse(['foo=bar', 'baz=bam'].join('&'))
            actual_query = CGI.parse(request_uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            forbid_query = ['maybeSet']
            actual_query = CGI.parse(request_uri.query)
            forbid_query.each do |query|
              expect(actual_query.key?(query)).to be false
            end
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.constant_and_variable_query_string({
            baz: "bam"
          }, **opts)
        end
        # Mixes constant and variable query string parameters
        #
        it 'RailsJsonConstantAndVariableQueryStringAllValues' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/ConstantAndVariableQueryString')
            expected_query = CGI.parse(['foo=bar', 'baz=bam', 'maybeSet=yes'].join('&'))
            actual_query = CGI.parse(request_uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.constant_and_variable_query_string({
            baz: "bam",
            maybe_set: "yes"
          }, **opts)
        end
      end

    end

    describe '#constant_query_string' do

      describe 'requests' do
        # Includes constant query string parameters
        #
        it 'RailsJsonConstantQueryString' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/ConstantQueryString/hi')
            expected_query = CGI.parse(['foo=bar', 'hello'].join('&'))
            actual_query = CGI.parse(request_uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.constant_query_string({
            hello: "hi"
          }, **opts)
        end
      end

    end

    describe '#document_type' do

      describe 'requests' do
        # Serializes document types as part of the JSON request payload with no escaping.
        #
        it 'RailsJsonDocumentTypeInputWithObject' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('PUT')
            expect(request_uri.path).to eq('/DocumentType')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "string_value": "string",
                "document_value": {
                    "foo": "bar"
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.document_type({
            string_value: "string",
            document_value: {'foo' => 'bar'}
          }, **opts)
        end
        # Serializes document types using a string.
        #
        it 'RailsJsonDocumentInputWithString' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('PUT')
            expect(request_uri.path).to eq('/DocumentType')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "string_value": "string",
                "document_value": "hello"
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.document_type({
            string_value: "string",
            document_value: 'hello'
          }, **opts)
        end
        # Serializes document types using a number.
        #
        it 'RailsJsonDocumentInputWithNumber' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('PUT')
            expect(request_uri.path).to eq('/DocumentType')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "string_value": "string",
                "document_value": 10
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.document_type({
            string_value: "string",
            document_value: 10
          }, **opts)
        end
        # Serializes document types using a boolean.
        #
        it 'RailsJsonDocumentInputWithBoolean' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('PUT')
            expect(request_uri.path).to eq('/DocumentType')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "string_value": "string",
                "document_value": true
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.document_type({
            string_value: "string",
            document_value: true
          }, **opts)
        end
        # Serializes document types using a list.
        #
        it 'RailsJsonDocumentInputWithList' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('PUT')
            expect(request_uri.path).to eq('/DocumentType')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "string_value": "string",
                "document_value": [
                    true,
                    "hi",
                    [
                        1,
                        2
                    ],
                    {
                        "foo": {
                            "baz": [
                                3,
                                4
                            ]
                        }
                    }
                ]
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.document_type({
            string_value: "string",
            document_value: [true, 'hi', [1, 2], {'foo' => {'baz' => [3, 4]}}]
          }, **opts)
        end
      end

      describe 'responses' do
        # Serializes documents as part of the JSON response payload with no escaping.
        #
        it 'RailsJsonDocumentOutput' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "string_value": "string",
                "document_value": {
                    "foo": "bar"
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.document_type({}, middleware: middleware)
          expect(output.to_h).to eq({
            string_value: "string",
            document_value: {'foo' => 'bar'}
          })
        end
        # Document types can be JSON scalars too.
        #
        it 'RailsJsonDocumentOutputString' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "string_value": "string",
                "document_value": "hello"
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.document_type({}, middleware: middleware)
          expect(output.to_h).to eq({
            string_value: "string",
            document_value: 'hello'
          })
        end
        # Document types can be JSON scalars too.
        #
        it 'RailsJsonDocumentOutputNumber' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "string_value": "string",
                "document_value": 10
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.document_type({}, middleware: middleware)
          expect(output.to_h).to eq({
            string_value: "string",
            document_value: 10
          })
        end
        # Document types can be JSON scalars too.
        #
        it 'RailsJsonDocumentOutputBoolean' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "string_value": "string",
                "document_value": false
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.document_type({}, middleware: middleware)
          expect(output.to_h).to eq({
            string_value: "string",
            document_value: false
          })
        end
        # Document types can be JSON arrays.
        #
        it 'RailsJsonDocumentOutputArray' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "string_value": "string",
                "document_value": [
                    true,
                    false
                ]
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.document_type({}, middleware: middleware)
          expect(output.to_h).to eq({
            string_value: "string",
            document_value: [true, false]
          })
        end
      end

      describe 'response stubs' do
        # Serializes documents as part of the JSON response payload with no escaping.
        #
        it 'stubs RailsJsonDocumentOutput' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:document_type, {
            string_value: "string",
            document_value: {'foo' => 'bar'}
          })
          output = client.document_type({}, middleware: middleware)
          expect(output.to_h).to eq({
            string_value: "string",
            document_value: {'foo' => 'bar'}
          })
        end
        # Document types can be JSON scalars too.
        #
        it 'stubs RailsJsonDocumentOutputString' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:document_type, {
            string_value: "string",
            document_value: 'hello'
          })
          output = client.document_type({}, middleware: middleware)
          expect(output.to_h).to eq({
            string_value: "string",
            document_value: 'hello'
          })
        end
        # Document types can be JSON scalars too.
        #
        it 'stubs RailsJsonDocumentOutputNumber' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:document_type, {
            string_value: "string",
            document_value: 10
          })
          output = client.document_type({}, middleware: middleware)
          expect(output.to_h).to eq({
            string_value: "string",
            document_value: 10
          })
        end
        # Document types can be JSON scalars too.
        #
        it 'stubs RailsJsonDocumentOutputBoolean' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:document_type, {
            string_value: "string",
            document_value: false
          })
          output = client.document_type({}, middleware: middleware)
          expect(output.to_h).to eq({
            string_value: "string",
            document_value: false
          })
        end
        # Document types can be JSON arrays.
        #
        it 'stubs RailsJsonDocumentOutputArray' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:document_type, {
            string_value: "string",
            document_value: [true, false]
          })
          output = client.document_type({}, middleware: middleware)
          expect(output.to_h).to eq({
            string_value: "string",
            document_value: [true, false]
          })
        end
      end

    end

    describe '#document_type_as_payload' do

      describe 'requests' do
        # Serializes a document as the target of the httpPayload trait.
        #
        it 'RailsJsonDocumentTypeAsPayloadInput' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('PUT')
            expect(request_uri.path).to eq('/DocumentTypeAsPayload')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "foo": "bar"
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.document_type_as_payload({
            document_value: {'foo' => 'bar'}
          }, **opts)
        end
        # Serializes a document as the target of the httpPayload trait using a string.
        #
        it 'RailsJsonDocumentTypeAsPayloadInputString' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('PUT')
            expect(request_uri.path).to eq('/DocumentTypeAsPayload')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('"hello"'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.document_type_as_payload({
            document_value: 'hello'
          }, **opts)
        end
      end

      describe 'responses' do
        # Serializes a document as the target of the httpPayload trait.
        #
        it 'RailsJsonDocumentTypeAsPayloadOutput' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "foo": "bar"
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.document_type_as_payload({}, middleware: middleware)
          expect(output.to_h).to eq({
            document_value: {'foo' => 'bar'}
          })
        end
        # Serializes a document as a payload string.
        #
        it 'RailsJsonDocumentTypeAsPayloadOutputString' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('"hello"')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.document_type_as_payload({}, middleware: middleware)
          expect(output.to_h).to eq({
            document_value: 'hello'
          })
        end
      end

      describe 'response stubs' do
        # Serializes a document as the target of the httpPayload trait.
        #
        it 'stubs RailsJsonDocumentTypeAsPayloadOutput' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:document_type_as_payload, {
            document_value: {'foo' => 'bar'}
          })
          output = client.document_type_as_payload({}, middleware: middleware)
          expect(output.to_h).to eq({
            document_value: {'foo' => 'bar'}
          })
        end
        # Serializes a document as a payload string.
        #
        it 'stubs RailsJsonDocumentTypeAsPayloadOutputString' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:document_type_as_payload, {
            document_value: 'hello'
          })
          output = client.document_type_as_payload({}, middleware: middleware)
          expect(output.to_h).to eq({
            document_value: 'hello'
          })
        end
      end

    end

    describe '#empty_operation' do

      describe 'responses' do
        # When no output is defined, the service is expected to return
        # an empty payload, however, client must ignore a JSON payload
        # if one is returned. This ensures that if output is added later,
        # then it will not break the client.
        #
        it 'rails_json_handles_empty_output_shape' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.empty_operation({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
        # This client-only test builds on handles_empty_output_shape,
        # by including unexpected fields in the JSON. A client
        # needs to ignore JSON output that is empty or that contains
        # JSON object data.
        #
        it 'rails_json_handles_unexpected_json_output' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "foo": true
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.empty_operation({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
        # When no output is defined, the service is expected to return
        # an empty payload. Despite the lack of a payload, the service
        # is expected to always send a Content-Type header. Clients must
        # handle cases where a service returns a JSON object and where
        # a service returns no JSON at all.
        #
        it 'rails_json_service_responds_with_no_payload' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.empty_operation({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
      end

      describe 'response stubs' do
        # When no output is defined, the service is expected to return
        # an empty payload, however, client must ignore a JSON payload
        # if one is returned. This ensures that if output is added later,
        # then it will not break the client.
        #
        it 'stubs rails_json_handles_empty_output_shape' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:empty_operation, {

          })
          output = client.empty_operation({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
        # This client-only test builds on handles_empty_output_shape,
        # by including unexpected fields in the JSON. A client
        # needs to ignore JSON output that is empty or that contains
        # JSON object data.
        #
        it 'stubs rails_json_handles_unexpected_json_output' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:empty_operation, {

          })
          output = client.empty_operation({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
        # When no output is defined, the service is expected to return
        # an empty payload. Despite the lack of a payload, the service
        # is expected to always send a Content-Type header. Clients must
        # handle cases where a service returns a JSON object and where
        # a service returns no JSON at all.
        #
        it 'stubs rails_json_service_responds_with_no_payload' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:empty_operation, {

          })
          output = client.empty_operation({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
      end

    end

    describe '#endpoint_operation' do

      describe 'requests' do
        # Operations can prepend to the given host if they define the
        # endpoint trait.
        #
        it 'RailsJsonEndpointTrait' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.host).to eq('foo.example.com')
            expect(request_uri.path).to eq('/endpoint')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          opts[:endpoint] = 'http://example.com'
          client.endpoint_operation({

          }, **opts)
        end
      end

    end

    describe '#endpoint_with_host_label_operation' do

      describe 'requests' do
        # Operations can prepend to the given host if they define the
        # endpoint trait, and can use the host label trait to define
        # further customization based on user input.
        #
        it 'RailsJsonEndpointTraitWithHostLabel' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.host).to eq('foo.bar.example.com')
            expect(request_uri.path).to eq('/endpointwithhostlabel')
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"label": "bar"}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          opts[:endpoint] = 'http://example.com'
          client.endpoint_with_host_label_operation({
            label: "bar"
          }, **opts)
        end
      end

    end

    describe '#greeting_with_errors' do

      describe 'InvalidGreeting Errors' do
        # Parses simple JSON errors
        #
        it 'RailsJsonInvalidGreetingError' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 400
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json', 'x-smithy-rails-error' => 'InvalidGreeting' })
            response.body = StringIO.new('{
                "message": "Hi"
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          begin
            client.greeting_with_errors({}, middleware: middleware)
          rescue Errors::InvalidGreeting => e
            expect(e.data.to_h).to eq({
              message: "Hi"
            })
          end
        end
      end

      describe 'ComplexError Errors' do
        # Parses a complex error with no message member
        #
        it 'RailsJsonComplexError' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 400
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json', 'x-smithy-rails-error' => 'ComplexError' })
            response.body = StringIO.new('{
                "top_level": "Top level",
                "nested": {
                    "Fooooo": "bar"
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          begin
            client.greeting_with_errors({}, middleware: middleware)
          rescue Errors::ComplexError => e
            expect(e.data.to_h).to eq({
              top_level: "Top level",
              nested: {
                foo: "bar"
              }
            })
          end
        end
        #
        #
        it 'RailsJsonEmptyComplexError' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 400
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json', 'x-smithy-rails-error' => 'ComplexError' })
            response.body = StringIO.new('{
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          begin
            client.greeting_with_errors({}, middleware: middleware)
          rescue Errors::ComplexError => e
            expect(e.data.to_h).to eq({

            })
          end
        end
      end

    end

    describe '#http_payload_traits' do

      describe 'requests' do
        # Serializes a blob in the HTTP payload
        #
        it 'RailsJsonHttpPayloadTraitsWithBlob' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/HttpPayloadTraits')
            { 'Content-Type' => 'application/octet-stream', 'X-Foo' => 'Foo' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(request.body.read).to eq('blobby blob blob')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.http_payload_traits({
            foo: "Foo",
            blob: 'blobby blob blob'
          }, **opts)
        end
        # Serializes an empty blob in the HTTP payload
        #
        it 'RailsJsonHttpPayloadTraitsWithNoBlobBody' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/HttpPayloadTraits')
            { 'X-Foo' => 'Foo' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.http_payload_traits({
            foo: "Foo"
          }, **opts)
        end
      end

      describe 'responses' do
        # Serializes a blob in the HTTP payload
        #
        it 'RailsJsonHttpPayloadTraitsWithBlob' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'X-Foo' => 'Foo' })
            response.body = StringIO.new('blobby blob blob')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.http_payload_traits({}, middleware: middleware)
          expect(output.to_h).to eq({
            foo: "Foo",
            blob: 'blobby blob blob'
          })
        end
        # Serializes an empty blob in the HTTP payload
        #
        it 'RailsJsonHttpPayloadTraitsWithNoBlobBody' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'X-Foo' => 'Foo' })
            response.body = StringIO.new('')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.http_payload_traits({}, middleware: middleware)
          expect(output.to_h).to eq({
            foo: "Foo"
          })
        end
      end

      describe 'response stubs' do
        # Serializes a blob in the HTTP payload
        #
        it 'stubs RailsJsonHttpPayloadTraitsWithBlob' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:http_payload_traits, {
            foo: "Foo",
            blob: 'blobby blob blob'
          })
          output = client.http_payload_traits({}, middleware: middleware)
          expect(output.to_h).to eq({
            foo: "Foo",
            blob: 'blobby blob blob'
          })
        end
        # Serializes an empty blob in the HTTP payload
        #
        it 'stubs RailsJsonHttpPayloadTraitsWithNoBlobBody' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:http_payload_traits, {
            foo: "Foo"
          })
          output = client.http_payload_traits({}, middleware: middleware)
          expect(output.to_h).to eq({
            foo: "Foo"
          })
        end
      end

    end

    describe '#http_payload_traits_with_media_type' do

      describe 'requests' do
        # Serializes a blob in the HTTP payload with a content-type
        #
        it 'RailsJsonHttpPayloadTraitsWithMediaTypeWithBlob' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/HttpPayloadTraitsWithMediaType')
            { 'Content-Type' => 'text/plain', 'X-Foo' => 'Foo' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(request.body.read).to eq('blobby blob blob')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.http_payload_traits_with_media_type({
            foo: "Foo",
            blob: 'blobby blob blob'
          }, **opts)
        end
      end

      describe 'responses' do
        # Serializes a blob in the HTTP payload with a content-type
        #
        it 'RailsJsonHttpPayloadTraitsWithMediaTypeWithBlob' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'text/plain', 'X-Foo' => 'Foo' })
            response.body = StringIO.new('blobby blob blob')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.http_payload_traits_with_media_type({}, middleware: middleware)
          expect(output.to_h).to eq({
            foo: "Foo",
            blob: 'blobby blob blob'
          })
        end
      end

      describe 'response stubs' do
        # Serializes a blob in the HTTP payload with a content-type
        #
        it 'stubs RailsJsonHttpPayloadTraitsWithMediaTypeWithBlob' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:http_payload_traits_with_media_type, {
            foo: "Foo",
            blob: 'blobby blob blob'
          })
          output = client.http_payload_traits_with_media_type({}, middleware: middleware)
          expect(output.to_h).to eq({
            foo: "Foo",
            blob: 'blobby blob blob'
          })
        end
      end

    end

    describe '#http_payload_with_structure' do

      describe 'requests' do
        # Serializes a structure in the payload
        #
        it 'RailsJsonHttpPayloadWithStructure' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('PUT')
            expect(request_uri.path).to eq('/HttpPayloadWithStructure')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "greeting": "hello",
                "name": "Phreddy"
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.http_payload_with_structure({
            nested: {
              greeting: "hello",
              name: "Phreddy"
            }
          }, **opts)
        end
      end

      describe 'responses' do
        # Serializes a structure in the payload
        #
        it 'RailsJsonHttpPayloadWithStructure' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "greeting": "hello",
                "name": "Phreddy"
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.http_payload_with_structure({}, middleware: middleware)
          expect(output.to_h).to eq({
            nested: {
              greeting: "hello",
              name: "Phreddy"
            }
          })
        end
      end

      describe 'response stubs' do
        # Serializes a structure in the payload
        #
        it 'stubs RailsJsonHttpPayloadWithStructure' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:http_payload_with_structure, {
            nested: {
              greeting: "hello",
              name: "Phreddy"
            }
          })
          output = client.http_payload_with_structure({}, middleware: middleware)
          expect(output.to_h).to eq({
            nested: {
              greeting: "hello",
              name: "Phreddy"
            }
          })
        end
      end

    end

    describe '#http_prefix_headers' do

      describe 'requests' do
        # Adds headers by prefix
        #
        it 'RailsJsonHttpPrefixHeadersArePresent' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/HttpPrefixHeaders')
            { 'X-Foo' => 'Foo', 'X-Foo-Abc' => 'Abc value', 'X-Foo-Def' => 'Def value' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.http_prefix_headers({
            foo: "Foo",
            foo_map: {
              'Abc' => "Abc value",
              'Def' => "Def value"
            }
          }, **opts)
        end
        # No prefix headers are serialized because the value is empty
        #
        it 'RailsJsonHttpPrefixHeadersAreNotPresent' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/HttpPrefixHeaders')
            { 'X-Foo' => 'Foo' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.http_prefix_headers({
            foo: "Foo",
            foo_map: {

            }
          }, **opts)
        end
      end

      describe 'responses' do
        # Adds headers by prefix
        #
        it 'RailsJsonHttpPrefixHeadersArePresent' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'X-Foo' => 'Foo', 'X-Foo-Abc' => 'Abc value', 'X-Foo-Def' => 'Def value' })
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.http_prefix_headers({}, middleware: middleware)
          expect(output.to_h).to eq({
            foo: "Foo",
            foo_map: {
              'Abc' => "Abc value",
              'Def' => "Def value"
            }
          })
        end
      end

      describe 'response stubs' do
        # Adds headers by prefix
        #
        it 'stubs RailsJsonHttpPrefixHeadersArePresent' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:http_prefix_headers, {
            foo: "Foo",
            foo_map: {
              'Abc' => "Abc value",
              'Def' => "Def value"
            }
          })
          output = client.http_prefix_headers({}, middleware: middleware)
          expect(output.to_h).to eq({
            foo: "Foo",
            foo_map: {
              'Abc' => "Abc value",
              'Def' => "Def value"
            }
          })
        end
      end

    end

    describe '#http_prefix_headers_in_response' do

      describe 'responses' do
        # (de)serializes all response headers
        #
        it 'RailsJsonHttpPrefixHeadersResponse' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Hello' => 'Hello', 'X-Foo' => 'Foo' })
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.http_prefix_headers_in_response({}, middleware: middleware)
          expect(output.to_h).to eq({
            prefix_headers: {
              'X-Foo' => "Foo",
              'Hello' => "Hello"
            }
          })
        end
      end

      describe 'response stubs' do
        # (de)serializes all response headers
        #
        it 'stubs RailsJsonHttpPrefixHeadersResponse' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:http_prefix_headers_in_response, {
            prefix_headers: {
              'X-Foo' => "Foo",
              'Hello' => "Hello"
            }
          })
          output = client.http_prefix_headers_in_response({}, middleware: middleware)
          expect(output.to_h).to eq({
            prefix_headers: {
              'X-Foo' => "Foo",
              'Hello' => "Hello"
            }
          })
        end
      end

    end

    describe '#http_request_with_float_labels' do

      describe 'requests' do
        # Supports handling NaN float label values.
        #
        it 'RailsJsonSupportsNaNFloatLabels' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/FloatHttpLabels/NaN/NaN')
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.http_request_with_float_labels({
            float: Float::NAN,
            double: Float::NAN
          }, **opts)
        end
        # Supports handling Infinity float label values.
        #
        it 'RailsJsonSupportsInfinityFloatLabels' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/FloatHttpLabels/Infinity/Infinity')
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.http_request_with_float_labels({
            float: Float::INFINITY,
            double: Float::INFINITY
          }, **opts)
        end
        # Supports handling -Infinity float label values.
        #
        it 'RailsJsonSupportsNegativeInfinityFloatLabels' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/FloatHttpLabels/-Infinity/-Infinity')
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.http_request_with_float_labels({
            float: -Float::INFINITY,
            double: -Float::INFINITY
          }, **opts)
        end
      end

    end

    describe '#http_request_with_greedy_label_in_path' do

      describe 'requests' do
        # Serializes greedy labels and normal labels
        #
        it 'RailsJsonHttpRequestWithGreedyLabelInPath' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/HttpRequestWithGreedyLabelInPath/foo/hello%2Fescape/baz/there/guy')
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.http_request_with_greedy_label_in_path({
            foo: "hello/escape",
            baz: "there/guy"
          }, **opts)
        end
      end

    end

    describe '#http_request_with_labels' do

      describe 'requests' do
        # Sends a GET request that uses URI label bindings
        #
        it 'RailsJsonInputWithHeadersAndAllParams' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/HttpRequestWithLabels/string/1/2/3/4.1/5.1/true/2019-12-16T23%3A48%3A18Z')
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.http_request_with_labels({
            string: "string",
            short: 1,
            integer: 2,
            long: 3,
            float: 4.1,
            double: 5.1,
            boolean: true,
            timestamp: Time.at(1576540098)
          }, **opts)
        end
        # Sends a GET request that uses URI label bindings
        #
        it 'RailsJsonHttpRequestLabelEscaping' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/HttpRequestWithLabels/%25%3A%2F%3F%23%5B%5D%40%21%24%26%27%28%29%2A%2B%2C%3B%3D%F0%9F%98%B9/1/2/3/4.1/5.1/true/2019-12-16T23%3A48%3A18Z')
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.http_request_with_labels({
            string: "%:/?#[]@!$&'()*+,;=😹",
            short: 1,
            integer: 2,
            long: 3,
            float: 4.1,
            double: 5.1,
            boolean: true,
            timestamp: Time.at(1576540098)
          }, **opts)
        end
      end

    end

    describe '#http_request_with_labels_and_timestamp_format' do

      describe 'requests' do
        # Serializes different timestamp formats in URI labels
        #
        it 'RailsJsonHttpRequestWithLabelsAndTimestampFormat' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/HttpRequestWithLabelsAndTimestampFormat/1576540098/Mon%2C%2016%20Dec%202019%2023%3A48%3A18%20GMT/2019-12-16T23%3A48%3A18Z/2019-12-16T23%3A48%3A18Z/1576540098/Mon%2C%2016%20Dec%202019%2023%3A48%3A18%20GMT/2019-12-16T23%3A48%3A18Z')
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.http_request_with_labels_and_timestamp_format({
            member_epoch_seconds: Time.at(1576540098),
            member_http_date: Time.at(1576540098),
            member_date_time: Time.at(1576540098),
            default_format: Time.at(1576540098),
            target_epoch_seconds: Time.at(1576540098),
            target_http_date: Time.at(1576540098),
            target_date_time: Time.at(1576540098)
          }, **opts)
        end
      end

    end

    describe '#http_response_code' do

      describe 'responses' do
        # Binds the http response code to an output structure. Note that
        # even though all members are bound outside of the payload, an
        # empty JSON object is serialized in the response. However,
        # clients should be able to handle an empty JSON object or an
        # empty payload without failing to deserialize a response.
        #
        it 'RailsJsonHttpResponseCode' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 201
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.http_response_code({}, middleware: middleware)
          expect(output.to_h).to eq({
            status: 201
          })
        end
        # This test ensures that clients gracefully handle cases where
        # the service responds with no payload rather than an empty JSON
        # object.
        #
        it 'RailsJsonHttpResponseCodeWithNoPayload' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 201
            response.body = StringIO.new('')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.http_response_code({}, middleware: middleware)
          expect(output.to_h).to eq({
            status: 201
          })
        end
      end

      describe 'response stubs' do
        # Binds the http response code to an output structure. Note that
        # even though all members are bound outside of the payload, an
        # empty JSON object is serialized in the response. However,
        # clients should be able to handle an empty JSON object or an
        # empty payload without failing to deserialize a response.
        #
        it 'stubs RailsJsonHttpResponseCode' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(201)
          end
          middleware.remove_build
          client.stub_responses(:http_response_code, {
            status: 201
          })
          output = client.http_response_code({}, middleware: middleware)
          expect(output.to_h).to eq({
            status: 201
          })
        end
        # This test ensures that clients gracefully handle cases where
        # the service responds with no payload rather than an empty JSON
        # object.
        #
        it 'stubs RailsJsonHttpResponseCodeWithNoPayload' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(201)
          end
          middleware.remove_build
          client.stub_responses(:http_response_code, {
            status: 201
          })
          output = client.http_response_code({}, middleware: middleware)
          expect(output.to_h).to eq({
            status: 201
          })
        end
      end

    end

    describe '#ignore_query_params_in_response' do

      describe 'responses' do
        # Query parameters must be ignored when serializing the output
        # of an operation. As of January 2021, server implementations
        # are expected to respond with a JSON object regardless of
        # if the output parameters are empty.
        #
        it 'RailsJsonIgnoreQueryParamsInResponse' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.ignore_query_params_in_response({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
        # This test is similar to RestJsonIgnoreQueryParamsInResponse,
        # but it ensures that clients gracefully handle responses from
        # the server that do not serialize an empty JSON object.
        #
        it 'RailsJsonIgnoreQueryParamsInResponseNoPayload' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.body = StringIO.new('')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.ignore_query_params_in_response({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
      end

      describe 'response stubs' do
        # Query parameters must be ignored when serializing the output
        # of an operation. As of January 2021, server implementations
        # are expected to respond with a JSON object regardless of
        # if the output parameters are empty.
        #
        it 'stubs RailsJsonIgnoreQueryParamsInResponse' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:ignore_query_params_in_response, {

          })
          output = client.ignore_query_params_in_response({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
        # This test is similar to RestJsonIgnoreQueryParamsInResponse,
        # but it ensures that clients gracefully handle responses from
        # the server that do not serialize an empty JSON object.
        #
        it 'stubs RailsJsonIgnoreQueryParamsInResponseNoPayload' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:ignore_query_params_in_response, {

          })
          output = client.ignore_query_params_in_response({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
      end

    end

    describe '#input_and_output_with_headers' do

      describe 'requests' do
        # Tests requests with string header bindings
        #
        it 'RailsJsonInputAndOutputWithStringHeaders' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/InputAndOutputWithHeaders')
            { 'X-String' => 'Hello', 'X-StringList' => 'a, b, c', 'X-StringSet' => 'a, b, c' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.input_and_output_with_headers({
            header_string: "Hello",
            header_string_list: [
              "a",
              "b",
              "c"
            ],
            header_string_set: [
              "a",
              "b",
              "c"
            ]
          }, **opts)
        end
        # Tests requests with numeric header bindings
        #
        it 'RailsJsonInputAndOutputWithNumericHeaders' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/InputAndOutputWithHeaders')
            { 'X-Byte' => '1', 'X-Double' => '1.1', 'X-Float' => '1.1', 'X-Integer' => '123', 'X-IntegerList' => '1, 2, 3', 'X-Long' => '123', 'X-Short' => '123' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.input_and_output_with_headers({
            header_byte: 1,
            header_short: 123,
            header_integer: 123,
            header_long: 123,
            header_float: 1.1,
            header_double: 1.1,
            header_integer_list: [
              1,
              2,
              3
            ]
          }, **opts)
        end
        # Tests requests with boolean header bindings
        #
        it 'RailsJsonInputAndOutputWithBooleanHeaders' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/InputAndOutputWithHeaders')
            { 'X-Boolean1' => 'true', 'X-Boolean2' => 'false', 'X-BooleanList' => 'true, false, true' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.input_and_output_with_headers({
            header_true_bool: true,
            header_false_bool: false,
            header_boolean_list: [
              true,
              false,
              true
            ]
          }, **opts)
        end
        # Tests requests with enum header bindings
        #
        it 'RailsJsonInputAndOutputWithEnumHeaders' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/InputAndOutputWithHeaders')
            { 'X-Enum' => 'Foo', 'X-EnumList' => 'Foo, Bar, Baz' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.input_and_output_with_headers({
            header_enum: "Foo",
            header_enum_list: [
              "Foo",
              "Bar",
              "Baz"
            ]
          }, **opts)
        end
      end

      describe 'responses' do
        # Tests responses with string header bindings
        #
        it 'RailsJsonInputAndOutputWithStringHeaders' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'X-String' => 'Hello', 'X-StringList' => 'a, b, c', 'X-StringSet' => 'a, b, c' })
            response.body = StringIO.new('')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.input_and_output_with_headers({}, middleware: middleware)
          expect(output.to_h).to eq({
            header_string: "Hello",
            header_string_list: [
              "a",
              "b",
              "c"
            ],
            header_string_set: [
              "a",
              "b",
              "c"
            ]
          })
        end
        # Tests requests with string list header bindings that require quoting
        #
        it 'RailsJsonInputAndOutputWithQuotedStringHeaders', skip: 'Not Supported'  do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'X-StringList' => '"b,c", "\"def\"", a' })
            response.body = StringIO.new('')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.input_and_output_with_headers({}, middleware: middleware)
          expect(output.to_h).to eq({
            header_string_list: [
              "b,c",
              "\"def\"",
              "a"
            ]
          })
        end
        # Tests responses with numeric header bindings
        #
        it 'RailsJsonInputAndOutputWithNumericHeaders' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'X-Byte' => '1', 'X-Double' => '1.1', 'X-Float' => '1.1', 'X-Integer' => '123', 'X-IntegerList' => '1, 2, 3', 'X-Long' => '123', 'X-Short' => '123' })
            response.body = StringIO.new('')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.input_and_output_with_headers({}, middleware: middleware)
          expect(output.to_h).to eq({
            header_byte: 1,
            header_short: 123,
            header_integer: 123,
            header_long: 123,
            header_float: 1.1,
            header_double: 1.1,
            header_integer_list: [
              1,
              2,
              3
            ]
          })
        end
        # Tests responses with boolean header bindings
        #
        it 'RailsJsonInputAndOutputWithBooleanHeaders' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'X-Boolean1' => 'true', 'X-Boolean2' => 'false', 'X-BooleanList' => 'true, false, true' })
            response.body = StringIO.new('')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.input_and_output_with_headers({}, middleware: middleware)
          expect(output.to_h).to eq({
            header_true_bool: true,
            header_false_bool: false,
            header_boolean_list: [
              true,
              false,
              true
            ]
          })
        end
        # Tests responses with enum header bindings
        #
        it 'RailsJsonInputAndOutputWithEnumHeaders' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'X-Enum' => 'Foo', 'X-EnumList' => 'Foo, Bar, Baz' })
            response.body = StringIO.new('')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.input_and_output_with_headers({}, middleware: middleware)
          expect(output.to_h).to eq({
            header_enum: "Foo",
            header_enum_list: [
              "Foo",
              "Bar",
              "Baz"
            ]
          })
        end
      end

      describe 'response stubs' do
        # Tests responses with string header bindings
        #
        it 'stubs RailsJsonInputAndOutputWithStringHeaders' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:input_and_output_with_headers, {
            header_string: "Hello",
            header_string_list: [
              "a",
              "b",
              "c"
            ],
            header_string_set: [
              "a",
              "b",
              "c"
            ]
          })
          output = client.input_and_output_with_headers({}, middleware: middleware)
          expect(output.to_h).to eq({
            header_string: "Hello",
            header_string_list: [
              "a",
              "b",
              "c"
            ],
            header_string_set: [
              "a",
              "b",
              "c"
            ]
          })
        end
        # Tests requests with string list header bindings that require quoting
        #
        it 'stubs RailsJsonInputAndOutputWithQuotedStringHeaders', skip: 'Not Supported'  do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:input_and_output_with_headers, {
            header_string_list: [
              "b,c",
              "\"def\"",
              "a"
            ]
          })
          output = client.input_and_output_with_headers({}, middleware: middleware)
          expect(output.to_h).to eq({
            header_string_list: [
              "b,c",
              "\"def\"",
              "a"
            ]
          })
        end
        # Tests responses with numeric header bindings
        #
        it 'stubs RailsJsonInputAndOutputWithNumericHeaders' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:input_and_output_with_headers, {
            header_byte: 1,
            header_short: 123,
            header_integer: 123,
            header_long: 123,
            header_float: 1.1,
            header_double: 1.1,
            header_integer_list: [
              1,
              2,
              3
            ]
          })
          output = client.input_and_output_with_headers({}, middleware: middleware)
          expect(output.to_h).to eq({
            header_byte: 1,
            header_short: 123,
            header_integer: 123,
            header_long: 123,
            header_float: 1.1,
            header_double: 1.1,
            header_integer_list: [
              1,
              2,
              3
            ]
          })
        end
        # Tests responses with boolean header bindings
        #
        it 'stubs RailsJsonInputAndOutputWithBooleanHeaders' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:input_and_output_with_headers, {
            header_true_bool: true,
            header_false_bool: false,
            header_boolean_list: [
              true,
              false,
              true
            ]
          })
          output = client.input_and_output_with_headers({}, middleware: middleware)
          expect(output.to_h).to eq({
            header_true_bool: true,
            header_false_bool: false,
            header_boolean_list: [
              true,
              false,
              true
            ]
          })
        end
        # Tests responses with enum header bindings
        #
        it 'stubs RailsJsonInputAndOutputWithEnumHeaders' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:input_and_output_with_headers, {
            header_enum: "Foo",
            header_enum_list: [
              "Foo",
              "Bar",
              "Baz"
            ]
          })
          output = client.input_and_output_with_headers({}, middleware: middleware)
          expect(output.to_h).to eq({
            header_enum: "Foo",
            header_enum_list: [
              "Foo",
              "Bar",
              "Baz"
            ]
          })
        end
      end

    end

    describe '#json_enums' do

      describe 'requests' do
        # Serializes simple scalar properties
        #
        it 'RailsJsonEnums' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/jsonenums')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "foo_enum1": "Foo",
                "foo_enum2": "0",
                "foo_enum3": "1",
                "foo_enum_list": [
                    "Foo",
                    "0"
                ],
                "foo_enum_set": [
                    "Foo",
                    "0"
                ],
                "foo_enum_map": {
                    "hi": "Foo",
                    "zero": "0"
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_enums({
            foo_enum1: "Foo",
            foo_enum2: "0",
            foo_enum3: "1",
            foo_enum_list: [
              "Foo",
              "0"
            ],
            foo_enum_set: [
              "Foo",
              "0"
            ],
            foo_enum_map: {
              'hi' => "Foo",
              'zero' => "0"
            }
          }, **opts)
        end
      end

      describe 'responses' do
        # Serializes simple scalar properties
        #
        it 'RailsJsonEnums' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "foo_enum1": "Foo",
                "foo_enum2": "0",
                "foo_enum3": "1",
                "foo_enum_list": [
                    "Foo",
                    "0"
                ],
                "foo_enum_set": [
                    "Foo",
                    "0"
                ],
                "foo_enum_map": {
                    "hi": "Foo",
                    "zero": "0"
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_enums({}, middleware: middleware)
          expect(output.to_h).to eq({
            foo_enum1: "Foo",
            foo_enum2: "0",
            foo_enum3: "1",
            foo_enum_list: [
              "Foo",
              "0"
            ],
            foo_enum_set: [
              "Foo",
              "0"
            ],
            foo_enum_map: {
              'hi' => "Foo",
              'zero' => "0"
            }
          })
        end
      end

      describe 'response stubs' do
        # Serializes simple scalar properties
        #
        it 'stubs RailsJsonEnums' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_enums, {
            foo_enum1: "Foo",
            foo_enum2: "0",
            foo_enum3: "1",
            foo_enum_list: [
              "Foo",
              "0"
            ],
            foo_enum_set: [
              "Foo",
              "0"
            ],
            foo_enum_map: {
              'hi' => "Foo",
              'zero' => "0"
            }
          })
          output = client.json_enums({}, middleware: middleware)
          expect(output.to_h).to eq({
            foo_enum1: "Foo",
            foo_enum2: "0",
            foo_enum3: "1",
            foo_enum_list: [
              "Foo",
              "0"
            ],
            foo_enum_set: [
              "Foo",
              "0"
            ],
            foo_enum_map: {
              'hi' => "Foo",
              'zero' => "0"
            }
          })
        end
      end

    end

    describe '#json_maps' do

      describe 'requests' do
        # Serializes JSON maps
        #
        it 'RailsJsonJsonMaps' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/JsonMaps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "dense_struct_map": {
                    "foo": {
                        "hi": "there"
                    },
                    "baz": {
                        "hi": "bye"
                    }
                },
                "sparse_struct_map": {
                    "foo": {
                        "hi": "there"
                    },
                    "baz": {
                        "hi": "bye"
                    }
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_maps({
            dense_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            },
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
        # Serializes JSON map values in sparse maps
        #
        it 'RailsJsonSerializesNullMapValues' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/JsonMaps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "sparse_boolean_map": {
                    "x": null
                },
                "sparse_number_map": {
                    "x": null
                },
                "sparse_string_map": {
                    "x": null
                },
                "sparse_struct_map": {
                    "x": null
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_maps({
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
        # Ensure that 0 and false are sent over the wire in all maps and lists
        #
        it 'RailsJsonSerializesZeroValuesInMaps' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/JsonMaps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "dense_number_map": {
                    "x": 0
                },
                "sparse_number_map": {
                    "x": 0
                },
                "dense_boolean_map": {
                    "x": false
                },
                "sparse_boolean_map": {
                    "x": false
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_maps({
            dense_number_map: {
              'x' => 0
            },
            sparse_number_map: {
              'x' => 0
            },
            dense_boolean_map: {
              'x' => false
            },
            sparse_boolean_map: {
              'x' => false
            }
          }, **opts)
        end
        # A request that contains a sparse map of sets
        #
        it 'RailsJsonSerializesSparseSetMap' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/JsonMaps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "sparse_set_map": {
                    "x": [],
                    "y": ["a", "b"]
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_maps({
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
        # A request that contains a dense map of sets.
        #
        it 'RailsJsonSerializesDenseSetMap' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/JsonMaps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "dense_set_map": {
                    "x": [],
                    "y": ["a", "b"]
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_maps({
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
        # A request that contains a sparse map of sets.
        #
        it 'RailsJsonSerializesSparseSetMapAndRetainsNull' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/JsonMaps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "sparse_set_map": {
                    "x": [],
                    "y": ["a", "b"],
                    "z": null
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_maps({
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
      end

      describe 'responses' do
        # Deserializes JSON maps
        #
        it 'RailsJsonJsonMaps' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "dense_struct_map": {
                    "foo": {
                        "hi": "there"
                    },
                    "baz": {
                        "hi": "bye"
                    }
                },
                "sparse_struct_map": {
                    "foo": {
                        "hi": "there"
                    },
                    "baz": {
                        "hi": "bye"
                    }
               }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_maps({}, middleware: middleware)
          expect(output.to_h).to eq({
            dense_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            },
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
        # Deserializes null JSON map values
        #
        it 'RailsJsonDeserializesNullMapValues' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "sparse_boolean_map": {
                    "x": null
                },
                "sparse_number_map": {
                    "x": null
                },
                "sparse_string_map": {
                    "x": null
                },
                "sparse_struct_map": {
                    "x": null
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_maps({}, middleware: middleware)
          expect(output.to_h).to eq({
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
        # Ensure that 0 and false are sent over the wire in all maps and lists
        #
        it 'RailsJsonDeserializesZeroValuesInMaps' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "dense_number_map": {
                    "x": 0
                },
                "sparse_number_map": {
                    "x": 0
                },
                "dense_boolean_map": {
                    "x": false
                },
                "sparse_boolean_map": {
                    "x": false
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_maps({}, middleware: middleware)
          expect(output.to_h).to eq({
            dense_number_map: {
              'x' => 0
            },
            sparse_number_map: {
              'x' => 0
            },
            dense_boolean_map: {
              'x' => false
            },
            sparse_boolean_map: {
              'x' => false
            }
          })
        end
        # A response that contains a sparse map of sets
        #
        it 'RailsJsonDeserializesSparseSetMap' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "sparse_set_map": {
                    "x": [],
                    "y": ["a", "b"]
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_maps({}, middleware: middleware)
          expect(output.to_h).to eq({
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
        # A response that contains a dense map of sets.
        #
        it 'RailsJsonDeserializesDenseSetMap' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "dense_set_map": {
                    "x": [],
                    "y": ["a", "b"]
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_maps({}, middleware: middleware)
          expect(output.to_h).to eq({
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
        # A response that contains a sparse map of sets.
        #
        it 'RailsJsonDeserializesSparseSetMapAndRetainsNull' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "sparse_set_map": {
                    "x": [],
                    "y": ["a", "b"],
                    "z": null
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_maps({}, middleware: middleware)
          expect(output.to_h).to eq({
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
        # Clients SHOULD tolerate seeing a null value in a dense map, and they SHOULD
        # drop the null key-value pair.
        #
        it 'RailsJsonDeserializesDenseSetMapAndSkipsNull' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "dense_set_map": {
                    "x": [],
                    "y": ["a", "b"],
                    "z": null
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_maps({}, middleware: middleware)
          expect(output.to_h).to eq({
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

      describe 'response stubs' do
        # Deserializes JSON maps
        #
        it 'stubs RailsJsonJsonMaps' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_maps, {
            dense_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            },
            sparse_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            }
          })
          output = client.json_maps({}, middleware: middleware)
          expect(output.to_h).to eq({
            dense_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            },
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
        # Deserializes null JSON map values
        #
        it 'stubs RailsJsonDeserializesNullMapValues' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_maps, {
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
          output = client.json_maps({}, middleware: middleware)
          expect(output.to_h).to eq({
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
        # Ensure that 0 and false are sent over the wire in all maps and lists
        #
        it 'stubs RailsJsonDeserializesZeroValuesInMaps' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_maps, {
            dense_number_map: {
              'x' => 0
            },
            sparse_number_map: {
              'x' => 0
            },
            dense_boolean_map: {
              'x' => false
            },
            sparse_boolean_map: {
              'x' => false
            }
          })
          output = client.json_maps({}, middleware: middleware)
          expect(output.to_h).to eq({
            dense_number_map: {
              'x' => 0
            },
            sparse_number_map: {
              'x' => 0
            },
            dense_boolean_map: {
              'x' => false
            },
            sparse_boolean_map: {
              'x' => false
            }
          })
        end
        # A response that contains a sparse map of sets
        #
        it 'stubs RailsJsonDeserializesSparseSetMap' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_maps, {
            sparse_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
          output = client.json_maps({}, middleware: middleware)
          expect(output.to_h).to eq({
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
        # A response that contains a dense map of sets.
        #
        it 'stubs RailsJsonDeserializesDenseSetMap' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_maps, {
            dense_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
          output = client.json_maps({}, middleware: middleware)
          expect(output.to_h).to eq({
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
        # A response that contains a sparse map of sets.
        #
        it 'stubs RailsJsonDeserializesSparseSetMapAndRetainsNull' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_maps, {
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
          output = client.json_maps({}, middleware: middleware)
          expect(output.to_h).to eq({
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
        # Clients SHOULD tolerate seeing a null value in a dense map, and they SHOULD
        # drop the null key-value pair.
        #
        it 'stubs RailsJsonDeserializesDenseSetMapAndSkipsNull' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_maps, {
            dense_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
          output = client.json_maps({}, middleware: middleware)
          expect(output.to_h).to eq({
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

    describe '#json_unions' do

      describe 'requests' do
        # Serializes a string union value
        #
        it 'RailsJsonSerializeStringUnionValue' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/jsonunions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "string_value": "foo"
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_unions({
            contents: {
              string_value: "foo"
            }
          }, **opts)
        end
        # Serializes a boolean union value
        #
        it 'RailsJsonSerializeBooleanUnionValue' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/jsonunions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "boolean_value": true
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_unions({
            contents: {
              boolean_value: true
            }
          }, **opts)
        end
        # Serializes a number union value
        #
        it 'RailsJsonSerializeNumberUnionValue' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/jsonunions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "number_value": 1
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_unions({
            contents: {
              number_value: 1
            }
          }, **opts)
        end
        # Serializes a blob union value
        #
        it 'RailsJsonSerializeBlobUnionValue' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/jsonunions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "blob_value": "Zm9v"
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_unions({
            contents: {
              blob_value: 'foo'
            }
          }, **opts)
        end
        # Serializes a timestamp union value
        #
        it 'RailsJsonSerializeTimestampUnionValue' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/jsonunions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "timestamp_value": "2014-04-29T18:30:38Z"
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_unions({
            contents: {
              timestamp_value: Time.at(1398796238)
            }
          }, **opts)
        end
        # Serializes an enum union value
        #
        it 'RailsJsonSerializeEnumUnionValue' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/jsonunions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "enum_value": "Foo"
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_unions({
            contents: {
              enum_value: "Foo"
            }
          }, **opts)
        end
        # Serializes a list union value
        #
        it 'RailsJsonSerializeListUnionValue' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/jsonunions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "list_value": ["foo", "bar"]
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_unions({
            contents: {
              list_value: [
                "foo",
                "bar"
              ]
            }
          }, **opts)
        end
        # Serializes a map union value
        #
        it 'RailsJsonSerializeMapUnionValue' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/jsonunions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "map_value": {
                        "foo": "bar",
                        "spam": "eggs"
                    }
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_unions({
            contents: {
              map_value: {
                'foo' => "bar",
                'spam' => "eggs"
              }
            }
          }, **opts)
        end
        # Serializes a structure union value
        #
        it 'RailsJsonSerializeStructureUnionValue' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/jsonunions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "structure_value": {
                        "hi": "hello"
                    }
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.json_unions({
            contents: {
              structure_value: {
                hi: "hello"
              }
            }
          }, **opts)
        end
      end

      describe 'responses' do
        # Deserializes a string union value
        #
        it 'RailsJsonDeserializeStringUnionValue' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "contents": {
                    "string_value": "foo"
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              string_value: "foo"
            }
          })
        end
        # Deserializes a boolean union value
        #
        it 'RailsJsonDeserializeBooleanUnionValue' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "contents": {
                    "boolean_value": true
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              boolean_value: true
            }
          })
        end
        # Deserializes a number union value
        #
        it 'RailsJsonDeserializeNumberUnionValue' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "contents": {
                    "number_value": 1
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              number_value: 1
            }
          })
        end
        # Deserializes a blob union value
        #
        it 'RailsJsonDeserializeBlobUnionValue' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "contents": {
                    "blob_value": "Zm9v"
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              blob_value: 'foo'
            }
          })
        end
        # Deserializes a timestamp union value
        #
        it 'RailsJsonDeserializeTimestampUnionValue' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "contents": {
                    "timestamp_value": "2014-04-29T18:30:38Z"
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              timestamp_value: Time.at(1398796238)
            }
          })
        end
        # Deserializes an enum union value
        #
        it 'RailsJsonDeserializeEnumUnionValue' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "contents": {
                    "enum_value": "Foo"
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              enum_value: "Foo"
            }
          })
        end
        # Deserializes a list union value
        #
        it 'RailsJsonDeserializeListUnionValue' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "contents": {
                    "list_value": ["foo", "bar"]
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              list_value: [
                "foo",
                "bar"
              ]
            }
          })
        end
        # Deserializes a map union value
        #
        it 'RailsJsonDeserializeMapUnionValue' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "contents": {
                    "map_value": {
                        "foo": "bar",
                        "spam": "eggs"
                    }
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              map_value: {
                'foo' => "bar",
                'spam' => "eggs"
              }
            }
          })
        end
        # Deserializes a structure union value
        #
        it 'RailsJsonDeserializeStructureUnionValue' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "contents": {
                    "structure_value": {
                        "hi": "hello"
                    }
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              structure_value: {
                hi: "hello"
              }
            }
          })
        end
      end

      describe 'response stubs' do
        # Deserializes a string union value
        #
        it 'stubs RailsJsonDeserializeStringUnionValue' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_unions, {
            contents: {
              string_value: "foo"
            }
          })
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              string_value: "foo"
            }
          })
        end
        # Deserializes a boolean union value
        #
        it 'stubs RailsJsonDeserializeBooleanUnionValue' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_unions, {
            contents: {
              boolean_value: true
            }
          })
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              boolean_value: true
            }
          })
        end
        # Deserializes a number union value
        #
        it 'stubs RailsJsonDeserializeNumberUnionValue' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_unions, {
            contents: {
              number_value: 1
            }
          })
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              number_value: 1
            }
          })
        end
        # Deserializes a blob union value
        #
        it 'stubs RailsJsonDeserializeBlobUnionValue' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_unions, {
            contents: {
              blob_value: 'foo'
            }
          })
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              blob_value: 'foo'
            }
          })
        end
        # Deserializes a timestamp union value
        #
        it 'stubs RailsJsonDeserializeTimestampUnionValue' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_unions, {
            contents: {
              timestamp_value: Time.at(1398796238)
            }
          })
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              timestamp_value: Time.at(1398796238)
            }
          })
        end
        # Deserializes an enum union value
        #
        it 'stubs RailsJsonDeserializeEnumUnionValue' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_unions, {
            contents: {
              enum_value: "Foo"
            }
          })
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              enum_value: "Foo"
            }
          })
        end
        # Deserializes a list union value
        #
        it 'stubs RailsJsonDeserializeListUnionValue' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_unions, {
            contents: {
              list_value: [
                "foo",
                "bar"
              ]
            }
          })
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              list_value: [
                "foo",
                "bar"
              ]
            }
          })
        end
        # Deserializes a map union value
        #
        it 'stubs RailsJsonDeserializeMapUnionValue' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_unions, {
            contents: {
              map_value: {
                'foo' => "bar",
                'spam' => "eggs"
              }
            }
          })
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              map_value: {
                'foo' => "bar",
                'spam' => "eggs"
              }
            }
          })
        end
        # Deserializes a structure union value
        #
        it 'stubs RailsJsonDeserializeStructureUnionValue' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:json_unions, {
            contents: {
              structure_value: {
                hi: "hello"
              }
            }
          })
          output = client.json_unions({}, middleware: middleware)
          expect(output.to_h).to eq({
            contents: {
              structure_value: {
                hi: "hello"
              }
            }
          })
        end
      end

    end

    describe '#kitchen_sink_operation' do

      describe 'requests' do
        # Serializes string shapes
        #
        it 'rails_json_rails_json_serializes_string_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"string":"abc xyz"}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            string: "abc xyz"
          }, **opts)
        end
        # Serializes string shapes with jsonvalue trait
        #
        it 'rails_json_serializes_string_shapes_with_jsonvalue_trait' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"json_value":"{\"string\":\"value\",\"number\":1234.5,\"boolTrue\":true,\"boolFalse\":false,\"array\":[1,2,3,4],\"object\":{\"key\":\"value\"},\"null\":null}"}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            json_value: "{\"string\":\"value\",\"number\":1234.5,\"boolTrue\":true,\"boolFalse\":false,\"array\":[1,2,3,4],\"object\":{\"key\":\"value\"},\"null\":null}"
          }, **opts)
        end
        # Serializes integer shapes
        #
        it 'rails_json_serializes_integer_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"integer":1234}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            integer: 1234
          }, **opts)
        end
        # Serializes long shapes
        #
        it 'rails_json_serializes_long_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"long":999999999999}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            long: 999999999999
          }, **opts)
        end
        # Serializes float shapes
        #
        it 'rails_json_serializes_float_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"float":1234.5}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            float: 1234.5
          }, **opts)
        end
        # Serializes double shapes
        #
        it 'rails_json_serializes_double_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"double":1234.5}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            double: 1234.5
          }, **opts)
        end
        # Serializes blob shapes
        #
        it 'rails_json_serializes_blob_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"blob":"YmluYXJ5LXZhbHVl"}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            blob: 'binary-value'
          }, **opts)
        end
        # Serializes boolean shapes (true)
        #
        it 'rails_json_serializes_boolean_shapes_true' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"boolean":true}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            boolean: true
          }, **opts)
        end
        # Serializes boolean shapes (false)
        #
        it 'rails_json_serializes_boolean_shapes_false' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"boolean":false}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            boolean: false
          }, **opts)
        end
        # Serializes timestamp shapes
        #
        it 'rails_json_serializes_timestamp_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"timestamp":"2000-01-02T20:34:56Z"}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            timestamp: Time.at(946845296)
          }, **opts)
        end
        # Serializes timestamp shapes with iso8601 timestampFormat
        #
        it 'rails_json_serializes_timestamp_shapes_with_iso8601_timestampformat' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"iso8601_timestamp":"2000-01-02T20:34:56Z"}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            iso8601_timestamp: Time.at(946845296)
          }, **opts)
        end
        # Serializes timestamp shapes with httpdate timestampFormat
        #
        it 'rails_json_serializes_timestamp_shapes_with_httpdate_timestampformat' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"httpdate_timestamp":"Sun, 02 Jan 2000 20:34:56 GMT"}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            httpdate_timestamp: Time.at(946845296)
          }, **opts)
        end
        # Serializes timestamp shapes with unixTimestamp timestampFormat
        #
        it 'rails_json_serializes_timestamp_shapes_with_unixtimestamp_timestampformat' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"unix_timestamp":946845296}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            unix_timestamp: Time.at(946845296)
          }, **opts)
        end
        # Serializes list shapes
        #
        it 'rails_json_serializes_list_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"list_of_strings":["abc","mno","xyz"]}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            list_of_strings: [
              "abc",
              "mno",
              "xyz"
            ]
          }, **opts)
        end
        # Serializes empty list shapes
        #
        it 'rails_json_serializes_empty_list_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"list_of_strings":[]}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            list_of_strings: [

            ]
          }, **opts)
        end
        # Serializes list of map shapes
        #
        it 'rails_json_serializes_list_of_map_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"list_of_maps_of_strings":[{"foo":"bar"},{"abc":"xyz"},{"red":"blue"}]}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            list_of_maps_of_strings: [
              {
                'foo' => "bar"
              },
              {
                'abc' => "xyz"
              },
              {
                'red' => "blue"
              }
            ]
          }, **opts)
        end
        # Serializes list of structure shapes
        #
        it 'rails_json_serializes_list_of_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"list_of_structs":[{"value":"abc"},{"value":"mno"},{"value":"xyz"}]}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            list_of_structs: [
              {
                value: "abc"
              },
              {
                value: "mno"
              },
              {
                value: "xyz"
              }
            ]
          }, **opts)
        end
        # Serializes list of recursive structure shapes
        #
        it 'rails_json_serializes_list_of_recursive_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"recursive_list":[{"recursive_list":[{"recursive_list":[{"integer":123}]}]}]}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            recursive_list: [
              {
                recursive_list: [
                  {
                    recursive_list: [
                      {
                        integer: 123
                      }
                    ]
                  }
                ]
              }
            ]
          }, **opts)
        end
        # Serializes map shapes
        #
        it 'rails_json_serializes_map_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"map_of_strings":{"abc":"xyz","mno":"hjk"}}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            map_of_strings: {
              'abc' => "xyz",
              'mno' => "hjk"
            }
          }, **opts)
        end
        # Serializes empty map shapes
        #
        it 'rails_json_serializes_empty_map_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"map_of_strings":{}}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            map_of_strings: {

            }
          }, **opts)
        end
        # Serializes map of list shapes
        #
        it 'rails_json_serializes_map_of_list_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"map_of_lists_of_strings":{"abc":["abc","xyz"],"mno":["xyz","abc"]}}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            map_of_lists_of_strings: {
              'abc' => [
                "abc",
                "xyz"
              ],
              'mno' => [
                "xyz",
                "abc"
              ]
            }
          }, **opts)
        end
        # Serializes map of structure shapes
        #
        it 'rails_json_serializes_map_of_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"map_of_structs":{"key1":{"value":"value-1"},"key2":{"value":"value-2"}}}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            map_of_structs: {
              'key1' => {
                value: "value-1"
              },
              'key2' => {
                value: "value-2"
              }
            }
          }, **opts)
        end
        # Serializes map of recursive structure shapes
        #
        it 'rails_json_serializes_map_of_recursive_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"recursive_map":{"key1":{"recursive_map":{"key2":{"recursive_map":{"key3":{"boolean":false}}}}}}}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            recursive_map: {
              'key1' => {
                recursive_map: {
                  'key2' => {
                    recursive_map: {
                      'key3' => {
                        boolean: false
                      }
                    }
                  }
                }
              }
            }
          }, **opts)
        end
        # Serializes structure shapes
        #
        it 'rails_json_serializes_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"simple_struct":{"value":"abc"}}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            simple_struct: {
              value: "abc"
            }
          }, **opts)
        end
        # Serializes structure members with locationName traits
        #
        it 'rails_json_serializes_structure_members_with_locationname_traits' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"struct_with_location_name":{"RenamedMember":"some-value"}}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            struct_with_location_name: {
              value: "some-value"
            }
          }, **opts)
        end
        # Serializes empty structure shapes
        #
        it 'rails_json_serializes_empty_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"simple_struct":{}}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            simple_struct: {

            }
          }, **opts)
        end
        # Serializes structure which have no members
        #
        it 'rails_json_serializes_structure_which_have_no_members' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"empty_struct":{}}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            empty_struct: {

            }
          }, **opts)
        end
        # Serializes recursive structure shapes
        #
        it 'rails_json_serializes_recursive_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"string":"top-value","boolean":false,"recursive_struct":{"string":"nested-value","boolean":true,"recursive_list":[{"string":"string-only"},{"recursive_struct":{"map_of_strings":{"color":"red","size":"large"}}}]}}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.kitchen_sink_operation({
            string: "top-value",
            boolean: false,
            recursive_struct: {
              string: "nested-value",
              boolean: true,
              recursive_list: [
                {
                  string: "string-only"
                },
                {
                  recursive_struct: {
                    map_of_strings: {
                      'color' => "red",
                      'size' => "large"
                    }
                  }
                }
              ]
            }
          }, **opts)
        end
      end

      describe 'responses' do
        # Parses operations with empty JSON bodies
        #
        it 'rails_json_parses_operations_with_empty_json_bodies' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
        # Parses string shapes
        #
        it 'rails_json_parses_string_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"string":"string-value"}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            string: "string-value"
          })
        end
        # Parses integer shapes
        #
        it 'rails_json_parses_integer_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"integer":1234}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            integer: 1234
          })
        end
        # Parses long shapes
        #
        it 'rails_json_parses_long_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"long":1234567890123456789}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            long: 1234567890123456789
          })
        end
        # Parses float shapes
        #
        it 'rails_json_parses_float_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"float":1234.5}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            float: 1234.5
          })
        end
        # Parses double shapes
        #
        it 'rails_json_parses_double_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"double":123456789.12345679}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            double: 1.2345678912345679E8
          })
        end
        # Parses boolean shapes (true)
        #
        it 'rails_json_parses_boolean_shapes_true' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"boolean":true}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            boolean: true
          })
        end
        # Parses boolean (false)
        #
        it 'rails_json_parses_boolean_false' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"boolean":false}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            boolean: false
          })
        end
        # Parses blob shapes
        #
        it 'rails_json_parses_blob_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"blob":"YmluYXJ5LXZhbHVl"}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            blob: 'binary-value'
          })
        end
        # Parses timestamp shapes
        #
        it 'rails_json_parses_timestamp_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"timestamp":"2000-01-02T20:34:56Z"}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            timestamp: Time.at(946845296)
          })
        end
        # Parses iso8601 timestamps
        #
        it 'rails_json_parses_iso8601_timestamps' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"iso8601_timestamp":"2000-01-02T20:34:56Z"}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            iso8601_timestamp: Time.at(946845296)
          })
        end
        # Parses httpdate timestamps
        #
        it 'rails_json_parses_httpdate_timestamps' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"httpdate_timestamp":"Sun, 02 Jan 2000 20:34:56.000 GMT"}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            httpdate_timestamp: Time.at(946845296)
          })
        end
        # Parses list shapes
        #
        it 'rails_json_parses_list_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"list_of_strings":["abc","mno","xyz"]}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            list_of_strings: [
              "abc",
              "mno",
              "xyz"
            ]
          })
        end
        # Parses list of map shapes
        #
        it 'rails_json_parses_list_of_map_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"list_of_maps_of_strings":[{"size":"large"},{"color":"red"}]}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            list_of_maps_of_strings: [
              {
                'size' => "large"
              },
              {
                'color' => "red"
              }
            ]
          })
        end
        # Parses list of list shapes
        #
        it 'rails_json_parses_list_of_list_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"list_of_lists":[["abc","mno","xyz"],["hjk","qrs","tuv"]]}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            list_of_lists: [
              [
                "abc",
                "mno",
                "xyz"
              ],
              [
                "hjk",
                "qrs",
                "tuv"
              ]
            ]
          })
        end
        # Parses list of structure shapes
        #
        it 'rails_json_parses_list_of_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"list_of_structs":[{"value":"value-1"},{"value":"value-2"}]}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            list_of_structs: [
              {
                value: "value-1"
              },
              {
                value: "value-2"
              }
            ]
          })
        end
        # Parses list of recursive structure shapes
        #
        it 'rails_json_parses_list_of_recursive_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"recursive_list":[{"recursive_list":[{"recursive_list":[{"string":"value"}]}]}]}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            recursive_list: [
              {
                recursive_list: [
                  {
                    recursive_list: [
                      {
                        string: "value"
                      }
                    ]
                  }
                ]
              }
            ]
          })
        end
        # Parses map shapes
        #
        it 'rails_json_parses_map_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"map_of_strings":{"size":"large","color":"red"}}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            map_of_strings: {
              'size' => "large",
              'color' => "red"
            }
          })
        end
        # Parses map of list shapes
        #
        it 'rails_json_parses_map_of_list_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"map_of_lists_of_strings":{"sizes":["large","small"],"colors":["red","green"]}}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            map_of_lists_of_strings: {
              'sizes' => [
                "large",
                "small"
              ],
              'colors' => [
                "red",
                "green"
              ]
            }
          })
        end
        # Parses map of map shapes
        #
        it 'rails_json_parses_map_of_map_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"map_of_maps":{"sizes":{"large":"L","medium":"M"},"colors":{"red":"R","blue":"B"}}}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            map_of_maps: {
              'sizes' => {
                'large' => "L",
                'medium' => "M"
              },
              'colors' => {
                'red' => "R",
                'blue' => "B"
              }
            }
          })
        end
        # Parses map of structure shapes
        #
        it 'rails_json_parses_map_of_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"map_of_structs":{"size":{"value":"small"},"color":{"value":"red"}}}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            map_of_structs: {
              'size' => {
                value: "small"
              },
              'color' => {
                value: "red"
              }
            }
          })
        end
        # Parses map of recursive structure shapes
        #
        it 'rails_json_parses_map_of_recursive_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{"recursive_map":{"key-1":{"recursive_map":{"key-2":{"recursive_map":{"key-3":{"string":"value"}}}}}}}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            recursive_map: {
              'key-1' => {
                recursive_map: {
                  'key-2' => {
                    recursive_map: {
                      'key-3' => {
                        string: "value"
                      }
                    }
                  }
                }
              }
            }
          })
        end
        # Parses the request id from the response
        #
        it 'rails_json_parses_the_request_id_from_the_response' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json', 'X-Amzn-Requestid' => 'amazon-uniq-request-id' })
            response.body = StringIO.new('{}')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
      end

      describe 'response stubs' do
        # Parses operations with empty JSON bodies
        #
        it 'stubs rails_json_parses_operations_with_empty_json_bodies' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {

          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
        # Parses string shapes
        #
        it 'stubs rails_json_parses_string_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            string: "string-value"
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            string: "string-value"
          })
        end
        # Parses integer shapes
        #
        it 'stubs rails_json_parses_integer_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            integer: 1234
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            integer: 1234
          })
        end
        # Parses long shapes
        #
        it 'stubs rails_json_parses_long_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            long: 1234567890123456789
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            long: 1234567890123456789
          })
        end
        # Parses float shapes
        #
        it 'stubs rails_json_parses_float_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            float: 1234.5
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            float: 1234.5
          })
        end
        # Parses double shapes
        #
        it 'stubs rails_json_parses_double_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            double: 1.2345678912345679E8
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            double: 1.2345678912345679E8
          })
        end
        # Parses boolean shapes (true)
        #
        it 'stubs rails_json_parses_boolean_shapes_true' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            boolean: true
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            boolean: true
          })
        end
        # Parses boolean (false)
        #
        it 'stubs rails_json_parses_boolean_false' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            boolean: false
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            boolean: false
          })
        end
        # Parses blob shapes
        #
        it 'stubs rails_json_parses_blob_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            blob: 'binary-value'
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            blob: 'binary-value'
          })
        end
        # Parses timestamp shapes
        #
        it 'stubs rails_json_parses_timestamp_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            timestamp: Time.at(946845296)
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            timestamp: Time.at(946845296)
          })
        end
        # Parses iso8601 timestamps
        #
        it 'stubs rails_json_parses_iso8601_timestamps' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            iso8601_timestamp: Time.at(946845296)
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            iso8601_timestamp: Time.at(946845296)
          })
        end
        # Parses httpdate timestamps
        #
        it 'stubs rails_json_parses_httpdate_timestamps' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            httpdate_timestamp: Time.at(946845296)
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            httpdate_timestamp: Time.at(946845296)
          })
        end
        # Parses list shapes
        #
        it 'stubs rails_json_parses_list_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            list_of_strings: [
              "abc",
              "mno",
              "xyz"
            ]
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            list_of_strings: [
              "abc",
              "mno",
              "xyz"
            ]
          })
        end
        # Parses list of map shapes
        #
        it 'stubs rails_json_parses_list_of_map_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            list_of_maps_of_strings: [
              {
                'size' => "large"
              },
              {
                'color' => "red"
              }
            ]
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            list_of_maps_of_strings: [
              {
                'size' => "large"
              },
              {
                'color' => "red"
              }
            ]
          })
        end
        # Parses list of list shapes
        #
        it 'stubs rails_json_parses_list_of_list_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            list_of_lists: [
              [
                "abc",
                "mno",
                "xyz"
              ],
              [
                "hjk",
                "qrs",
                "tuv"
              ]
            ]
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            list_of_lists: [
              [
                "abc",
                "mno",
                "xyz"
              ],
              [
                "hjk",
                "qrs",
                "tuv"
              ]
            ]
          })
        end
        # Parses list of structure shapes
        #
        it 'stubs rails_json_parses_list_of_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            list_of_structs: [
              {
                value: "value-1"
              },
              {
                value: "value-2"
              }
            ]
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            list_of_structs: [
              {
                value: "value-1"
              },
              {
                value: "value-2"
              }
            ]
          })
        end
        # Parses list of recursive structure shapes
        #
        it 'stubs rails_json_parses_list_of_recursive_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            recursive_list: [
              {
                recursive_list: [
                  {
                    recursive_list: [
                      {
                        string: "value"
                      }
                    ]
                  }
                ]
              }
            ]
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            recursive_list: [
              {
                recursive_list: [
                  {
                    recursive_list: [
                      {
                        string: "value"
                      }
                    ]
                  }
                ]
              }
            ]
          })
        end
        # Parses map shapes
        #
        it 'stubs rails_json_parses_map_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            map_of_strings: {
              'size' => "large",
              'color' => "red"
            }
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            map_of_strings: {
              'size' => "large",
              'color' => "red"
            }
          })
        end
        # Parses map of list shapes
        #
        it 'stubs rails_json_parses_map_of_list_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            map_of_lists_of_strings: {
              'sizes' => [
                "large",
                "small"
              ],
              'colors' => [
                "red",
                "green"
              ]
            }
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            map_of_lists_of_strings: {
              'sizes' => [
                "large",
                "small"
              ],
              'colors' => [
                "red",
                "green"
              ]
            }
          })
        end
        # Parses map of map shapes
        #
        it 'stubs rails_json_parses_map_of_map_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            map_of_maps: {
              'sizes' => {
                'large' => "L",
                'medium' => "M"
              },
              'colors' => {
                'red' => "R",
                'blue' => "B"
              }
            }
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            map_of_maps: {
              'sizes' => {
                'large' => "L",
                'medium' => "M"
              },
              'colors' => {
                'red' => "R",
                'blue' => "B"
              }
            }
          })
        end
        # Parses map of structure shapes
        #
        it 'stubs rails_json_parses_map_of_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            map_of_structs: {
              'size' => {
                value: "small"
              },
              'color' => {
                value: "red"
              }
            }
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            map_of_structs: {
              'size' => {
                value: "small"
              },
              'color' => {
                value: "red"
              }
            }
          })
        end
        # Parses map of recursive structure shapes
        #
        it 'stubs rails_json_parses_map_of_recursive_structure_shapes' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {
            recursive_map: {
              'key-1' => {
                recursive_map: {
                  'key-2' => {
                    recursive_map: {
                      'key-3' => {
                        string: "value"
                      }
                    }
                  }
                }
              }
            }
          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            recursive_map: {
              'key-1' => {
                recursive_map: {
                  'key-2' => {
                    recursive_map: {
                      'key-3' => {
                        string: "value"
                      }
                    }
                  }
                }
              }
            }
          })
        end
        # Parses the request id from the response
        #
        it 'stubs rails_json_parses_the_request_id_from_the_response' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:kitchen_sink_operation, {

          })
          output = client.kitchen_sink_operation({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
      end

    end

    describe '#media_type_header' do

      describe 'requests' do
        # Headers that target strings with a mediaType are base64 encoded
        #
        it 'RailsJsonMediaTypeHeaderInputBase64' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/MediaTypeHeader')
            { 'X-Json' => 'dHJ1ZQ==' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.media_type_header({
            json: "true"
          }, **opts)
        end
      end

      describe 'responses' do
        # Headers that target strings with a mediaType are base64 encoded
        #
        it 'RailsJsonMediaTypeHeaderOutputBase64' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'X-Json' => 'dHJ1ZQ==' })
            response.body = StringIO.new('')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.media_type_header({}, middleware: middleware)
          expect(output.to_h).to eq({
            json: "true"
          })
        end
      end

      describe 'response stubs' do
        # Headers that target strings with a mediaType are base64 encoded
        #
        it 'stubs RailsJsonMediaTypeHeaderOutputBase64' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:media_type_header, {
            json: "true"
          })
          output = client.media_type_header({}, middleware: middleware)
          expect(output.to_h).to eq({
            json: "true"
          })
        end
      end

    end

    describe '#nested_attributes_operation' do

      describe 'requests' do
        # Serializes members with nestedAttributes
        #
        it 'rails_json_nested_attributes' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/nestedattributes')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"simple_struct_attributes":{"value":"simple struct value"}}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.nested_attributes_operation({
            simple_struct: {
              value: "simple struct value"
            }
          }, **opts)
        end
      end

    end

    describe '#null_and_empty_headers_client' do

      describe 'requests' do
        # Do not send null values, empty strings, or empty lists over the wire in headers
        #
        it 'RailsJsonNullAndEmptyHeaders' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/NullAndEmptyHeadersClient')
            ['X-A', 'X-B', 'X-C'].each { |k| expect(request.headers.key?(k)).to be(false) }
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.null_and_empty_headers_client({
            a: nil,
            b: "",
            c: [

            ]
          }, **opts)
        end
      end

    end

    describe '#null_operation' do

      describe 'requests' do
        # Null structure values are dropped
        #
        it 'RailsJsonStructuresDontSerializeNullValues' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/nulloperation')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.null_operation({
            string: nil
          }, **opts)
        end
        # Serializes null values in maps
        #
        it 'RailsJsonMapsSerializeNullValues' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/nulloperation')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "sparse_string_map": {
                    "foo": null
                }
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.null_operation({
            sparse_string_map: {
              'foo' => nil
            }
          }, **opts)
        end
        # Serializes null values in lists
        #
        it 'RailsJsonListsSerializeNull' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/nulloperation')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "sparse_string_list": [
                    null
                ]
            }'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.null_operation({
            sparse_string_list: [
              nil
            ]
          }, **opts)
        end
      end

      describe 'responses' do
        # Null structure values are dropped
        #
        it 'RailsJsonStructuresDontDeserializeNullValues' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "string": null
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.null_operation({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
        # Deserializes null values in maps
        #
        it 'RailsJsonMapsDeserializeNullValues' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "sparse_string_map": {
                    "foo": null
                }
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.null_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            sparse_string_map: {
              'foo' => nil
            }
          })
        end
        # Deserializes null values in lists
        #
        it 'RailsJsonListsDeserializeNull' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'Content-Type' => 'application/json' })
            response.body = StringIO.new('{
                "sparse_string_list": [
                    null
                ]
            }')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.null_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            sparse_string_list: [
              nil
            ]
          })
        end
      end

      describe 'response stubs' do
        # Null structure values are dropped
        #
        it 'stubs RailsJsonStructuresDontDeserializeNullValues' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:null_operation, {

          })
          output = client.null_operation({}, middleware: middleware)
          expect(output.to_h).to eq({

          })
        end
        # Deserializes null values in maps
        #
        it 'stubs RailsJsonMapsDeserializeNullValues' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:null_operation, {
            sparse_string_map: {
              'foo' => nil
            }
          })
          output = client.null_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            sparse_string_map: {
              'foo' => nil
            }
          })
        end
        # Deserializes null values in lists
        #
        it 'stubs RailsJsonListsDeserializeNull' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:null_operation, {
            sparse_string_list: [
              nil
            ]
          })
          output = client.null_operation({}, middleware: middleware)
          expect(output.to_h).to eq({
            sparse_string_list: [
              nil
            ]
          })
        end
      end

    end

    describe '#omits_null_serializes_empty_string' do

      describe 'requests' do
        # Omits null query values
        #
        it 'RailsJsonOmitsNullQuery' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/OmitsNullSerializesEmptyString')
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.omits_null_serializes_empty_string({
            null_value: nil
          }, **opts)
        end
        # Serializes empty query strings
        #
        it 'RailsJsonSerializesEmptyQueryValue' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('GET')
            expect(request_uri.path).to eq('/OmitsNullSerializesEmptyString')
            expected_query = CGI.parse(['Empty='].join('&'))
            actual_query = CGI.parse(request_uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.omits_null_serializes_empty_string({
            empty_string: ""
          }, **opts)
        end
      end

    end

    describe '#operation_with_optional_input_output' do

      describe 'requests' do
        # Can call operations with no input or output
        #
        it 'rails_json_can_call_operation_with_no_input_or_output' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/operationwithoptionalinputoutput')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.operation_with_optional_input_output({

          }, **opts)
        end
        # Can invoke operations with optional input
        #
        it 'rails_json_can_call_operation_with_optional_input' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/operationwithoptionalinputoutput')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"value":"Hi"}'))
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.operation_with_optional_input_output({
            value: "Hi"
          }, **opts)
        end
      end

    end

    describe '#query_idempotency_token_auto_fill' do

      describe 'requests' do
        # Automatically adds idempotency token when not set
        #
        it 'RailsJsonQueryIdempotencyTokenAutoFill' do
          allow(SecureRandom).to receive(:uuid).and_return('00000000-0000-4000-8000-000000000000')
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/QueryIdempotencyTokenAutoFill')
            expected_query = CGI.parse(['token=00000000-0000-4000-8000-000000000000'].join('&'))
            actual_query = CGI.parse(request_uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.query_idempotency_token_auto_fill({

          }, **opts)
        end
        # Uses the given idempotency token as-is
        #
        it 'RailsJsonQueryIdempotencyTokenAutoFillIsSet' do
          allow(SecureRandom).to receive(:uuid).and_return('00000000-0000-4000-8000-000000000000')
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/QueryIdempotencyTokenAutoFill')
            expected_query = CGI.parse(['token=00000000-0000-4000-8000-000000000000'].join('&'))
            actual_query = CGI.parse(request_uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.query_idempotency_token_auto_fill({
            token: "00000000-0000-4000-8000-000000000000"
          }, **opts)
        end
      end

    end

    describe '#query_params_as_string_list_map' do

      describe 'requests' do
        # Serialize query params from map of list strings
        #
        it 'RailsJsonQueryParamsStringListMap' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/StringListMap')
            expected_query = CGI.parse(['corge=named', 'baz=bar', 'baz=qux'].join('&'))
            actual_query = CGI.parse(request_uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.query_params_as_string_list_map({
            qux: "named",
            foo: {
              'baz' => [
                "bar",
                "qux"
              ]
            }
          }, **opts)
        end
      end

    end

    describe '#timestamp_format_headers' do

      describe 'requests' do
        # Tests how timestamp request headers are serialized
        #
        it 'RailsJsonTimestampFormatHeaders' do
          middleware = Hearth::MiddlewareBuilder.before_send do |input, context|
            request = context.request
            request_uri = URI.parse(request.url)
            expect(request.http_method).to eq('POST')
            expect(request_uri.path).to eq('/TimestampFormatHeaders')
            { 'X-defaultFormat' => 'Mon, 16 Dec 2019 23:48:18 GMT', 'X-memberDateTime' => '2019-12-16T23:48:18Z', 'X-memberEpochSeconds' => '1576540098', 'X-memberHttpDate' => 'Mon, 16 Dec 2019 23:48:18 GMT', 'X-targetDateTime' => '2019-12-16T23:48:18Z', 'X-targetEpochSeconds' => '1576540098', 'X-targetHttpDate' => 'Mon, 16 Dec 2019 23:48:18 GMT' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
            Hearth::Output.new
          end
          opts = {middleware: middleware}
          client.timestamp_format_headers({
            member_epoch_seconds: Time.at(1576540098),
            member_http_date: Time.at(1576540098),
            member_date_time: Time.at(1576540098),
            default_format: Time.at(1576540098),
            target_epoch_seconds: Time.at(1576540098),
            target_http_date: Time.at(1576540098),
            target_date_time: Time.at(1576540098)
          }, **opts)
        end
      end

      describe 'responses' do
        # Tests how timestamp response headers are serialized
        #
        it 'RailsJsonTimestampFormatHeaders' do
          middleware = Hearth::MiddlewareBuilder.around_send do |app, input, context|
            response = context.response
            response.status = 200
            response.headers = Hearth::HTTP::Headers.new(headers: { 'X-defaultFormat' => 'Mon, 16 Dec 2019 23:48:18 GMT', 'X-memberDateTime' => '2019-12-16T23:48:18Z', 'X-memberEpochSeconds' => '1576540098', 'X-memberHttpDate' => 'Mon, 16 Dec 2019 23:48:18 GMT', 'X-targetDateTime' => '2019-12-16T23:48:18Z', 'X-targetEpochSeconds' => '1576540098', 'X-targetHttpDate' => 'Mon, 16 Dec 2019 23:48:18 GMT' })
            response.body = StringIO.new('')
            Hearth::Output.new
          end
          middleware.remove_send.remove_build
          output = client.timestamp_format_headers({}, middleware: middleware)
          expect(output.to_h).to eq({
            member_epoch_seconds: Time.at(1576540098),
            member_http_date: Time.at(1576540098),
            member_date_time: Time.at(1576540098),
            default_format: Time.at(1576540098),
            target_epoch_seconds: Time.at(1576540098),
            target_http_date: Time.at(1576540098),
            target_date_time: Time.at(1576540098)
          })
        end
      end

      describe 'response stubs' do
        # Tests how timestamp response headers are serialized
        #
        it 'stubs RailsJsonTimestampFormatHeaders' do
          middleware = Hearth::MiddlewareBuilder.after_send do |input, context|
            response = context.response
            expect(response.status).to eq(200)
          end
          middleware.remove_build
          client.stub_responses(:timestamp_format_headers, {
            member_epoch_seconds: Time.at(1576540098),
            member_http_date: Time.at(1576540098),
            member_date_time: Time.at(1576540098),
            default_format: Time.at(1576540098),
            target_epoch_seconds: Time.at(1576540098),
            target_http_date: Time.at(1576540098),
            target_date_time: Time.at(1576540098)
          })
          output = client.timestamp_format_headers({}, middleware: middleware)
          expect(output.to_h).to eq({
            member_epoch_seconds: Time.at(1576540098),
            member_http_date: Time.at(1576540098),
            member_date_time: Time.at(1576540098),
            default_format: Time.at(1576540098),
            target_epoch_seconds: Time.at(1576540098),
            target_http_date: Time.at(1576540098),
            target_date_time: Time.at(1576540098)
          })
        end
      end

    end

  end
end
