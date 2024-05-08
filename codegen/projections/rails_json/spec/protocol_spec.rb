# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'cgi'

require_relative 'spec_helper'

module RailsJson
  describe Client do
    let(:client) do
      Client.new(
        stub_responses: true,
        validate_input: false,
        endpoint: 'http://127.0.0.1',
        retry_strategy: Hearth::Retry::Standard.new(max_attempts: 0)
      )
    end

    describe '#all_query_string_types' do

      describe 'requests' do

        # Serializes query string parameters with all supported types
        it 'RailsJsonAllQueryStringTypes' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/AllQueryStringTypesInput')
            expected_query = ::CGI.parse(['String=Hello%20there', 'StringList=a', 'StringList=b', 'StringList=c', 'StringSet=a', 'StringSet=b', 'StringSet=c', 'Byte=1', 'Short=2', 'Integer=3', 'IntegerList=1', 'IntegerList=2', 'IntegerList=3', 'IntegerSet=1', 'IntegerSet=2', 'IntegerSet=3', 'Long=4', 'Float=1.1', 'Double=1.1', 'DoubleList=1.1', 'DoubleList=2.1', 'DoubleList=3.1', 'Boolean=true', 'BooleanList=true', 'BooleanList=false', 'BooleanList=true', 'Timestamp=1970-01-01T00%3A00%3A01Z', 'TimestampList=1970-01-01T00%3A00%3A01Z', 'TimestampList=1970-01-01T00%3A00%3A02Z', 'TimestampList=1970-01-01T00%3A00%3A03Z', 'Enum=Foo', 'EnumList=Foo', 'EnumList=Baz', 'EnumList=Bar', 'IntegerEnum=1', 'IntegerEnumList=1', 'IntegerEnumList=2', 'IntegerEnumList=3'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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
            query_integer_enum: 1,
            query_integer_enum_list: [
              1,
              2,
              3
            ],
            query_params_map_of_string_list: {
              'String' => [
                "Hello there"
              ],
              'StringList' => [
                "a",
                "b",
                "c"
              ],
              'StringSet' => [
                "a",
                "b",
                "c"
              ],
              'Byte' => [
                "1"
              ],
              'Short' => [
                "2"
              ],
              'Integer' => [
                "3"
              ],
              'IntegerList' => [
                "1",
                "2",
                "3"
              ],
              'IntegerSet' => [
                "1",
                "2",
                "3"
              ],
              'Long' => [
                "4"
              ],
              'Float' => [
                "1.1"
              ],
              'Double' => [
                "1.1"
              ],
              'DoubleList' => [
                "1.1",
                "2.1",
                "3.1"
              ],
              'Boolean' => [
                "true"
              ],
              'BooleanList' => [
                "true",
                "false",
                "true"
              ],
              'Timestamp' => [
                "1970-01-01T00:00:01Z"
              ],
              'TimestampList' => [
                "1970-01-01T00:00:01Z",
                "1970-01-01T00:00:02Z",
                "1970-01-01T00:00:03Z"
              ],
              'Enum' => [
                "Foo"
              ],
              'EnumList' => [
                "Foo",
                "Baz",
                "Bar"
              ],
              'IntegerEnum' => [
                "1"
              ],
              'IntegerEnumList' => [
                "1",
                "2",
                "3"
              ]
            }
          }, **opts)
        end

        # Handles query string maps
        it 'RailsJsonQueryStringMap' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/AllQueryStringTypesInput')
            expected_query = ::CGI.parse(['QueryParamsStringKeyA=Foo', 'QueryParamsStringKeyB=Bar'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.all_query_string_types({
            query_params_map_of_string_list: {
              'QueryParamsStringKeyA' => [
                "Foo"
              ],
              'QueryParamsStringKeyB' => [
                "Bar"
              ]
            }
          }, **opts)
        end

        # Handles escaping all required characters in the query string.
        it 'RailsJsonQueryStringEscaping' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/AllQueryStringTypesInput')
            expected_query = ::CGI.parse(['String=%20%25%3A%2F%3F%23%5B%5D%40%21%24%26%27%28%29%2A%2B%2C%3B%3D%F0%9F%98%B9'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.all_query_string_types({
            query_string: " %:/?#[]@!$&'()*+,;=😹",
            query_params_map_of_string_list: {
              'String' => [
                " %:/?#[]@!$&'()*+,;=😹"
              ]
            }
          }, **opts)
        end

        # Supports handling NaN float query values.
        it 'RailsJsonSupportsNaNFloatQueryValues' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/AllQueryStringTypesInput')
            expected_query = ::CGI.parse(['Float=NaN', 'Double=NaN'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.all_query_string_types({
            query_float: Float::NAN,
            query_double: Float::NAN,
            query_params_map_of_string_list: {
              'Float' => [
                "NaN"
              ],
              'Double' => [
                "NaN"
              ]
            }
          }, **opts)
        end

        # Supports handling Infinity float query values.
        it 'RailsJsonSupportsInfinityFloatQueryValues' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/AllQueryStringTypesInput')
            expected_query = ::CGI.parse(['Float=Infinity', 'Double=Infinity'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.all_query_string_types({
            query_float: Float::INFINITY,
            query_double: Float::INFINITY,
            query_params_map_of_string_list: {
              'Float' => [
                "Infinity"
              ],
              'Double' => [
                "Infinity"
              ]
            }
          }, **opts)
        end

        # Supports handling -Infinity float query values.
        it 'RailsJsonSupportsNegativeInfinityFloatQueryValues' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/AllQueryStringTypesInput')
            expected_query = ::CGI.parse(['Float=-Infinity', 'Double=-Infinity'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.all_query_string_types({
            query_float: -Float::INFINITY,
            query_double: -Float::INFINITY,
            query_params_map_of_string_list: {
              'Float' => [
                "-Infinity"
              ],
              'Double' => [
                "-Infinity"
              ]
            }
          }, **opts)
        end

        # Query values of 0 and false are serialized
        it 'RailsJsonZeroAndFalseQueryValues' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/AllQueryStringTypesInput')
            expected_query = ::CGI.parse(['Integer=0', 'Boolean=false'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.all_query_string_types({
            query_integer: 0,
            query_boolean: false,
            query_params_map_of_string_list: {
              'Integer' => [
                "0"
              ],
              'Boolean' => [
                "false"
              ]
            }
          }, **opts)
        end

      end

    end

    describe '#constant_and_variable_query_string' do

      describe 'requests' do

        # Mixes constant and variable query string parameters
        it 'RailsJsonConstantAndVariableQueryStringMissingOneValue' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/ConstantAndVariableQueryString')
            expected_query = ::CGI.parse(['foo=bar', 'baz=bam'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            forbid_query = ['maybeSet']
            actual_query = ::CGI.parse(request.uri.query)
            forbid_query.each do |query|
              expect(actual_query.key?(query)).to be false
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.constant_and_variable_query_string({
            baz: "bam"
          }, **opts)
        end

        # Mixes constant and variable query string parameters
        it 'RailsJsonConstantAndVariableQueryStringAllValues' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/ConstantAndVariableQueryString')
            expected_query = ::CGI.parse(['foo=bar', 'baz=bam', 'maybeSet=yes'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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
        it 'RailsJsonConstantQueryString' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/ConstantQueryString/hi')
            expected_query = ::CGI.parse(['foo=bar', 'hello'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.constant_query_string({
            hello: "hi"
          }, **opts)
        end

      end

    end

    describe '#datetime_offsets' do

      describe 'responses' do

        # Ensures that clients can correctly parse datetime (timestamps) with offsets
        it 'RailsJsonDateTimeWithNegativeOffset' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.body.write('      {
                    "datetime": "2019-12-16T22:48:18-01:00"
                }
          ')
          response.body.rewind
          client.stub_responses(:datetime_offsets, response)
          allow(Builders::DatetimeOffsets).to receive(:build)
          output = client.datetime_offsets({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            datetime: Time.at(1576540098)
          })
        end

        # Ensures that clients can correctly parse datetime (timestamps) with offsets
        it 'RailsJsonDateTimeWithPositiveOffset' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.body.write('      {
                    "datetime": "2019-12-17T00:48:18+01:00"
                }
          ')
          response.body.rewind
          client.stub_responses(:datetime_offsets, response)
          allow(Builders::DatetimeOffsets).to receive(:build)
          output = client.datetime_offsets({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            datetime: Time.at(1576540098)
          })
        end

      end

      describe 'stubs' do

        # Ensures that clients can correctly parse datetime (timestamps) with offsets
        it 'stubs RailsJsonDateTimeWithNegativeOffset' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::DatetimeOffsets).to receive(:build)
          client.stub_responses(:datetime_offsets, data: {
            datetime: Time.at(1576540098)
          })
          output = client.datetime_offsets({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            datetime: Time.at(1576540098)
          })
        end

        # Ensures that clients can correctly parse datetime (timestamps) with offsets
        it 'stubs RailsJsonDateTimeWithPositiveOffset' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::DatetimeOffsets).to receive(:build)
          client.stub_responses(:datetime_offsets, data: {
            datetime: Time.at(1576540098)
          })
          output = client.datetime_offsets({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            datetime: Time.at(1576540098)
          })
        end

      end

    end

    describe '#document_type' do

      describe 'requests' do

        # Serializes document types as part of the JSON request payload with no escaping.
        it 'RailsJsonDocumentTypeInputWithObject' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/DocumentType')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "string_value": "string",
                "document_value": {
                    "foo": "bar"
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.document_type({
            string_value: "string",
            document_value: {'foo' => 'bar'}
          }, **opts)
        end

        # Serializes document types using a string.
        it 'RailsJsonDocumentInputWithString' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/DocumentType')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "string_value": "string",
                "document_value": "hello"
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.document_type({
            string_value: "string",
            document_value: 'hello'
          }, **opts)
        end

        # Serializes document types using a number.
        it 'RailsJsonDocumentInputWithNumber' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/DocumentType')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "string_value": "string",
                "document_value": 10
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.document_type({
            string_value: "string",
            document_value: 10
          }, **opts)
        end

        # Serializes document types using a boolean.
        it 'RailsJsonDocumentInputWithBoolean' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/DocumentType')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "string_value": "string",
                "document_value": true
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.document_type({
            string_value: "string",
            document_value: true
          }, **opts)
        end

        # Serializes document types using a list.
        it 'RailsJsonDocumentInputWithList' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/DocumentType')
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
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.document_type({
            string_value: "string",
            document_value: [true, 'hi', [1, 2], {'foo' => {'baz' => [3, 4]}}]
          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes documents as part of the JSON response payload with no escaping.
        it 'RailsJsonDocumentOutput' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "string_value": "string",
              "document_value": {
                  "foo": "bar"
              }
          }')
          response.body.rewind
          client.stub_responses(:document_type, response)
          allow(Builders::DocumentType).to receive(:build)
          output = client.document_type({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            string_value: "string",
            document_value: {'foo' => 'bar'}
          })
        end

        # Document types can be JSON scalars too.
        it 'RailsJsonDocumentOutputString' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "string_value": "string",
              "document_value": "hello"
          }')
          response.body.rewind
          client.stub_responses(:document_type, response)
          allow(Builders::DocumentType).to receive(:build)
          output = client.document_type({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            string_value: "string",
            document_value: 'hello'
          })
        end

        # Document types can be JSON scalars too.
        it 'RailsJsonDocumentOutputNumber' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "string_value": "string",
              "document_value": 10
          }')
          response.body.rewind
          client.stub_responses(:document_type, response)
          allow(Builders::DocumentType).to receive(:build)
          output = client.document_type({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            string_value: "string",
            document_value: 10
          })
        end

        # Document types can be JSON scalars too.
        it 'RailsJsonDocumentOutputBoolean' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "string_value": "string",
              "document_value": false
          }')
          response.body.rewind
          client.stub_responses(:document_type, response)
          allow(Builders::DocumentType).to receive(:build)
          output = client.document_type({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            string_value: "string",
            document_value: false
          })
        end

        # Document types can be JSON arrays.
        it 'RailsJsonDocumentOutputArray' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "string_value": "string",
              "document_value": [
                  true,
                  false
              ]
          }')
          response.body.rewind
          client.stub_responses(:document_type, response)
          allow(Builders::DocumentType).to receive(:build)
          output = client.document_type({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            string_value: "string",
            document_value: [true, false]
          })
        end

      end

      describe 'stubs' do

        # Serializes documents as part of the JSON response payload with no escaping.
        it 'stubs RailsJsonDocumentOutput' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::DocumentType).to receive(:build)
          client.stub_responses(:document_type, data: {
            string_value: "string",
            document_value: {'foo' => 'bar'}
          })
          output = client.document_type({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            string_value: "string",
            document_value: {'foo' => 'bar'}
          })
        end

        # Document types can be JSON scalars too.
        it 'stubs RailsJsonDocumentOutputString' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::DocumentType).to receive(:build)
          client.stub_responses(:document_type, data: {
            string_value: "string",
            document_value: 'hello'
          })
          output = client.document_type({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            string_value: "string",
            document_value: 'hello'
          })
        end

        # Document types can be JSON scalars too.
        it 'stubs RailsJsonDocumentOutputNumber' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::DocumentType).to receive(:build)
          client.stub_responses(:document_type, data: {
            string_value: "string",
            document_value: 10
          })
          output = client.document_type({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            string_value: "string",
            document_value: 10
          })
        end

        # Document types can be JSON scalars too.
        it 'stubs RailsJsonDocumentOutputBoolean' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::DocumentType).to receive(:build)
          client.stub_responses(:document_type, data: {
            string_value: "string",
            document_value: false
          })
          output = client.document_type({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            string_value: "string",
            document_value: false
          })
        end

        # Document types can be JSON arrays.
        it 'stubs RailsJsonDocumentOutputArray' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::DocumentType).to receive(:build)
          client.stub_responses(:document_type, data: {
            string_value: "string",
            document_value: [true, false]
          })
          output = client.document_type({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            string_value: "string",
            document_value: [true, false]
          })
        end

      end

    end

    describe '#document_type_as_map_value' do

      describe 'requests' do

        # Serializes a map that uses documents as the value.
        it 'RailsJsonDocumentTypeAsMapValueInput' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/DocumentTypeAsMapValue')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "doc_valued_map": {
                    "foo": { "f": 1, "o": 2 },
                    "bar": [ "b", "a", "r" ],
                    "baz": "BAZ"
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.document_type_as_map_value({
            doc_valued_map: {
              'foo' => {'f' => 1, 'o' => 2},
              'bar' => ['b', 'a', 'r'],
              'baz' => 'BAZ'
            }
          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes a map that uses documents as the value.
        it 'RailsJsonDocumentTypeAsMapValueOutput' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "doc_valued_map": {
                  "foo": { "f": 1, "o": 2 },
                  "bar": [ "b", "a", "r" ],
                  "baz": "BAZ"
              }
          }')
          response.body.rewind
          client.stub_responses(:document_type_as_map_value, response)
          allow(Builders::DocumentTypeAsMapValue).to receive(:build)
          output = client.document_type_as_map_value({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            doc_valued_map: {
              'foo' => {'f' => 1, 'o' => 2},
              'bar' => ['b', 'a', 'r'],
              'baz' => 'BAZ'
            }
          })
        end

      end

      describe 'stubs' do

        # Serializes a map that uses documents as the value.
        it 'stubs RailsJsonDocumentTypeAsMapValueOutput' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::DocumentTypeAsMapValue).to receive(:build)
          client.stub_responses(:document_type_as_map_value, data: {
            doc_valued_map: {
              'foo' => {'f' => 1, 'o' => 2},
              'bar' => ['b', 'a', 'r'],
              'baz' => 'BAZ'
            }
          })
          output = client.document_type_as_map_value({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            doc_valued_map: {
              'foo' => {'f' => 1, 'o' => 2},
              'bar' => ['b', 'a', 'r'],
              'baz' => 'BAZ'
            }
          })
        end

      end

    end

    describe '#document_type_as_payload' do

      describe 'requests' do

        # Serializes a document as the target of the httpPayload trait.
        it 'RailsJsonDocumentTypeAsPayloadInput' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/DocumentTypeAsPayload')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "foo": "bar"
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.document_type_as_payload({
            document_value: {'foo' => 'bar'}
          }, **opts)
        end

        # Serializes a document as the target of the httpPayload trait using a string.
        it 'RailsJsonDocumentTypeAsPayloadInputString' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/DocumentTypeAsPayload')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('"hello"'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.document_type_as_payload({
            document_value: 'hello'
          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes a document as the target of the httpPayload trait.
        it 'RailsJsonDocumentTypeAsPayloadOutput' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "foo": "bar"
          }')
          response.body.rewind
          client.stub_responses(:document_type_as_payload, response)
          allow(Builders::DocumentTypeAsPayload).to receive(:build)
          output = client.document_type_as_payload({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            document_value: {'foo' => 'bar'}
          })
        end

        # Serializes a document as a payload string.
        it 'RailsJsonDocumentTypeAsPayloadOutputString' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('"hello"')
          response.body.rewind
          client.stub_responses(:document_type_as_payload, response)
          allow(Builders::DocumentTypeAsPayload).to receive(:build)
          output = client.document_type_as_payload({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            document_value: 'hello'
          })
        end

      end

      describe 'stubs' do

        # Serializes a document as the target of the httpPayload trait.
        it 'stubs RailsJsonDocumentTypeAsPayloadOutput' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::DocumentTypeAsPayload).to receive(:build)
          client.stub_responses(:document_type_as_payload, data: {
            document_value: {'foo' => 'bar'}
          })
          output = client.document_type_as_payload({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            document_value: {'foo' => 'bar'}
          })
        end

        # Serializes a document as a payload string.
        it 'stubs RailsJsonDocumentTypeAsPayloadOutputString' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::DocumentTypeAsPayload).to receive(:build)
          client.stub_responses(:document_type_as_payload, data: {
            document_value: 'hello'
          })
          output = client.document_type_as_payload({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            document_value: 'hello'
          })
        end

      end

    end

    describe '#empty_input_and_empty_output' do

      describe 'requests' do

        # Clients should not serialize a JSON payload when no parameters
        # are given that are sent in the body. A service will tolerate
        # clients that omit a payload or that send a JSON object.
        it 'RailsJsonEmptyInputAndEmptyOutput' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/EmptyInputAndEmptyOutput')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.empty_input_and_empty_output({

          }, **opts)
        end

      end

      describe 'responses' do

        # As of January 2021, server implementations are expected to
        # respond with a JSON object regardless of if the output
        # parameters are empty.
        it 'RailsJsonEmptyInputAndEmptyOutput' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{}')
          response.body.rewind
          client.stub_responses(:empty_input_and_empty_output, response)
          allow(Builders::EmptyInputAndEmptyOutput).to receive(:build)
          output = client.empty_input_and_empty_output({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

        # This test ensures that clients can gracefully handle
        # situations where a service omits a JSON payload entirely.
        it 'RailsJsonEmptyInputAndEmptyOutputJsonObjectOutput' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.body.write('')
          response.body.rewind
          client.stub_responses(:empty_input_and_empty_output, response)
          allow(Builders::EmptyInputAndEmptyOutput).to receive(:build)
          output = client.empty_input_and_empty_output({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

      end

      describe 'stubs' do

        # As of January 2021, server implementations are expected to
        # respond with a JSON object regardless of if the output
        # parameters are empty.
        it 'stubs RailsJsonEmptyInputAndEmptyOutput' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::EmptyInputAndEmptyOutput).to receive(:build)
          client.stub_responses(:empty_input_and_empty_output, data: {

          })
          output = client.empty_input_and_empty_output({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

        # This test ensures that clients can gracefully handle
        # situations where a service omits a JSON payload entirely.
        it 'stubs RailsJsonEmptyInputAndEmptyOutputJsonObjectOutput' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::EmptyInputAndEmptyOutput).to receive(:build)
          client.stub_responses(:empty_input_and_empty_output, data: {

          })
          output = client.empty_input_and_empty_output({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

      end

    end

    describe '#endpoint_operation' do

      describe 'requests' do

        # Operations can prepend to the given host if they define the
        # endpoint trait.
        it 'RailsJsonEndpointTrait' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.host).to eq('foo.example.com')
            expect(request.uri.path).to eq('/EndpointOperation')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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
        it 'RailsJsonEndpointTraitWithHostLabel' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.host).to eq('foo.bar.example.com')
            expect(request.uri.path).to eq('/EndpointWithHostLabelOperation')
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"label": "bar"}'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          opts[:endpoint] = 'http://example.com'
          client.endpoint_with_host_label_operation({
            label: "bar"
          }, **opts)
        end

      end

    end

    describe '#fractional_seconds' do

      describe 'responses' do

        # Ensures that clients can correctly parse datetime timestamps with fractional seconds
        it 'RailsJsonDateTimeWithFractionalSeconds' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.body.write('      {
                    "datetime": "2000-01-02T20:34:56.123Z"
                }
          ')
          response.body.rewind
          client.stub_responses(:fractional_seconds, response)
          allow(Builders::FractionalSeconds).to receive(:build)
          output = client.fractional_seconds({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            datetime: Time.at(946845296, 123, :millisecond)
          })
        end

      end

      describe 'stubs' do

        # Ensures that clients can correctly parse datetime timestamps with fractional seconds
        it 'stubs RailsJsonDateTimeWithFractionalSeconds' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::FractionalSeconds).to receive(:build)
          client.stub_responses(:fractional_seconds, data: {
            datetime: Time.at(946845296, 123, :millisecond)
          })
          output = client.fractional_seconds({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            datetime: Time.at(946845296, 123, :millisecond)
          })
        end

      end

    end

    describe '#greeting_with_errors' do

      describe 'responses' do

        # Ensures that operations with errors successfully know how
        # to deserialize a successful response. As of January 2021,
        # server implementations are expected to respond with a
        # JSON object regardless of if the output parameters are
        # empty.
        it 'RailsJsonGreetingWithErrors' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-Greeting'] = 'Hello'
          response.body.write('{}')
          response.body.rewind
          client.stub_responses(:greeting_with_errors, response)
          allow(Builders::GreetingWithErrors).to receive(:build)
          output = client.greeting_with_errors({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            greeting: "Hello"
          })
        end

        # This test is similar to RailsJsonGreetingWithErrors, but it
        # ensures that clients can gracefully deal with a server
        # omitting a response payload.
        it 'RailsJsonGreetingWithErrorsNoPayload' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-Greeting'] = 'Hello'
          response.body.write('')
          response.body.rewind
          client.stub_responses(:greeting_with_errors, response)
          allow(Builders::GreetingWithErrors).to receive(:build)
          output = client.greeting_with_errors({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            greeting: "Hello"
          })
        end

      end

      describe 'stubs' do

        # Ensures that operations with errors successfully know how
        # to deserialize a successful response. As of January 2021,
        # server implementations are expected to respond with a
        # JSON object regardless of if the output parameters are
        # empty.
        it 'stubs RailsJsonGreetingWithErrors' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::GreetingWithErrors).to receive(:build)
          client.stub_responses(:greeting_with_errors, data: {
            greeting: "Hello"
          })
          output = client.greeting_with_errors({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            greeting: "Hello"
          })
        end

        # This test is similar to RailsJsonGreetingWithErrors, but it
        # ensures that clients can gracefully deal with a server
        # omitting a response payload.
        it 'stubs RailsJsonGreetingWithErrorsNoPayload' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::GreetingWithErrors).to receive(:build)
          client.stub_responses(:greeting_with_errors, data: {
            greeting: "Hello"
          })
          output = client.greeting_with_errors({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            greeting: "Hello"
          })
        end

      end

      describe 'InvalidGreeting error' do

        # Parses simple JSON errors
        it 'RailsJsonInvalidGreetingError' do
          response = Hearth::HTTP::Response.new
          response.status = 400
          response.headers['Content-Type'] = 'application/json'
          response.headers['X-Amzn-Errortype'] = 'InvalidGreeting'
          response.body.write('{
              "message": "Hi"
          }')
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

        # Parses simple JSON errors
        it 'stubs RailsJsonInvalidGreetingError' do
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

        # Serializes a complex error with no message member
        it 'RailsJsonComplexErrorWithNoMessage' do
          response = Hearth::HTTP::Response.new
          response.status = 403
          response.headers['Content-Type'] = 'application/json'
          response.headers['X-Amzn-Errortype'] = 'ComplexError'
          response.headers['X-Header'] = 'Header'
          response.body.write('{
              "top_level": "Top level",
              "nested": {
                  "Fooooo": "bar"
              }
          }')
          response.body.rewind
          client.stub_responses(:greeting_with_errors, response)
          allow(Builders::GreetingWithErrors).to receive(:build)
          begin
            output = client.greeting_with_errors({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          rescue Errors::ComplexError => e
            expect(e.data.to_h).to eq({
              header: "Header",
              top_level: "Top level",
              nested: {
                foo: "bar"
              }
            })
          end
        end

        # Serializes a complex error with no message member
        it 'stubs RailsJsonComplexErrorWithNoMessage' do
          client.stub_responses(:greeting_with_errors, error: { class: Errors::ComplexError, data: {
            header: "Header",
            top_level: "Top level",
            nested: {
              foo: "bar"
            }
          } })
          allow(Builders::GreetingWithErrors).to receive(:build)
          begin
            output = client.greeting_with_errors({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          rescue Errors::ComplexError => e
            expect(e.http_status).to eq(403)
            expect(e.data.to_h).to eq({
              header: "Header",
              top_level: "Top level",
              nested: {
                foo: "bar"
              }
            })
          end
        end

        #
        it 'RailsJsonEmptyComplexErrorWithNoMessage' do
          response = Hearth::HTTP::Response.new
          response.status = 403
          response.headers['Content-Type'] = 'application/json'
          response.headers['X-Amzn-Errortype'] = 'ComplexError'
          response.body.write('{}')
          response.body.rewind
          client.stub_responses(:greeting_with_errors, response)
          allow(Builders::GreetingWithErrors).to receive(:build)
          begin
            output = client.greeting_with_errors({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          rescue Errors::ComplexError => e
            expect(e.data.to_h).to eq({

            })
          end
        end

        #
        it 'stubs RailsJsonEmptyComplexErrorWithNoMessage' do
          client.stub_responses(:greeting_with_errors, error: { class: Errors::ComplexError, data: {

          } })
          allow(Builders::GreetingWithErrors).to receive(:build)
          begin
            output = client.greeting_with_errors({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          rescue Errors::ComplexError => e
            expect(e.http_status).to eq(403)
            expect(e.data.to_h).to eq({

            })
          end
        end
      end

    end

    describe '#host_with_path_operation' do

      describe 'requests' do

        # Custom endpoints supplied by users can have paths
        it 'RailsJsonHostWithPath' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/custom/HostWithPathOperation')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          opts[:endpoint] = 'http://example.com/custom'
          client.host_with_path_operation({

          }, **opts)
        end

      end

    end

    describe '#http_checksum_required' do

      describe 'requests' do

        # Adds Content-MD5 header
        it 'RailsJsonHttpChecksumRequired' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/HttpChecksumRequired')
            { 'Content-MD5' => 'iB0/3YSo7maijL0IGOgA9g==', 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "foo":"base64 encoded md5 checksum"
            }
            '))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.http_checksum_required({
            foo: "base64 encoded md5 checksum"
          }, **opts)
        end

      end

    end

    describe '#http_enum_payload' do

      describe 'requests' do

        #
        it 'RailsJsonEnumPayloadRequest' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/EnumPayload')
            expect(request.body.read).to eq('enumvalue')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.http_enum_payload({
            payload: "enumvalue"
          }, **opts)
        end

      end

      describe 'responses' do

        #
        it 'RailsJsonEnumPayloadResponse' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.body.write('enumvalue')
          response.body.rewind
          client.stub_responses(:http_enum_payload, response)
          allow(Builders::HttpEnumPayload).to receive(:build)
          output = client.http_enum_payload({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            payload: "enumvalue"
          })
        end

      end

      describe 'stubs' do

        #
        it 'stubs RailsJsonEnumPayloadResponse' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::HttpEnumPayload).to receive(:build)
          client.stub_responses(:http_enum_payload, data: {
            payload: "enumvalue"
          })
          output = client.http_enum_payload({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            payload: "enumvalue"
          })
        end

      end

    end

    describe '#http_payload_traits' do

      describe 'requests' do

        # Serializes a blob in the HTTP payload
        it 'RailsJsonHttpPayloadTraitsWithBlob' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/HttpPayloadTraits')
            { 'Content-Type' => 'application/octet-stream', 'X-Foo' => 'Foo' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(request.body.read).to eq('blobby blob blob')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.http_payload_traits({
            foo: "Foo",
            blob: 'blobby blob blob'
          }, **opts)
        end

        # Serializes an empty blob in the HTTP payload
        it 'RailsJsonHttpPayloadTraitsWithNoBlobBody' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/HttpPayloadTraits')
            { 'X-Foo' => 'Foo' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.http_payload_traits({
            foo: "Foo"
          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes a blob in the HTTP payload
        it 'RailsJsonHttpPayloadTraitsWithBlob' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-Foo'] = 'Foo'
          response.body.write('blobby blob blob')
          response.body.rewind
          client.stub_responses(:http_payload_traits, response)
          allow(Builders::HttpPayloadTraits).to receive(:build)
          output = client.http_payload_traits({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            foo: "Foo",
            blob: 'blobby blob blob'
          })
        end

        # Serializes an empty blob in the HTTP payload
        it 'RailsJsonHttpPayloadTraitsWithNoBlobBody' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-Foo'] = 'Foo'
          response.body.write('')
          response.body.rewind
          client.stub_responses(:http_payload_traits, response)
          allow(Builders::HttpPayloadTraits).to receive(:build)
          output = client.http_payload_traits({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            foo: "Foo"
          })
        end

      end

      describe 'stubs' do

        # Serializes a blob in the HTTP payload
        it 'stubs RailsJsonHttpPayloadTraitsWithBlob' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::HttpPayloadTraits).to receive(:build)
          client.stub_responses(:http_payload_traits, data: {
            foo: "Foo",
            blob: 'blobby blob blob'
          })
          output = client.http_payload_traits({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            foo: "Foo",
            blob: 'blobby blob blob'
          })
        end

        # Serializes an empty blob in the HTTP payload
        it 'stubs RailsJsonHttpPayloadTraitsWithNoBlobBody' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::HttpPayloadTraits).to receive(:build)
          client.stub_responses(:http_payload_traits, data: {
            foo: "Foo"
          })
          output = client.http_payload_traits({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            foo: "Foo"
          })
        end

      end

    end

    describe '#http_payload_traits_with_media_type' do

      describe 'requests' do

        # Serializes a blob in the HTTP payload with a content-type
        it 'RailsJsonHttpPayloadTraitsWithMediaTypeWithBlob' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/HttpPayloadTraitsWithMediaType')
            { 'Content-Type' => 'text/plain', 'X-Foo' => 'Foo' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(request.body.read).to eq('blobby blob blob')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.http_payload_traits_with_media_type({
            foo: "Foo",
            blob: 'blobby blob blob'
          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes a blob in the HTTP payload with a content-type
        it 'RailsJsonHttpPayloadTraitsWithMediaTypeWithBlob' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'text/plain'
          response.headers['X-Foo'] = 'Foo'
          response.body.write('blobby blob blob')
          response.body.rewind
          client.stub_responses(:http_payload_traits_with_media_type, response)
          allow(Builders::HttpPayloadTraitsWithMediaType).to receive(:build)
          output = client.http_payload_traits_with_media_type({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            foo: "Foo",
            blob: 'blobby blob blob'
          })
        end

      end

      describe 'stubs' do

        # Serializes a blob in the HTTP payload with a content-type
        it 'stubs RailsJsonHttpPayloadTraitsWithMediaTypeWithBlob' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::HttpPayloadTraitsWithMediaType).to receive(:build)
          client.stub_responses(:http_payload_traits_with_media_type, data: {
            foo: "Foo",
            blob: 'blobby blob blob'
          })
          output = client.http_payload_traits_with_media_type({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            foo: "Foo",
            blob: 'blobby blob blob'
          })
        end

      end

    end

    describe '#http_payload_with_structure' do

      describe 'requests' do

        # Serializes a structure in the payload
        it 'RailsJsonHttpPayloadWithStructure' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/HttpPayloadWithStructure')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "greeting": "hello",
                "name": "Phreddy"
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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
        it 'RailsJsonHttpPayloadWithStructure' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "greeting": "hello",
              "name": "Phreddy"
          }')
          response.body.rewind
          client.stub_responses(:http_payload_with_structure, response)
          allow(Builders::HttpPayloadWithStructure).to receive(:build)
          output = client.http_payload_with_structure({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            nested: {
              greeting: "hello",
              name: "Phreddy"
            }
          })
        end

      end

      describe 'stubs' do

        # Serializes a structure in the payload
        it 'stubs RailsJsonHttpPayloadWithStructure' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::HttpPayloadWithStructure).to receive(:build)
          client.stub_responses(:http_payload_with_structure, data: {
            nested: {
              greeting: "hello",
              name: "Phreddy"
            }
          })
          output = client.http_payload_with_structure({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            nested: {
              greeting: "hello",
              name: "Phreddy"
            }
          })
        end

      end

    end

    describe '#http_payload_with_union' do

      describe 'requests' do

        # Serializes a union in the payload.
        it 'RailsJsonHttpPayloadWithUnion' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/HttpPayloadWithUnion')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "greeting": "hello"
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.http_payload_with_union({
            nested: {
              greeting: "hello"
            }
          }, **opts)
        end

        # No payload is sent if the union has no value.
        it 'RailsJsonHttpPayloadWithUnsetUnion' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/HttpPayloadWithUnion')
            expect(request.body.read).to eq('{}')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.http_payload_with_union({

          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes a union in the payload.
        it 'RailsJsonHttpPayloadWithUnion' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "greeting": "hello"
          }')
          response.body.rewind
          client.stub_responses(:http_payload_with_union, response)
          allow(Builders::HttpPayloadWithUnion).to receive(:build)
          output = client.http_payload_with_union({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            nested: {
              greeting: "hello"
            }
          })
        end

        # No payload is sent if the union has no value.
        it 'RailsJsonHttpPayloadWithUnsetUnion' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Length'] = '0'
          response.body.write('{}')
          response.body.rewind
          client.stub_responses(:http_payload_with_union, response)
          allow(Builders::HttpPayloadWithUnion).to receive(:build)
          output = client.http_payload_with_union({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

      end

      describe 'stubs' do

        # Serializes a union in the payload.
        it 'stubs RailsJsonHttpPayloadWithUnion' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::HttpPayloadWithUnion).to receive(:build)
          client.stub_responses(:http_payload_with_union, data: {
            nested: {
              greeting: "hello"
            }
          })
          output = client.http_payload_with_union({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            nested: {
              greeting: "hello"
            }
          })
        end

        # No payload is sent if the union has no value.
        it 'stubs RailsJsonHttpPayloadWithUnsetUnion' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::HttpPayloadWithUnion).to receive(:build)
          client.stub_responses(:http_payload_with_union, data: {

          })
          output = client.http_payload_with_union({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

      end

    end

    describe '#http_prefix_headers' do

      describe 'requests' do

        # Adds headers by prefix
        it 'RailsJsonHttpPrefixHeadersArePresent' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/HttpPrefixHeaders')
            { 'X-Foo' => 'Foo', 'X-Foo-Abc' => 'Abc value', 'X-Foo-Def' => 'Def value' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.http_prefix_headers({
            foo: "Foo",
            foo_map: {
              'Abc' => "Abc value",
              'Def' => "Def value"
            }
          }, **opts)
        end

        # No prefix headers are serialized because the value is empty
        it 'RailsJsonHttpPrefixHeadersAreNotPresent' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/HttpPrefixHeaders')
            { 'X-Foo' => 'Foo' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.http_prefix_headers({
            foo: "Foo",
            foo_map: {

            }
          }, **opts)
        end

      end

      describe 'responses' do

        # Adds headers by prefix
        it 'RailsJsonHttpPrefixHeadersArePresent' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-Foo'] = 'Foo'
          response.headers['X-Foo-Abc'] = 'Abc value'
          response.headers['X-Foo-Def'] = 'Def value'
          client.stub_responses(:http_prefix_headers, response)
          allow(Builders::HttpPrefixHeaders).to receive(:build)
          output = client.http_prefix_headers({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            foo: "Foo",
            foo_map: {
              'Abc' => "Abc value",
              'Def' => "Def value"
            }
          })
        end

      end

      describe 'stubs' do

        # Adds headers by prefix
        it 'stubs RailsJsonHttpPrefixHeadersArePresent' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::HttpPrefixHeaders).to receive(:build)
          client.stub_responses(:http_prefix_headers, data: {
            foo: "Foo",
            foo_map: {
              'Abc' => "Abc value",
              'Def' => "Def value"
            }
          })
          output = client.http_prefix_headers({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
        it 'RailsJsonHttpPrefixHeadersResponse' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Hello'] = 'Hello'
          response.headers['X-Foo'] = 'Foo'
          client.stub_responses(:http_prefix_headers_in_response, response)
          allow(Builders::HttpPrefixHeadersInResponse).to receive(:build)
          output = client.http_prefix_headers_in_response({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            prefix_headers: {
              'X-Foo' => "Foo",
              'Hello' => "Hello"
            }
          })
        end

      end

      describe 'stubs' do

        # (de)serializes all response headers
        it 'stubs RailsJsonHttpPrefixHeadersResponse' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::HttpPrefixHeadersInResponse).to receive(:build)
          client.stub_responses(:http_prefix_headers_in_response, data: {
            prefix_headers: {
              'X-Foo' => "Foo",
              'Hello' => "Hello"
            }
          })
          output = client.http_prefix_headers_in_response({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
        it 'RailsJsonSupportsNaNFloatLabels' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/FloatHttpLabels/NaN/NaN')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.http_request_with_float_labels({
            float: Float::NAN,
            double: Float::NAN
          }, **opts)
        end

        # Supports handling Infinity float label values.
        it 'RailsJsonSupportsInfinityFloatLabels' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/FloatHttpLabels/Infinity/Infinity')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.http_request_with_float_labels({
            float: Float::INFINITY,
            double: Float::INFINITY
          }, **opts)
        end

        # Supports handling -Infinity float label values.
        it 'RailsJsonSupportsNegativeInfinityFloatLabels' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/FloatHttpLabels/-Infinity/-Infinity')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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
        it 'RailsJsonHttpRequestWithGreedyLabelInPath' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/HttpRequestWithGreedyLabelInPath/foo/hello%2Fescape/baz/there/guy')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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
        it 'RailsJsonInputWithHeadersAndAllParams' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/HttpRequestWithLabels/string/1/2/3/4.1/5.1/true/2019-12-16T23%3A48%3A18Z')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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
        it 'RailsJsonHttpRequestLabelEscaping' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/HttpRequestWithLabels/%20%25%3A%2F%3F%23%5B%5D%40%21%24%26%27%28%29%2A%2B%2C%3B%3D%F0%9F%98%B9/1/2/3/4.1/5.1/true/2019-12-16T23%3A48%3A18Z')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.http_request_with_labels({
            string: " %:/?#[]@!$&'()*+,;=😹",
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
        it 'RailsJsonHttpRequestWithLabelsAndTimestampFormat' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/HttpRequestWithLabelsAndTimestampFormat/1576540098/Mon%2C%2016%20Dec%202019%2023%3A48%3A18%20GMT/2019-12-16T23%3A48%3A18Z/2019-12-16T23%3A48%3A18Z/1576540098/Mon%2C%2016%20Dec%202019%2023%3A48%3A18%20GMT/2019-12-16T23%3A48%3A18Z')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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

    describe '#http_request_with_regex_literal' do

      describe 'requests' do

        # Path matching is not broken by regex expressions in literal segments
        it 'RailsJsonToleratesRegexCharsInSegments' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/ReDosLiteral/abc/(a+)+')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.http_request_with_regex_literal({
            str: "abc"
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
        it 'RailsJsonHttpResponseCode' do
          response = Hearth::HTTP::Response.new
          response.status = 201
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{}')
          response.body.rewind
          client.stub_responses(:http_response_code, response)
          allow(Builders::HttpResponseCode).to receive(:build)
          output = client.http_response_code({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            status: 201
          })
        end

        # This test ensures that clients gracefully handle cases where
        # the service responds with no payload rather than an empty JSON
        # object.
        it 'RailsJsonHttpResponseCodeWithNoPayload' do
          response = Hearth::HTTP::Response.new
          response.status = 201
          response.body.write('')
          response.body.rewind
          client.stub_responses(:http_response_code, response)
          allow(Builders::HttpResponseCode).to receive(:build)
          output = client.http_response_code({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            status: 201
          })
        end

      end

      describe 'stubs' do

        # Binds the http response code to an output structure. Note that
        # even though all members are bound outside of the payload, an
        # empty JSON object is serialized in the response. However,
        # clients should be able to handle an empty JSON object or an
        # empty payload without failing to deserialize a response.
        it 'stubs RailsJsonHttpResponseCode' do
          proc = proc do |context|
            expect(context.response.status).to eq(201)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::HttpResponseCode).to receive(:build)
          client.stub_responses(:http_response_code, data: {
            status: 201
          })
          output = client.http_response_code({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            status: 201
          })
        end

        # This test ensures that clients gracefully handle cases where
        # the service responds with no payload rather than an empty JSON
        # object.
        it 'stubs RailsJsonHttpResponseCodeWithNoPayload' do
          proc = proc do |context|
            expect(context.response.status).to eq(201)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::HttpResponseCode).to receive(:build)
          client.stub_responses(:http_response_code, data: {
            status: 201
          })
          output = client.http_response_code({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            status: 201
          })
        end

      end

    end

    describe '#http_string_payload' do

      describe 'requests' do

        #
        it 'RailsJsonStringPayloadRequest' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/StringPayload')
            expect(request.body.read).to eq('rawstring')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.http_string_payload({
            payload: "rawstring"
          }, **opts)
        end

      end

      describe 'responses' do

        #
        it 'RailsJsonStringPayloadResponse' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.body.write('rawstring')
          response.body.rewind
          client.stub_responses(:http_string_payload, response)
          allow(Builders::HttpStringPayload).to receive(:build)
          output = client.http_string_payload({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            payload: "rawstring"
          })
        end

      end

      describe 'stubs' do

        #
        it 'stubs RailsJsonStringPayloadResponse' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::HttpStringPayload).to receive(:build)
          client.stub_responses(:http_string_payload, data: {
            payload: "rawstring"
          })
          output = client.http_string_payload({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            payload: "rawstring"
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
        it 'RailsJsonIgnoreQueryParamsInResponse' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{}')
          response.body.rewind
          client.stub_responses(:ignore_query_params_in_response, response)
          allow(Builders::IgnoreQueryParamsInResponse).to receive(:build)
          output = client.ignore_query_params_in_response({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

        # This test is similar to RailsJsonIgnoreQueryParamsInResponse,
        # but it ensures that clients gracefully handle responses from
        # the server that do not serialize an empty JSON object.
        it 'RailsJsonIgnoreQueryParamsInResponseNoPayload' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.body.write('')
          response.body.rewind
          client.stub_responses(:ignore_query_params_in_response, response)
          allow(Builders::IgnoreQueryParamsInResponse).to receive(:build)
          output = client.ignore_query_params_in_response({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

      end

      describe 'stubs' do

        # Query parameters must be ignored when serializing the output
        # of an operation. As of January 2021, server implementations
        # are expected to respond with a JSON object regardless of
        # if the output parameters are empty.
        it 'stubs RailsJsonIgnoreQueryParamsInResponse' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::IgnoreQueryParamsInResponse).to receive(:build)
          client.stub_responses(:ignore_query_params_in_response, data: {

          })
          output = client.ignore_query_params_in_response({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

        # This test is similar to RailsJsonIgnoreQueryParamsInResponse,
        # but it ensures that clients gracefully handle responses from
        # the server that do not serialize an empty JSON object.
        it 'stubs RailsJsonIgnoreQueryParamsInResponseNoPayload' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::IgnoreQueryParamsInResponse).to receive(:build)
          client.stub_responses(:ignore_query_params_in_response, data: {

          })
          output = client.ignore_query_params_in_response({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

      end

    end

    describe '#input_and_output_with_headers' do

      describe 'requests' do

        # Tests requests with string header bindings
        it 'RailsJsonInputAndOutputWithStringHeaders' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/InputAndOutputWithHeaders')
            { 'X-String' => 'Hello', 'X-StringList' => 'a, b, c', 'X-StringSet' => 'a, b, c' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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

        # Tests requests with string list header bindings that require quoting
        it 'RailsJsonInputAndOutputWithQuotedStringHeaders' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/InputAndOutputWithHeaders')
            { 'X-StringList' => '"b,c", "\"def\"", a' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.input_and_output_with_headers({
            header_string_list: [
              "b,c",
              "\"def\"",
              "a"
            ]
          }, **opts)
        end

        # Tests requests with numeric header bindings
        it 'RailsJsonInputAndOutputWithNumericHeaders' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/InputAndOutputWithHeaders')
            { 'X-Byte' => '1', 'X-Double' => '1.1', 'X-Float' => '1.1', 'X-Integer' => '123', 'X-IntegerList' => '1, 2, 3', 'X-Long' => '123', 'X-Short' => '123' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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
        it 'RailsJsonInputAndOutputWithBooleanHeaders' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/InputAndOutputWithHeaders')
            { 'X-Boolean1' => 'true', 'X-Boolean2' => 'false', 'X-BooleanList' => 'true, false, true' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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

        # Tests requests with timestamp header bindings
        it 'RailsJsonInputAndOutputWithTimestampHeaders' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/InputAndOutputWithHeaders')
            { 'X-TimestampList' => 'Mon, 16 Dec 2019 23:48:18 GMT, Mon, 16 Dec 2019 23:48:18 GMT' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.input_and_output_with_headers({
            header_timestamp_list: [
              Time.at(1576540098),
              Time.at(1576540098)
            ]
          }, **opts)
        end

        # Tests requests with enum header bindings
        it 'RailsJsonInputAndOutputWithEnumHeaders' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/InputAndOutputWithHeaders')
            { 'X-Enum' => 'Foo', 'X-EnumList' => 'Foo, Bar, Baz' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.input_and_output_with_headers({
            header_enum: "Foo",
            header_enum_list: [
              "Foo",
              "Bar",
              "Baz"
            ]
          }, **opts)
        end

        # Tests requests with intEnum header bindings
        it 'RailsJsonInputAndOutputWithIntEnumHeaders' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/InputAndOutputWithHeaders')
            { 'X-IntegerEnum' => '1', 'X-IntegerEnumList' => '1, 2, 3' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.input_and_output_with_headers({
            header_integer_enum: 1,
            header_integer_enum_list: [
              1,
              2,
              3
            ]
          }, **opts)
        end

        # Supports handling NaN float header values.
        it 'RailsJsonSupportsNaNFloatHeaderInputs' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/InputAndOutputWithHeaders')
            { 'X-Double' => 'NaN', 'X-Float' => 'NaN' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.input_and_output_with_headers({
            header_float: Float::NAN,
            header_double: Float::NAN
          }, **opts)
        end

        # Supports handling Infinity float header values.
        it 'RailsJsonSupportsInfinityFloatHeaderInputs' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/InputAndOutputWithHeaders')
            { 'X-Double' => 'Infinity', 'X-Float' => 'Infinity' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.input_and_output_with_headers({
            header_float: Float::INFINITY,
            header_double: Float::INFINITY
          }, **opts)
        end

        # Supports handling -Infinity float header values.
        it 'RailsJsonSupportsNegativeInfinityFloatHeaderInputs' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/InputAndOutputWithHeaders')
            { 'X-Double' => '-Infinity', 'X-Float' => '-Infinity' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.input_and_output_with_headers({
            header_float: -Float::INFINITY,
            header_double: -Float::INFINITY
          }, **opts)
        end

      end

      describe 'responses' do

        # Tests responses with string header bindings
        it 'RailsJsonInputAndOutputWithStringHeaders' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-String'] = 'Hello'
          response.headers['X-StringList'] = 'a, b, c'
          response.headers['X-StringSet'] = 'a, b, c'
          client.stub_responses(:input_and_output_with_headers, response)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          output = client.input_and_output_with_headers({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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

        # Tests responses with string list header bindings that require quoting
        it 'RailsJsonInputAndOutputWithQuotedStringHeaders' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-StringList'] = '"b,c", "\"def\"", a'
          client.stub_responses(:input_and_output_with_headers, response)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          output = client.input_and_output_with_headers({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_string_list: [
              "b,c",
              "\"def\"",
              "a"
            ]
          })
        end

        # Tests responses with numeric header bindings
        it 'RailsJsonInputAndOutputWithNumericHeaders' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-Byte'] = '1'
          response.headers['X-Double'] = '1.1'
          response.headers['X-Float'] = '1.1'
          response.headers['X-Integer'] = '123'
          response.headers['X-IntegerList'] = '1, 2, 3'
          response.headers['X-Long'] = '123'
          response.headers['X-Short'] = '123'
          client.stub_responses(:input_and_output_with_headers, response)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          output = client.input_and_output_with_headers({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
        it 'RailsJsonInputAndOutputWithBooleanHeaders' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-Boolean1'] = 'true'
          response.headers['X-Boolean2'] = 'false'
          response.headers['X-BooleanList'] = 'true, false, true'
          client.stub_responses(:input_and_output_with_headers, response)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          output = client.input_and_output_with_headers({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_true_bool: true,
            header_false_bool: false,
            header_boolean_list: [
              true,
              false,
              true
            ]
          })
        end

        # Tests responses with timestamp header bindings
        it 'RailsJsonInputAndOutputWithTimestampHeaders' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-TimestampList'] = 'Mon, 16 Dec 2019 23:48:18 GMT, Mon, 16 Dec 2019 23:48:18 GMT'
          client.stub_responses(:input_and_output_with_headers, response)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          output = client.input_and_output_with_headers({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_timestamp_list: [
              Time.at(1576540098),
              Time.at(1576540098)
            ]
          })
        end

        # Tests responses with enum header bindings
        it 'RailsJsonInputAndOutputWithEnumHeaders' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-Enum'] = 'Foo'
          response.headers['X-EnumList'] = 'Foo, Bar, Baz'
          client.stub_responses(:input_and_output_with_headers, response)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          output = client.input_and_output_with_headers({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_enum: "Foo",
            header_enum_list: [
              "Foo",
              "Bar",
              "Baz"
            ]
          })
        end

        # Tests responses with intEnum header bindings
        it 'RailsJsonInputAndOutputWithIntEnumHeaders' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-IntegerEnum'] = '1'
          response.headers['X-IntegerEnumList'] = '1, 2, 3'
          client.stub_responses(:input_and_output_with_headers, response)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          output = client.input_and_output_with_headers({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_integer_enum: 1,
            header_integer_enum_list: [
              1,
              2,
              3
            ]
          })
        end

        # Supports handling NaN float header values.
        it 'RailsJsonSupportsNaNFloatHeaderOutputs' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-Double'] = 'NaN'
          response.headers['X-Float'] = 'NaN'
          client.stub_responses(:input_and_output_with_headers, response)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          output = client.input_and_output_with_headers({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_float: Float::NAN,
            header_double: Float::NAN
          })
        end

        # Supports handling Infinity float header values.
        it 'RailsJsonSupportsInfinityFloatHeaderOutputs' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-Double'] = 'Infinity'
          response.headers['X-Float'] = 'Infinity'
          client.stub_responses(:input_and_output_with_headers, response)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          output = client.input_and_output_with_headers({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_float: Float::INFINITY,
            header_double: Float::INFINITY
          })
        end

        # Supports handling -Infinity float header values.
        it 'RailsJsonSupportsNegativeInfinityFloatHeaderOutputs' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-Double'] = '-Infinity'
          response.headers['X-Float'] = '-Infinity'
          client.stub_responses(:input_and_output_with_headers, response)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          output = client.input_and_output_with_headers({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_float: -Float::INFINITY,
            header_double: -Float::INFINITY
          })
        end

      end

      describe 'stubs' do

        # Tests responses with string header bindings
        it 'stubs RailsJsonInputAndOutputWithStringHeaders' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          client.stub_responses(:input_and_output_with_headers, data: {
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
          output = client.input_and_output_with_headers({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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

        # Tests responses with string list header bindings that require quoting
        it 'stubs RailsJsonInputAndOutputWithQuotedStringHeaders' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          client.stub_responses(:input_and_output_with_headers, data: {
            header_string_list: [
              "b,c",
              "\"def\"",
              "a"
            ]
          })
          output = client.input_and_output_with_headers({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_string_list: [
              "b,c",
              "\"def\"",
              "a"
            ]
          })
        end

        # Tests responses with numeric header bindings
        it 'stubs RailsJsonInputAndOutputWithNumericHeaders' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          client.stub_responses(:input_and_output_with_headers, data: {
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
          output = client.input_and_output_with_headers({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
        it 'stubs RailsJsonInputAndOutputWithBooleanHeaders' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          client.stub_responses(:input_and_output_with_headers, data: {
            header_true_bool: true,
            header_false_bool: false,
            header_boolean_list: [
              true,
              false,
              true
            ]
          })
          output = client.input_and_output_with_headers({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_true_bool: true,
            header_false_bool: false,
            header_boolean_list: [
              true,
              false,
              true
            ]
          })
        end

        # Tests responses with timestamp header bindings
        it 'stubs RailsJsonInputAndOutputWithTimestampHeaders' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          client.stub_responses(:input_and_output_with_headers, data: {
            header_timestamp_list: [
              Time.at(1576540098),
              Time.at(1576540098)
            ]
          })
          output = client.input_and_output_with_headers({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_timestamp_list: [
              Time.at(1576540098),
              Time.at(1576540098)
            ]
          })
        end

        # Tests responses with enum header bindings
        it 'stubs RailsJsonInputAndOutputWithEnumHeaders' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          client.stub_responses(:input_and_output_with_headers, data: {
            header_enum: "Foo",
            header_enum_list: [
              "Foo",
              "Bar",
              "Baz"
            ]
          })
          output = client.input_and_output_with_headers({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_enum: "Foo",
            header_enum_list: [
              "Foo",
              "Bar",
              "Baz"
            ]
          })
        end

        # Tests responses with intEnum header bindings
        it 'stubs RailsJsonInputAndOutputWithIntEnumHeaders' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          client.stub_responses(:input_and_output_with_headers, data: {
            header_integer_enum: 1,
            header_integer_enum_list: [
              1,
              2,
              3
            ]
          })
          output = client.input_and_output_with_headers({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_integer_enum: 1,
            header_integer_enum_list: [
              1,
              2,
              3
            ]
          })
        end

        # Supports handling NaN float header values.
        it 'stubs RailsJsonSupportsNaNFloatHeaderOutputs' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          client.stub_responses(:input_and_output_with_headers, data: {
            header_float: Float::NAN,
            header_double: Float::NAN
          })
          output = client.input_and_output_with_headers({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_float: Float::NAN,
            header_double: Float::NAN
          })
        end

        # Supports handling Infinity float header values.
        it 'stubs RailsJsonSupportsInfinityFloatHeaderOutputs' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          client.stub_responses(:input_and_output_with_headers, data: {
            header_float: Float::INFINITY,
            header_double: Float::INFINITY
          })
          output = client.input_and_output_with_headers({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_float: Float::INFINITY,
            header_double: Float::INFINITY
          })
        end

        # Supports handling -Infinity float header values.
        it 'stubs RailsJsonSupportsNegativeInfinityFloatHeaderOutputs' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::InputAndOutputWithHeaders).to receive(:build)
          client.stub_responses(:input_and_output_with_headers, data: {
            header_float: -Float::INFINITY,
            header_double: -Float::INFINITY
          })
          output = client.input_and_output_with_headers({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            header_float: -Float::INFINITY,
            header_double: -Float::INFINITY
          })
        end

      end

    end

    describe '#json_blobs' do

      describe 'requests' do

        # Blobs are base64 encoded
        it 'RailsJsonBlobs' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/JsonBlobs')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "data": "dmFsdWU="
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_blobs({
            data: 'value'
          }, **opts)
        end

      end

      describe 'responses' do

        # Blobs are base64 encoded
        it 'RailsJsonBlobs' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "data": "dmFsdWU="
          }')
          response.body.rewind
          client.stub_responses(:json_blobs, response)
          allow(Builders::JsonBlobs).to receive(:build)
          output = client.json_blobs({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            data: 'value'
          })
        end

      end

      describe 'stubs' do

        # Blobs are base64 encoded
        it 'stubs RailsJsonBlobs' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonBlobs).to receive(:build)
          client.stub_responses(:json_blobs, data: {
            data: 'value'
          })
          output = client.json_blobs({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            data: 'value'
          })
        end

      end

    end

    describe '#json_enums' do

      describe 'requests' do

        # Serializes simple scalar properties
        it 'RailsJsonEnums' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/JsonEnums')
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
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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
        it 'RailsJsonEnums' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
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
          response.body.rewind
          client.stub_responses(:json_enums, response)
          allow(Builders::JsonEnums).to receive(:build)
          output = client.json_enums({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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

      describe 'stubs' do

        # Serializes simple scalar properties
        it 'stubs RailsJsonEnums' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonEnums).to receive(:build)
          client.stub_responses(:json_enums, data: {
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
          output = client.json_enums({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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

    describe '#json_int_enums' do

      describe 'requests' do

        # Serializes intEnums as integers
        it 'RailsJsonIntEnums' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/JsonIntEnums')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "integer_enum1": 1,
                "integer_enum2": 2,
                "integer_enum3": 3,
                "integer_enum_list": [
                    1,
                    2,
                    3
                ],
                "integer_enum_set": [
                    1,
                    2
                ],
                "integer_enum_map": {
                    "abc": 1,
                    "def": 2
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_int_enums({
            integer_enum1: 1,
            integer_enum2: 2,
            integer_enum3: 3,
            integer_enum_list: [
              1,
              2,
              3
            ],
            integer_enum_set: [
              1,
              2
            ],
            integer_enum_map: {
              'abc' => 1,
              'def' => 2
            }
          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes intEnums as integers
        it 'RailsJsonIntEnums' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "integer_enum1": 1,
              "integer_enum2": 2,
              "integer_enum3": 3,
              "integer_enum_list": [
                  1,
                  2,
                  3
              ],
              "integer_enum_set": [
                  1,
                  2
              ],
              "integer_enum_map": {
                  "abc": 1,
                  "def": 2
              }
          }')
          response.body.rewind
          client.stub_responses(:json_int_enums, response)
          allow(Builders::JsonIntEnums).to receive(:build)
          output = client.json_int_enums({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            integer_enum1: 1,
            integer_enum2: 2,
            integer_enum3: 3,
            integer_enum_list: [
              1,
              2,
              3
            ],
            integer_enum_set: [
              1,
              2
            ],
            integer_enum_map: {
              'abc' => 1,
              'def' => 2
            }
          })
        end

      end

      describe 'stubs' do

        # Serializes intEnums as integers
        it 'stubs RailsJsonIntEnums' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonIntEnums).to receive(:build)
          client.stub_responses(:json_int_enums, data: {
            integer_enum1: 1,
            integer_enum2: 2,
            integer_enum3: 3,
            integer_enum_list: [
              1,
              2,
              3
            ],
            integer_enum_set: [
              1,
              2
            ],
            integer_enum_map: {
              'abc' => 1,
              'def' => 2
            }
          })
          output = client.json_int_enums({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            integer_enum1: 1,
            integer_enum2: 2,
            integer_enum3: 3,
            integer_enum_list: [
              1,
              2,
              3
            ],
            integer_enum_set: [
              1,
              2
            ],
            integer_enum_map: {
              'abc' => 1,
              'def' => 2
            }
          })
        end

      end

    end

    describe '#json_lists' do

      describe 'requests' do

        # Serializes JSON lists
        it 'RailsJsonLists' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/JsonLists')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "string_list": [
                    "foo",
                    "bar"
                ],
                "string_set": [
                    "foo",
                    "bar"
                ],
                "integer_list": [
                    1,
                    2
                ],
                "boolean_list": [
                    true,
                    false
                ],
                "timestamp_list": [
                    "2014-04-29T18:30:38Z",
                    "2014-04-29T18:30:38Z"
                ],
                "enum_list": [
                    "Foo",
                    "0"
                ],
                "int_enum_list": [
                    1,
                    2
                ],
                "nested_string_list": [
                    [
                        "foo",
                        "bar"
                    ],
                    [
                        "baz",
                        "qux"
                    ]
                ],
                "myStructureList": [
                    {
                        "value": "1",
                        "other": "2"
                    },
                    {
                        "value": "3",
                        "other": "4"
                    }
                ]
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_lists({
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
            ]
          }, **opts)
        end

        # Serializes empty JSON lists
        it 'RailsJsonListsEmpty' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/JsonLists')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "string_list": []
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_lists({
            string_list: [

            ]
          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes JSON lists
        it 'RailsJsonLists' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "string_list": [
                  "foo",
                  "bar"
              ],
              "string_set": [
                  "foo",
                  "bar"
              ],
              "integer_list": [
                  1,
                  2
              ],
              "boolean_list": [
                  true,
                  false
              ],
              "timestamp_list": [
                  "2014-04-29T18:30:38Z",
                  "2014-04-29T18:30:38Z"
              ],
              "enum_list": [
                  "Foo",
                  "0"
              ],
              "int_enum_list": [
                  1,
                  2
              ],
              "nested_string_list": [
                  [
                      "foo",
                      "bar"
                  ],
                  [
                      "baz",
                      "qux"
                  ]
              ],
              "myStructureList": [
                  {
                      "value": "1",
                      "other": "2"
                  },
                  {
                      "value": "3",
                      "other": "4"
                  }
              ]
          }')
          response.body.rewind
          client.stub_responses(:json_lists, response)
          allow(Builders::JsonLists).to receive(:build)
          output = client.json_lists({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
            ]
          })
        end

        # Serializes empty JSON lists
        it 'RailsJsonListsEmpty' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "string_list": []
          }')
          response.body.rewind
          client.stub_responses(:json_lists, response)
          allow(Builders::JsonLists).to receive(:build)
          output = client.json_lists({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            string_list: [

            ]
          })
        end

      end

      describe 'stubs' do

        # Serializes JSON lists
        it 'stubs RailsJsonLists' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonLists).to receive(:build)
          client.stub_responses(:json_lists, data: {
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
            ]
          })
          output = client.json_lists({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
            ]
          })
        end

        # Serializes empty JSON lists
        it 'stubs RailsJsonListsEmpty' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonLists).to receive(:build)
          client.stub_responses(:json_lists, data: {
            string_list: [

            ]
          })
          output = client.json_lists({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            string_list: [

            ]
          })
        end

      end

    end

    describe '#json_maps' do

      describe 'requests' do

        # Serializes JSON maps
        it 'RailsJsonMaps' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/JsonMaps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "dense_struct_map": {
                    "foo": {
                        "hi": "there"
                    },
                    "baz": {
                        "hi": "bye"
                    }
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_maps({
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
        it 'RailsJsonSerializesZeroValuesInMaps' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/JsonMaps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "dense_number_map": {
                    "x": 0
                },
                "dense_boolean_map": {
                    "x": false
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_maps({
            dense_number_map: {
              'x' => 0
            },
            dense_boolean_map: {
              'x' => false
            }
          }, **opts)
        end

        # A request that contains a dense map of sets.
        it 'RailsJsonSerializesDenseSetMap' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/JsonMaps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "dense_set_map": {
                    "x": [],
                    "y": ["a", "b"]
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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

      end

      describe 'responses' do

        # Deserializes JSON maps
        it 'RailsJsonMaps' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "dense_struct_map": {
                  "foo": {
                      "hi": "there"
                  },
                  "baz": {
                      "hi": "bye"
                  }
              }
          }')
          response.body.rewind
          client.stub_responses(:json_maps, response)
          allow(Builders::JsonMaps).to receive(:build)
          output = client.json_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
        it 'RailsJsonDeserializesZeroValuesInMaps' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "dense_number_map": {
                  "x": 0
              },
              "dense_boolean_map": {
                  "x": false
              }
          }')
          response.body.rewind
          client.stub_responses(:json_maps, response)
          allow(Builders::JsonMaps).to receive(:build)
          output = client.json_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            dense_number_map: {
              'x' => 0
            },
            dense_boolean_map: {
              'x' => false
            }
          })
        end

        # A response that contains a dense map of sets.
        it 'RailsJsonDeserializesDenseSetMap' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "dense_set_map": {
                  "x": [],
                  "y": ["a", "b"]
              }
          }')
          response.body.rewind
          client.stub_responses(:json_maps, response)
          allow(Builders::JsonMaps).to receive(:build)
          output = client.json_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
        it 'RailsJsonDeserializesDenseSetMapAndSkipsNull' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "dense_set_map": {
                  "x": [],
                  "y": ["a", "b"],
                  "z": null
              }
          }')
          response.body.rewind
          client.stub_responses(:json_maps, response)
          allow(Builders::JsonMaps).to receive(:build)
          output = client.json_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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

        # Deserializes JSON maps
        it 'stubs RailsJsonMaps' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonMaps).to receive(:build)
          client.stub_responses(:json_maps, data: {
            dense_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            }
          })
          output = client.json_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
        it 'stubs RailsJsonDeserializesZeroValuesInMaps' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonMaps).to receive(:build)
          client.stub_responses(:json_maps, data: {
            dense_number_map: {
              'x' => 0
            },
            dense_boolean_map: {
              'x' => false
            }
          })
          output = client.json_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            dense_number_map: {
              'x' => 0
            },
            dense_boolean_map: {
              'x' => false
            }
          })
        end

        # A response that contains a dense map of sets.
        it 'stubs RailsJsonDeserializesDenseSetMap' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonMaps).to receive(:build)
          client.stub_responses(:json_maps, data: {
            dense_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
          output = client.json_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
        it 'stubs RailsJsonDeserializesDenseSetMapAndSkipsNull' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonMaps).to receive(:build)
          client.stub_responses(:json_maps, data: {
            dense_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
          output = client.json_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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

    describe '#json_timestamps' do

      describe 'requests' do

        # Tests how normal timestamps are serialized
        it 'RailsJsonTimestamps' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/JsonTimestamps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "normal": 1398796238
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_timestamps({
            normal: Time.at(1398796238)
          }, **opts)
        end

        # Ensures that the timestampFormat of date-time works like normal timestamps
        it 'RailsJsonTimestampsWithDateTimeFormat' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/JsonTimestamps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "date_time": "2014-04-29T18:30:38Z"
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_timestamps({
            date_time: Time.at(1398796238)
          }, **opts)
        end

        # Ensures that the timestampFormat of date-time on the target shape works like normal timestamps
        it 'RailsJsonTimestampsWithDateTimeOnTargetFormat' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/JsonTimestamps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "date_time_on_target": "2014-04-29T18:30:38Z"
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_timestamps({
            date_time_on_target: Time.at(1398796238)
          }, **opts)
        end

        # Ensures that the timestampFormat of epoch-seconds works
        it 'RailsJsonTimestampsWithEpochSecondsFormat' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/JsonTimestamps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "epoch_seconds": 1398796238
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_timestamps({
            epoch_seconds: Time.at(1398796238)
          }, **opts)
        end

        # Ensures that the timestampFormat of epoch-seconds on the target shape works
        it 'RailsJsonTimestampsWithEpochSecondsOnTargetFormat' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/JsonTimestamps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "epoch_seconds_on_target": 1398796238
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_timestamps({
            epoch_seconds_on_target: Time.at(1398796238)
          }, **opts)
        end

        # Ensures that the timestampFormat of http-date works
        it 'RailsJsonTimestampsWithHttpDateFormat' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/JsonTimestamps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "http_date": "Tue, 29 Apr 2014 18:30:38 GMT"
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_timestamps({
            http_date: Time.at(1398796238)
          }, **opts)
        end

        # Ensures that the timestampFormat of http-date on the target shape works
        it 'RailsJsonTimestampsWithHttpDateOnTargetFormat' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/JsonTimestamps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "http_date_on_target": "Tue, 29 Apr 2014 18:30:38 GMT"
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_timestamps({
            http_date_on_target: Time.at(1398796238)
          }, **opts)
        end

      end

      describe 'responses' do

        # Tests how normal timestamps are serialized
        it 'RailsJsonTimestamps' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "normal": 1398796238
          }')
          response.body.rewind
          client.stub_responses(:json_timestamps, response)
          allow(Builders::JsonTimestamps).to receive(:build)
          output = client.json_timestamps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            normal: Time.at(1398796238)
          })
        end

        # Ensures that the timestampFormat of date-time works like normal timestamps
        it 'RailsJsonTimestampsWithDateTimeFormat' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "date_time": "2014-04-29T18:30:38Z"
          }')
          response.body.rewind
          client.stub_responses(:json_timestamps, response)
          allow(Builders::JsonTimestamps).to receive(:build)
          output = client.json_timestamps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            date_time: Time.at(1398796238)
          })
        end

        # Ensures that the timestampFormat of date-time on the target shape works like normal timestamps
        it 'RailsJsonTimestampsWithDateTimeOnTargetFormat' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "date_time_on_target": "2014-04-29T18:30:38Z"
          }')
          response.body.rewind
          client.stub_responses(:json_timestamps, response)
          allow(Builders::JsonTimestamps).to receive(:build)
          output = client.json_timestamps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            date_time_on_target: Time.at(1398796238)
          })
        end

        # Ensures that the timestampFormat of epoch-seconds works
        it 'RailsJsonTimestampsWithEpochSecondsFormat' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "epoch_seconds": 1398796238
          }')
          response.body.rewind
          client.stub_responses(:json_timestamps, response)
          allow(Builders::JsonTimestamps).to receive(:build)
          output = client.json_timestamps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            epoch_seconds: Time.at(1398796238)
          })
        end

        # Ensures that the timestampFormat of epoch-seconds on the target shape works
        it 'RailsJsonTimestampsWithEpochSecondsOnTargetFormat' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "epoch_seconds_on_target": 1398796238
          }')
          response.body.rewind
          client.stub_responses(:json_timestamps, response)
          allow(Builders::JsonTimestamps).to receive(:build)
          output = client.json_timestamps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            epoch_seconds_on_target: Time.at(1398796238)
          })
        end

        # Ensures that the timestampFormat of http-date works
        it 'RailsJsonTimestampsWithHttpDateFormat' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "http_date": "Tue, 29 Apr 2014 18:30:38 GMT"
          }')
          response.body.rewind
          client.stub_responses(:json_timestamps, response)
          allow(Builders::JsonTimestamps).to receive(:build)
          output = client.json_timestamps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            http_date: Time.at(1398796238)
          })
        end

        # Ensures that the timestampFormat of http-date on the target shape works
        it 'RailsJsonTimestampsWithHttpDateOnTargetFormat' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "http_date_on_target": "Tue, 29 Apr 2014 18:30:38 GMT"
          }')
          response.body.rewind
          client.stub_responses(:json_timestamps, response)
          allow(Builders::JsonTimestamps).to receive(:build)
          output = client.json_timestamps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            http_date_on_target: Time.at(1398796238)
          })
        end

      end

      describe 'stubs' do

        # Tests how normal timestamps are serialized
        it 'stubs RailsJsonTimestamps' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonTimestamps).to receive(:build)
          client.stub_responses(:json_timestamps, data: {
            normal: Time.at(1398796238)
          })
          output = client.json_timestamps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            normal: Time.at(1398796238)
          })
        end

        # Ensures that the timestampFormat of date-time works like normal timestamps
        it 'stubs RailsJsonTimestampsWithDateTimeFormat' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonTimestamps).to receive(:build)
          client.stub_responses(:json_timestamps, data: {
            date_time: Time.at(1398796238)
          })
          output = client.json_timestamps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            date_time: Time.at(1398796238)
          })
        end

        # Ensures that the timestampFormat of date-time on the target shape works like normal timestamps
        it 'stubs RailsJsonTimestampsWithDateTimeOnTargetFormat' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonTimestamps).to receive(:build)
          client.stub_responses(:json_timestamps, data: {
            date_time_on_target: Time.at(1398796238)
          })
          output = client.json_timestamps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            date_time_on_target: Time.at(1398796238)
          })
        end

        # Ensures that the timestampFormat of epoch-seconds works
        it 'stubs RailsJsonTimestampsWithEpochSecondsFormat' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonTimestamps).to receive(:build)
          client.stub_responses(:json_timestamps, data: {
            epoch_seconds: Time.at(1398796238)
          })
          output = client.json_timestamps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            epoch_seconds: Time.at(1398796238)
          })
        end

        # Ensures that the timestampFormat of epoch-seconds on the target shape works
        it 'stubs RailsJsonTimestampsWithEpochSecondsOnTargetFormat' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonTimestamps).to receive(:build)
          client.stub_responses(:json_timestamps, data: {
            epoch_seconds_on_target: Time.at(1398796238)
          })
          output = client.json_timestamps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            epoch_seconds_on_target: Time.at(1398796238)
          })
        end

        # Ensures that the timestampFormat of http-date works
        it 'stubs RailsJsonTimestampsWithHttpDateFormat' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonTimestamps).to receive(:build)
          client.stub_responses(:json_timestamps, data: {
            http_date: Time.at(1398796238)
          })
          output = client.json_timestamps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            http_date: Time.at(1398796238)
          })
        end

        # Ensures that the timestampFormat of http-date on the target shape works
        it 'stubs RailsJsonTimestampsWithHttpDateOnTargetFormat' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonTimestamps).to receive(:build)
          client.stub_responses(:json_timestamps, data: {
            http_date_on_target: Time.at(1398796238)
          })
          output = client.json_timestamps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            http_date_on_target: Time.at(1398796238)
          })
        end

      end

    end

    describe '#json_unions' do

      describe 'requests' do

        # Serializes a string union value
        it 'RailsJsonSerializeStringUnionValue' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/JsonUnions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "string_value": "foo"
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_unions({
            contents: {
              string_value: "foo"
            }
          }, **opts)
        end

        # Serializes a boolean union value
        it 'RailsJsonSerializeBooleanUnionValue' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/JsonUnions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "boolean_value": true
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_unions({
            contents: {
              boolean_value: true
            }
          }, **opts)
        end

        # Serializes a number union value
        it 'RailsJsonSerializeNumberUnionValue' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/JsonUnions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "number_value": 1
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_unions({
            contents: {
              number_value: 1
            }
          }, **opts)
        end

        # Serializes a blob union value
        it 'RailsJsonSerializeBlobUnionValue' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/JsonUnions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "blob_value": "Zm9v"
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_unions({
            contents: {
              blob_value: 'foo'
            }
          }, **opts)
        end

        # Serializes a timestamp union value
        it 'RailsJsonSerializeTimestampUnionValue' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/JsonUnions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "timestamp_value": 1398796238
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_unions({
            contents: {
              timestamp_value: Time.at(1398796238)
            }
          }, **opts)
        end

        # Serializes an enum union value
        it 'RailsJsonSerializeEnumUnionValue' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/JsonUnions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "enum_value": "Foo"
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_unions({
            contents: {
              enum_value: "Foo"
            }
          }, **opts)
        end

        # Serializes a list union value
        it 'RailsJsonSerializeListUnionValue' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/JsonUnions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "list_value": ["foo", "bar"]
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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
        it 'RailsJsonSerializeMapUnionValue' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/JsonUnions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "map_value": {
                        "foo": "bar",
                        "spam": "eggs"
                    }
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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
        it 'RailsJsonSerializeStructureUnionValue' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/JsonUnions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "structure_value": {
                        "hi": "hello"
                    }
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_unions({
            contents: {
              structure_value: {
                hi: "hello"
              }
            }
          }, **opts)
        end

        # Serializes a renamed structure union value
        it 'RailsJsonSerializeRenamedStructureUnionValue' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/JsonUnions')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "contents": {
                    "renamed_structure_value": {
                        "salutation": "hello!"
                    }
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.json_unions({
            contents: {
              renamed_structure_value: {
                salutation: "hello!"
              }
            }
          }, **opts)
        end

      end

      describe 'responses' do

        # Deserializes a string union value
        it 'RailsJsonDeserializeStringUnionValue' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "contents": {
                  "string_value": "foo"
              }
          }')
          response.body.rewind
          client.stub_responses(:json_unions, response)
          allow(Builders::JsonUnions).to receive(:build)
          output = client.json_unions({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              string_value: "foo"
            }
          })
        end

        # Deserializes a boolean union value
        it 'RailsJsonDeserializeBooleanUnionValue' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "contents": {
                  "boolean_value": true
              }
          }')
          response.body.rewind
          client.stub_responses(:json_unions, response)
          allow(Builders::JsonUnions).to receive(:build)
          output = client.json_unions({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              boolean_value: true
            }
          })
        end

        # Deserializes a number union value
        it 'RailsJsonDeserializeNumberUnionValue' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "contents": {
                  "number_value": 1
              }
          }')
          response.body.rewind
          client.stub_responses(:json_unions, response)
          allow(Builders::JsonUnions).to receive(:build)
          output = client.json_unions({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              number_value: 1
            }
          })
        end

        # Deserializes a blob union value
        it 'RailsJsonDeserializeBlobUnionValue' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "contents": {
                  "blob_value": "Zm9v"
              }
          }')
          response.body.rewind
          client.stub_responses(:json_unions, response)
          allow(Builders::JsonUnions).to receive(:build)
          output = client.json_unions({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              blob_value: 'foo'
            }
          })
        end

        # Deserializes a timestamp union value
        it 'RailsJsonDeserializeTimestampUnionValue' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "contents": {
                  "timestamp_value": 1398796238
              }
          }')
          response.body.rewind
          client.stub_responses(:json_unions, response)
          allow(Builders::JsonUnions).to receive(:build)
          output = client.json_unions({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              timestamp_value: Time.at(1398796238)
            }
          })
        end

        # Deserializes an enum union value
        it 'RailsJsonDeserializeEnumUnionValue' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "contents": {
                  "enum_value": "Foo"
              }
          }')
          response.body.rewind
          client.stub_responses(:json_unions, response)
          allow(Builders::JsonUnions).to receive(:build)
          output = client.json_unions({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              enum_value: "Foo"
            }
          })
        end

        # Deserializes a list union value
        it 'RailsJsonDeserializeListUnionValue' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "contents": {
                  "list_value": ["foo", "bar"]
              }
          }')
          response.body.rewind
          client.stub_responses(:json_unions, response)
          allow(Builders::JsonUnions).to receive(:build)
          output = client.json_unions({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              list_value: [
                "foo",
                "bar"
              ]
            }
          })
        end

        # Deserializes a map union value
        it 'RailsJsonDeserializeMapUnionValue' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "contents": {
                  "map_value": {
                      "foo": "bar",
                      "spam": "eggs"
                  }
              }
          }')
          response.body.rewind
          client.stub_responses(:json_unions, response)
          allow(Builders::JsonUnions).to receive(:build)
          output = client.json_unions({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              map_value: {
                'foo' => "bar",
                'spam' => "eggs"
              }
            }
          })
        end

        # Deserializes a structure union value
        it 'RailsJsonDeserializeStructureUnionValue' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "contents": {
                  "structure_value": {
                      "hi": "hello"
                  }
              }
          }')
          response.body.rewind
          client.stub_responses(:json_unions, response)
          allow(Builders::JsonUnions).to receive(:build)
          output = client.json_unions({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              structure_value: {
                hi: "hello"
              }
            }
          })
        end

      end

      describe 'stubs' do

        # Deserializes a string union value
        it 'stubs RailsJsonDeserializeStringUnionValue' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonUnions).to receive(:build)
          client.stub_responses(:json_unions, data: {
            contents: {
              string_value: "foo"
            }
          })
          output = client.json_unions({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              string_value: "foo"
            }
          })
        end

        # Deserializes a boolean union value
        it 'stubs RailsJsonDeserializeBooleanUnionValue' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonUnions).to receive(:build)
          client.stub_responses(:json_unions, data: {
            contents: {
              boolean_value: true
            }
          })
          output = client.json_unions({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              boolean_value: true
            }
          })
        end

        # Deserializes a number union value
        it 'stubs RailsJsonDeserializeNumberUnionValue' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonUnions).to receive(:build)
          client.stub_responses(:json_unions, data: {
            contents: {
              number_value: 1
            }
          })
          output = client.json_unions({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              number_value: 1
            }
          })
        end

        # Deserializes a blob union value
        it 'stubs RailsJsonDeserializeBlobUnionValue' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonUnions).to receive(:build)
          client.stub_responses(:json_unions, data: {
            contents: {
              blob_value: 'foo'
            }
          })
          output = client.json_unions({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              blob_value: 'foo'
            }
          })
        end

        # Deserializes a timestamp union value
        it 'stubs RailsJsonDeserializeTimestampUnionValue' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonUnions).to receive(:build)
          client.stub_responses(:json_unions, data: {
            contents: {
              timestamp_value: Time.at(1398796238)
            }
          })
          output = client.json_unions({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              timestamp_value: Time.at(1398796238)
            }
          })
        end

        # Deserializes an enum union value
        it 'stubs RailsJsonDeserializeEnumUnionValue' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonUnions).to receive(:build)
          client.stub_responses(:json_unions, data: {
            contents: {
              enum_value: "Foo"
            }
          })
          output = client.json_unions({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              enum_value: "Foo"
            }
          })
        end

        # Deserializes a list union value
        it 'stubs RailsJsonDeserializeListUnionValue' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonUnions).to receive(:build)
          client.stub_responses(:json_unions, data: {
            contents: {
              list_value: [
                "foo",
                "bar"
              ]
            }
          })
          output = client.json_unions({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              list_value: [
                "foo",
                "bar"
              ]
            }
          })
        end

        # Deserializes a map union value
        it 'stubs RailsJsonDeserializeMapUnionValue' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonUnions).to receive(:build)
          client.stub_responses(:json_unions, data: {
            contents: {
              map_value: {
                'foo' => "bar",
                'spam' => "eggs"
              }
            }
          })
          output = client.json_unions({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              map_value: {
                'foo' => "bar",
                'spam' => "eggs"
              }
            }
          })
        end

        # Deserializes a structure union value
        it 'stubs RailsJsonDeserializeStructureUnionValue' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::JsonUnions).to receive(:build)
          client.stub_responses(:json_unions, data: {
            contents: {
              structure_value: {
                hi: "hello"
              }
            }
          })
          output = client.json_unions({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            contents: {
              structure_value: {
                hi: "hello"
              }
            }
          })
        end

      end

    end

    describe '#media_type_header' do

      describe 'requests' do

        # Headers that target strings with a mediaType are base64 encoded
        it 'RailsJsonMediaTypeHeaderInputBase64' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/MediaTypeHeader')
            { 'X-Json' => 'dHJ1ZQ==' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.media_type_header({
            json: "true"
          }, **opts)
        end

      end

      describe 'responses' do

        # Headers that target strings with a mediaType are base64 encoded
        it 'RailsJsonMediaTypeHeaderOutputBase64' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-Json'] = 'dHJ1ZQ=='
          client.stub_responses(:media_type_header, response)
          allow(Builders::MediaTypeHeader).to receive(:build)
          output = client.media_type_header({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            json: "true"
          })
        end

      end

      describe 'stubs' do

        # Headers that target strings with a mediaType are base64 encoded
        it 'stubs RailsJsonMediaTypeHeaderOutputBase64' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::MediaTypeHeader).to receive(:build)
          client.stub_responses(:media_type_header, data: {
            json: "true"
          })
          output = client.media_type_header({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            json: "true"
          })
        end

      end

    end

    describe '#no_input_and_no_output' do

      describe 'requests' do

        # No input serializes no payload. When clients do not need to
        # serialize any data in the payload, they should omit a payload
        # altogether.
        it 'RailsJsonNoInputAndNoOutput' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/NoInputAndNoOutput')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.no_input_and_no_output({

          }, **opts)
        end

      end

      describe 'responses' do

        # When an operation does not define output, the service will respond
        # with an empty payload, and may optionally include the content-type
        # header.
        it 'RailsJsonNoInputAndNoOutput' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.body.write('')
          response.body.rewind
          client.stub_responses(:no_input_and_no_output, response)
          allow(Builders::NoInputAndNoOutput).to receive(:build)
          output = client.no_input_and_no_output({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

      end

      describe 'stubs' do

        # When an operation does not define output, the service will respond
        # with an empty payload, and may optionally include the content-type
        # header.
        it 'stubs RailsJsonNoInputAndNoOutput' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::NoInputAndNoOutput).to receive(:build)
          client.stub_responses(:no_input_and_no_output, data: {

          })
          output = client.no_input_and_no_output({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

      end

    end

    describe '#no_input_and_output' do

      describe 'requests' do

        # No input serializes no payload. When clients do not need to
        # serialize any data in the payload, they should omit a payload
        # altogether.
        it 'RailsJsonNoInputAndOutput' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/NoInputAndOutputOutput')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.no_input_and_output({

          }, **opts)
        end

      end

      describe 'responses' do

        # Operations that define output and do not bind anything to
        # the payload return a JSON object in the response.
        it 'RailsJsonNoInputAndOutputWithJson' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{}')
          response.body.rewind
          client.stub_responses(:no_input_and_output, response)
          allow(Builders::NoInputAndOutput).to receive(:build)
          output = client.no_input_and_output({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

        # This test is similar to RailsJsonNoInputAndOutputWithJson, but
        # it ensures that clients can gracefully handle responses that
        # omit a JSON payload.
        it 'RailsJsonNoInputAndOutputNoPayload' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.body.write('')
          response.body.rewind
          client.stub_responses(:no_input_and_output, response)
          allow(Builders::NoInputAndOutput).to receive(:build)
          output = client.no_input_and_output({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

      end

      describe 'stubs' do

        # Operations that define output and do not bind anything to
        # the payload return a JSON object in the response.
        it 'stubs RailsJsonNoInputAndOutputWithJson' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::NoInputAndOutput).to receive(:build)
          client.stub_responses(:no_input_and_output, data: {

          })
          output = client.no_input_and_output({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

        # This test is similar to RailsJsonNoInputAndOutputWithJson, but
        # it ensures that clients can gracefully handle responses that
        # omit a JSON payload.
        it 'stubs RailsJsonNoInputAndOutputNoPayload' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::NoInputAndOutput).to receive(:build)
          client.stub_responses(:no_input_and_output, data: {

          })
          output = client.no_input_and_output({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

      end

    end

    describe '#null_and_empty_headers_client' do

      describe 'requests' do

        # Do not send null values, empty strings, or empty lists over the wire in headers
        it 'RailsJsonNullAndEmptyHeaders' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/NullAndEmptyHeadersClient')
            ['X-A', 'X-B', 'X-C'].each { |k| expect(request.headers.key?(k)).to be(false) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.null_and_empty_headers_client({
            a: nil,
            b: "",
            c: [

            ]
          }, **opts)
        end

      end

    end

    describe '#null_and_empty_headers_server' do

      describe 'responses' do

      end

      describe 'stubs' do

      end

    end

    describe '#omits_null_serializes_empty_string' do

      describe 'requests' do

        # Omits null query values
        it 'RailsJsonOmitsNullQuery' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/OmitsNullSerializesEmptyString')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.omits_null_serializes_empty_string({
            null_value: nil
          }, **opts)
        end

        # Serializes empty query strings
        it 'RailsJsonSerializesEmptyQueryValue' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/OmitsNullSerializesEmptyString')
            expected_query = ::CGI.parse(['Empty='].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.omits_null_serializes_empty_string({
            empty_string: ""
          }, **opts)
        end

      end

    end

    describe '#omits_serializing_empty_lists' do

      describe 'requests' do

        # Supports omitting empty lists.
        it 'RailsJsonOmitsEmptyListQueryValues' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/OmitsSerializingEmptyLists')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.omits_serializing_empty_lists({
            query_string_list: [

            ],
            query_integer_list: [

            ],
            query_double_list: [

            ],
            query_boolean_list: [

            ],
            query_timestamp_list: [

            ],
            query_enum_list: [

            ],
            query_integer_enum_list: [

            ]
          }, **opts)
        end

      end

    end

    describe '#operation_with_defaults' do

      describe 'requests' do

        # Client populates default values in input.
        it 'RailsJsonClientPopulatesDefaultValuesInInput' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/OperationWithDefaults')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "defaults": {
                    "default_string": "hi",
                    "default_boolean": true,
                    "default_list": [],
                    "default_document_map": {},
                    "default_document_string": "hi",
                    "default_document_boolean": true,
                    "default_document_list": [],
                    "default_timestamp": "1970-01-01T00:00:00Z",
                    "default_blob": "YWJj",
                    "default_byte": 1,
                    "default_short": 1,
                    "default_integer": 10,
                    "default_long": 100,
                    "default_float": 1.0,
                    "default_double": 1.0,
                    "default_map": {},
                    "default_enum": "FOO",
                    "default_int_enum": 1,
                    "empty_string": "",
                    "false_boolean": false,
                    "empty_blob": "",
                    "zero_byte": 0,
                    "zero_short": 0,
                    "zero_integer": 0,
                    "zero_long": 0,
                    "zero_float": 0.0,
                    "zero_double": 0.0
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.operation_with_defaults({
            defaults: {

            }
          }, **opts)
        end

        # Client skips top level default values in input.
        it 'RailsJsonClientSkipsTopLevelDefaultValuesInInput' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/OperationWithDefaults')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.operation_with_defaults({

          }, **opts)
        end

        # Client uses explicitly provided member values over defaults
        it 'RailsJsonClientUsesExplicitlyProvidedMemberValuesOverDefaults' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/OperationWithDefaults')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "defaults": {
                    "default_string": "bye",
                    "default_boolean": true,
                    "default_list": ["a"],
                    "default_document_map": {"name": "Jack"},
                    "default_document_string": "bye",
                    "default_document_boolean": true,
                    "default_document_list": ["b"],
                    "default_null_document": "notNull",
                    "default_timestamp": "1970-01-01T00:00:01Z",
                    "default_blob": "aGk=",
                    "default_byte": 2,
                    "default_short": 2,
                    "default_integer": 20,
                    "default_long": 200,
                    "default_float": 2.0,
                    "default_double": 2.0,
                    "default_map": {"name": "Jack"},
                    "default_enum": "BAR",
                    "default_int_enum": 2,
                    "empty_string": "foo",
                    "false_boolean": true,
                    "empty_blob": "aGk=",
                    "zero_byte": 1,
                    "zero_short": 1,
                    "zero_integer": 1,
                    "zero_long": 1,
                    "zero_float": 1.0,
                    "zero_double": 1.0
                }
            }'))
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
              default_document_map: {'name' => 'Jack'},
              default_document_string: 'bye',
              default_document_boolean: true,
              default_document_list: ['b'],
              default_null_document: 'notNull',
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
        it 'RailsJsonClientUsesExplicitlyProvidedValuesInTopLevel' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/OperationWithDefaults')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "top_level_default": "hi",
                "other_top_level_default": 0
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.operation_with_defaults({
            top_level_default: "hi",
            other_top_level_default: 0
          }, **opts)
        end

        # Typically, non top-level members would have defaults filled in, but if they have the clientOptional trait, the defaults should be ignored.
        it 'RailsJsonClientIgnoresNonTopLevelDefaultsOnMembersWithClientOptional' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/OperationWithDefaults')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "client_optional_defaults": {}
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.operation_with_defaults({
            client_optional_defaults: {

            }
          }, **opts)
        end

      end

      describe 'responses' do

        # Client populates default values when missing in response.
        it 'RailsJsonClientPopulatesDefaultsValuesWhenMissingInResponse' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{}')
          response.body.rewind
          client.stub_responses(:operation_with_defaults, response)
          allow(Builders::OperationWithDefaults).to receive(:build)
          output = client.operation_with_defaults({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            default_string: "hi",
            default_boolean: true,
            default_list: [

            ],
            default_document_map: {},
            default_document_string: 'hi',
            default_document_boolean: true,
            default_document_list: [],
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
        it 'RailsJsonClientIgnoresDefaultValuesIfMemberValuesArePresentInResponse' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "default_string": "bye",
              "default_boolean": false,
              "default_list": ["a"],
              "default_document_map": {"name": "Jack"},
              "default_document_string": "bye",
              "default_document_boolean": false,
              "default_document_list": ["b"],
              "default_null_document": "notNull",
              "default_timestamp": "1970-01-01T00:00:01Z",
              "default_blob": "aGk=",
              "default_byte": 2,
              "default_short": 2,
              "default_integer": 20,
              "default_long": 200,
              "default_float": 2.0,
              "default_double": 2.0,
              "default_map": {"name": "Jack"},
              "default_enum": "BAR",
              "default_int_enum": 2,
              "empty_string": "foo",
              "false_boolean": true,
              "empty_blob": "aGk=",
              "zero_byte": 1,
              "zero_short": 1,
              "zero_integer": 1,
              "zero_long": 1,
              "zero_float": 1.0,
              "zero_double": 1.0
          }')
          response.body.rewind
          client.stub_responses(:operation_with_defaults, response)
          allow(Builders::OperationWithDefaults).to receive(:build)
          output = client.operation_with_defaults({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            default_string: "bye",
            default_boolean: false,
            default_list: [
              "a"
            ],
            default_document_map: {'name' => 'Jack'},
            default_document_string: 'bye',
            default_document_boolean: false,
            default_document_list: ['b'],
            default_null_document: 'notNull',
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
          })
        end

      end

      describe 'stubs' do

        # Client populates default values when missing in response.
        it 'stubs RailsJsonClientPopulatesDefaultsValuesWhenMissingInResponse' do
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
            default_document_map: {},
            default_document_string: 'hi',
            default_document_boolean: true,
            default_document_list: [],
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
          expect(output.data.to_h).to eq({
            default_string: "hi",
            default_boolean: true,
            default_list: [

            ],
            default_document_map: {},
            default_document_string: 'hi',
            default_document_boolean: true,
            default_document_list: [],
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
        it 'stubs RailsJsonClientIgnoresDefaultValuesIfMemberValuesArePresentInResponse' do
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
            default_document_map: {'name' => 'Jack'},
            default_document_string: 'bye',
            default_document_boolean: false,
            default_document_list: ['b'],
            default_null_document: 'notNull',
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
          })
          output = client.operation_with_defaults({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            default_string: "bye",
            default_boolean: false,
            default_list: [
              "a"
            ],
            default_document_map: {'name' => 'Jack'},
            default_document_string: 'bye',
            default_document_boolean: false,
            default_document_list: ['b'],
            default_null_document: 'notNull',
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
          })
        end

      end

    end

    describe '#post_player_action' do

      describe 'requests' do

        # Unit types in unions are serialized like normal structures in requests.
        it 'RailsJsonInputUnionWithUnitMember' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/PostPlayerAction')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "action": {
                    "quit": {}
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.post_player_action({
            action: {
              quit: {

              }
            }
          }, **opts)
        end

      end

      describe 'responses' do

        # Unit types in unions are serialized like normal structures in responses.
        it 'RailsJsonOutputUnionWithUnitMember' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "action": {
                  "quit": {}
              }
          }')
          response.body.rewind
          client.stub_responses(:post_player_action, response)
          allow(Builders::PostPlayerAction).to receive(:build)
          output = client.post_player_action({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            action: {
              quit: {

              }
            }
          })
        end

      end

      describe 'stubs' do

        # Unit types in unions are serialized like normal structures in responses.
        it 'stubs RailsJsonOutputUnionWithUnitMember' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::PostPlayerAction).to receive(:build)
          client.stub_responses(:post_player_action, data: {
            action: {
              quit: {

              }
            }
          })
          output = client.post_player_action({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            action: {
              quit: {

              }
            }
          })
        end

      end

    end

    describe '#post_union_with_json_name' do

      describe 'requests' do

        # Tests that jsonName works with union members.
        it 'RailsJsonPostUnionWithJsonNameRequest1' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/PostUnionWithJsonName')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "value": {
                    "FOO": "hi"
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.post_union_with_json_name({
            value: {
              foo: "hi"
            }
          }, **opts)
        end

        # Tests that jsonName works with union members.
        it 'RailsJsonPostUnionWithJsonNameRequest2' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/PostUnionWithJsonName')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "value": {
                    "_baz": "hi"
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.post_union_with_json_name({
            value: {
              baz: "hi"
            }
          }, **opts)
        end

        # Tests that jsonName works with union members.
        it 'RailsJsonPostUnionWithJsonNameRequest3' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/PostUnionWithJsonName')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "value": {
                    "bar": "hi"
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.post_union_with_json_name({
            value: {
              bar: "hi"
            }
          }, **opts)
        end

      end

      describe 'responses' do

        # Tests that jsonName works with union members.
        it 'RailsJsonPostUnionWithJsonNameResponse1' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "value": {
                  "FOO": "hi"
              }
          }')
          response.body.rewind
          client.stub_responses(:post_union_with_json_name, response)
          allow(Builders::PostUnionWithJsonName).to receive(:build)
          output = client.post_union_with_json_name({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            value: {
              foo: "hi"
            }
          })
        end

        # Tests that jsonName works with union members.
        it 'RailsJsonPostUnionWithJsonNameResponse2' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "value": {
                  "_baz": "hi"
              }
          }')
          response.body.rewind
          client.stub_responses(:post_union_with_json_name, response)
          allow(Builders::PostUnionWithJsonName).to receive(:build)
          output = client.post_union_with_json_name({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            value: {
              baz: "hi"
            }
          })
        end

        # Tests that jsonName works with union members.
        it 'RailsJsonPostUnionWithJsonNameResponse3' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "value": {
                  "bar": "hi"
              }
          }')
          response.body.rewind
          client.stub_responses(:post_union_with_json_name, response)
          allow(Builders::PostUnionWithJsonName).to receive(:build)
          output = client.post_union_with_json_name({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            value: {
              bar: "hi"
            }
          })
        end

      end

      describe 'stubs' do

        # Tests that jsonName works with union members.
        it 'stubs RailsJsonPostUnionWithJsonNameResponse1' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::PostUnionWithJsonName).to receive(:build)
          client.stub_responses(:post_union_with_json_name, data: {
            value: {
              foo: "hi"
            }
          })
          output = client.post_union_with_json_name({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            value: {
              foo: "hi"
            }
          })
        end

        # Tests that jsonName works with union members.
        it 'stubs RailsJsonPostUnionWithJsonNameResponse2' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::PostUnionWithJsonName).to receive(:build)
          client.stub_responses(:post_union_with_json_name, data: {
            value: {
              baz: "hi"
            }
          })
          output = client.post_union_with_json_name({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            value: {
              baz: "hi"
            }
          })
        end

        # Tests that jsonName works with union members.
        it 'stubs RailsJsonPostUnionWithJsonNameResponse3' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::PostUnionWithJsonName).to receive(:build)
          client.stub_responses(:post_union_with_json_name, data: {
            value: {
              bar: "hi"
            }
          })
          output = client.post_union_with_json_name({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            value: {
              bar: "hi"
            }
          })
        end

      end

    end

    describe '#put_with_content_encoding' do

      describe 'requests' do

        # Compression algorithm encoding is appended to the Content-Encoding header.
        it 'RailsJsonSDKAppliedContentEncoding_railsJson' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/requestcompression/putcontentwithencoding')
            { 'Content-Encoding' => 'gzip' }.each { |k, v| expect(request.headers[k]).to eq(v) }
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.put_with_content_encoding({
            data: "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\n"
          }, **opts)
        end

        # Compression algorithm encoding is appended to the Content-Encoding header, and the
        # user-provided content-encoding is in the Content-Encoding header before the
        # request compression encoding from the HTTP binding.
        #
        it 'RailsJsonSDKAppendedGzipAfterProvidedEncoding_railsJson' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/requestcompression/putcontentwithencoding')
            { 'Content-Encoding' => 'custom, gzip' }.each { |k, v| expect(request.headers[k]).to eq(v) }
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.put_with_content_encoding({
            encoding: "custom",
            data: "RjCEL3kBwqPivZUXGiyA5JCujtWgJAkKRlnTEsNYfBRGOS0f7LT6R3bCSOXeJ4auSHzQ4BEZZTklUyj5\n1HEojihShQC2jkQJrNdGOZNSW49yRO0XbnGmeczUHbZqZRelLFKW4xjru9uTuB8lFCtwoGgciFsgqTF8\n5HYcoqINTRxuAwGuRUMoNO473QT0BtCQoKUkAyVaypG0hBZdGNoJhunBfW0d3HWTYlzz9pXElyZhq3C1\n2PDB17GEoOYXmTxDecysmPOdo5z6T0HFhujfeJFIQQ8dirmXcG4F3v0bZdf6AZ3jsiVh6RnEXIPxPbOi\ngIXDWTMUr4Pg3f2LdYCM01eAb2qTdgsEN0MUDhEIfn68I2tnWvcozyUFpg1ez6pyWP8ssWVfFrckREIM\nMb0cTUVqSVSM8bnFiF9SoXM6ZoGMKfX1mT708OYk7SqZ1JlCTkecDJDoR5ED2q2MWKUGR6jjnEV0GtD8\nWJO6AcF0DptY9Hk16Bav3z6c5FeBvrGDrxTFVgRUk8SychzjrcqJ4qskwN8rL3zslC0oqobQRnLFOvwJ\nprSzBIwdH2yAuxokXAdVRa1u9NGNRvfWJfKkwbbVz8yV76RUF9KNhAUmwyYDrLnxNj8ROl8B7dv8Gans\n7Bit52wcdiJyjBW1pAodB7zqqVwtBx5RaSpF7kEMXexYXp9N0J1jlXzdeg5Wgg4pO7TJNr2joiPVAiFf\nefwMMCNBkYx2z7cRxVxCJZMXXzxSKMGgdTN24bJ5UgE0TxyV52RC0wGWG49S1x5jGrvmxKCIgYPs0w3Z\n0I3XcdB0WEj4x4xRztB9Cx2Mc4qFYQdzS9kOioAgNBti1rBySZ8lFZM2zqxvBsJTTJsmcKPr1crqiXjM\noVWdM4ObOO6QA7Pu4c1hT68CrTmbcecjFcxHkgsqdixnFtN6keMGL9Z2YMjZOjYYzbUEwLJqUVWalkIB\nBkgBRqZpzxx5nB5t0qDH35KjsfKM5cinQaFoRq9y9Z82xdCoKZOsUbxZkk1kVmy1jPDCBhkhixkc5PKS\nFoSKTbeK7kuCEZCtR9OfF2k2MqbygGFsFu2sgb1Zn2YdDbaRwRGeaLhswta09UNSMUo8aTixgoYVHxwy\nvraLB6olPSPegeLOnmBeWyKmEfPdbpdGm4ev4vA2AUFuLIeFz0LkCSN0NgQMrr8ALEm1UNpJLReg1ZAX\nzZh7gtQTZUaBVdMJokaJpLk6FPxSA6zkwB5TegSqhrFIsmvpY3VNWmTUq7H0iADdh3dRQ8Is97bTsbwu\nvAEOjh4FQ9wPSFzEtcSJeYQft5GfWYPisDImjjvHVFshFFkNy2nN18pJmhVPoJc456tgbdfEIdGhIADC\n6UPcSSzE1FxlPpILqZrp3i4NvvKoiOa4a8tnALd2XRHHmsvALn2Wmfu07b86gZlu4yOyuUFNoWI6tFvd\nbHnqSJYNQlFESv13gJw609DBzNnrIgBGYBAcDRrIGAnflRKwVDUnDFrUQmE8xNG6jRlyb1p2Y2RrfBtG\ncKqhuGNiT2DfxpY89ektZ98waPhJrFEPJToNH8EADzBorh3T0h4YP1IeLmaI7SOxeuVrk1kjRqMK0rUB\nlUJgJNtCE35jCyoHMwPQlyi78ZaVv8COVQ24zcGpw0MTy6JUsDzAC3jLNY6xCb40SZV9XzG7nWvXA5Ej\nYC1gTXxF4AtFexIdDZ4RJbtYMyXt8LsEJerwwpkfqvDwsiFuqYC6vIn9RoZO5kI0F35XtUITDQYKZ4eq\nWBV0itxTyyR5Rp6g30pZEmEqOusDaIh96CEmHpOBYAQZ7u1QTfzRdysIGMpzbx5gj9Dxm2PO1glWzY7P\nlVqQiBlXSGDOkBkrB6SkiAxknt9zsPdTTsf3r3nid4hdiPrZmGWNgjOO1khSxZSzBdltrCESNnQmlnP5\nZOHA0eSYXwy8j4od5ZmjA3IpFOEPW2MutMbxIbJpg5dIx2x7WxespftenRLgl3CxcpPDcnb9w8LCHBg7\nSEjrEer6Y8wVLFWsQiv6nTdCPZz9cGqwgtCaiHRy8lTWFgdfWd397vw9rduGld3uUFeFRGjYrphqEmHi\nhiG0GhE6wRFVUsGJtvOCYkVREvbEdxPFeJvlAvOcs9HKbtptlTusvYB86vR2bNcIY4f5JZu2X6sGa354\n7LRk0ps2zqYjat3hMR7XDC8KiKceBteFsXoDjfVxTYKelpedTxqWAafrKhaoAVuNM98PSnkuIWGzjSUC\nNsDJTt6vt1D1afBVPWVmnQ7ZQdtEtLIEwAWYjemAztreELIr1E9fPEILm1Ke4KctP9I0I72Dh4eylNZD\n0DEr2Hg7cWFckuZ0Av5d0IPRARXikEGDHl8uh12TXL9v2Uh0ZVSJMEYvxGSbZvkWz8TjWSk3hKA2a7GL\nJm3Ho7e1C34gE1XRGcEthxvURxt4OKBqN3ZNaMIuDTWinoQAutMcUqtm4MoL7RGPiCHUrvTwQPSirsmA\nQmOEu8nOpnP77Fivh9jLGx5ta7nL6jrsWUsBqiN1lzpdPYLRR4mUIAj6sNWiDEk4pkbHSMEcqbWw6Zl7\npsEyPDHalCNhWMA3RSK3skURzQDZ0oBV5W7vjVIZ4d3uCKsk6zrzEI9u5mx7p9RdNKodXfzqYt0ULdtc\n3RW0hIfw2KvrO3BD2QrtgAkfrFBGVvlJSUoh0MvLz8DeXxfuiuq9Ttu7wvsqVI4Piah6WNEXtHHGPJO3\nGhc75Bnv2To4VS2v8rmyKAPIIVTuYBHZN6sZ4FhFzbrslCIdk0eadaU60naqiNWU3CsxplIYGyeThmJ7\n9u4h6Y2OmiPZjFPS2bAzwgAozYTVefII9aEaWZ0hxHZeu1FW7r79dkdO73ZqRfas9u8Z7LLBPCw5pV0F\n5I0pHDgNb6MogoxF4NZJfVtIX1vCHhhVLrXjrYNJU2fD9Fw8kT8Ie2HDBJnqAvYKmryQ1r9ulo3Me3rH\nq9s2Y5uCDxu9iQNhnpwIm57WYGFeqd2fnQeY2IziD3Jgx0KSrmOH0jgi0RwJyfGXaORPq3bQQqljuACo\nkO6io9t5VI8PbNxSHTRbtYiPciUslbT0g7SpCLrRPOBRJ4DDk56pjghpeoUagJ5xJ4wjBzBuXnAGkNnP\nTfpiuz2r3oSBAi8sB9wiYK2z9sp4gZyQsqdVNzAEgKatOxBRBmJCBYpjO98ZQrF83XApPpfFg0ujB2PW\n1iYF9NkgwIKB5oB6KVTOmSKJk11mVermPgeugHbzdd2zUP6fP8fWbhseqk2t8ahGvqjs2CDHFIWXl5jc\nfCknbykE3ANt7lnAfJQ2ddduLGiqrX4HWx6jcWw08Es6BkleO0IDbaWrb95d5isvFlzJsf0TyDIXF4uq\nbBDCi0XPWqtRJ2iqmnJa2GbBe9GmAOWMkBFSilMyC4sR395WSDpD56fx0NGoU6cHrRu9xF2Bgh7RGSfl\nch2GXEeE02fDpSHFNvJBlOEqqfkIX6oCa6KY9NThqeIjYsT184XR2ZI7akXRaw1gMOGpk4FmUxk6WIuX\n4ei1SLQgSdl7OEdRtJklZ76eFrMbkJQ2TDhu8f7mVuiy53GUMIvCrP9xYGZGmCIDm2e4U2BDi3F7C5xK\n3bDZXwlQp6z4BSqTy2OVEWxXUJfjPMOL5Mc7AvDeKtxAS73pVIv0HgHIa4NBAdC7uLG0zXuu1FF6z2XY\nyUhk03fMZhYe7vVxsul3WE7U01fuN8z2y0eKwBW1RFBE1eKIaR9Y01sIWQWbSrfHfDrdZiElhmhHehfs\n0EfrR4sLYdQshJuvhTeKGJDaEhtPQwwJ9mUYGtuCL9RozWx1XI4bHNlzBTW0BVokYiJGlPe7wdxNzJD7\nJgS7Lwv6jGKngVf86imGZyzqwiteWFPdNUoWdTvUPSMO5xIUK9mo5QpwbBOAmyYzVq42o3Qs90N9khEV\nU36LB99fw8PtGHH5wsCHshfauwnNPj0blGXzke0kQ4JNCVH7Jtn0Y0aeejkSxFtwtxoYs6zHl1Lxxpsd\nsw5vBy49CEtoltDW367lVAwDjWdx20msGB7qJCkEDrzu7EXSO22782QX9NBRcN9ppX0C25I0FMA4Wnhz\n9zIpiXRrsTH35jzM8Cjt4EVLGNU3O0HuEvAer3cENnMJtngdrT86ox3fihMQbiuy4Bh4DEcP5in2VjbT\n3qbnoCNvOi8Fmmf7KlGlWAOceL5OHVE5lljjQEMzEQOCEgrk5mDKgwSBJQBNauIDSC1a5iEQjB8Xxp4C\nqeKyyWY9IOntNrtU5ny4lNprHJd36dKFeBLKcGCOvgHBXdOZloMF0YTRExw7hreEO9IoTGVHJ4teWsNr\nHdtagUHjkeZkdMMfnUGNv5aBNtFMqhcZH6EitEa9lGPkKBbJpoom3u8D8EHSIF1H5EZqqx9TLY5hWAIG\nPwJ4qwkpCGw5rCLVrjw7ARKukIFzNULANqjHUMcJ002TlUosJM4xJ4aAgckpLVGOGuPDhGAAexEcQmbg\nUsZdmqQrtuVUyyLteLbLbqtR6CTlcAIwY3xyMCmPgyefE0FEUODBoxQtRUuYTL9RC5o1sYb2PvcxUQfb\niJFi2CAl99pAzcckU2qVCxniARslIxM5pmMRGsQX9ZzYAfZrbg6ce6S74I8UMlgRQ2QVyvUjKKOE6IrJ\nLng370emHfe5m6LZULD5YiZutkD5ipjL2Bz77DvTE5kNPUhuoKBcTJcUgytfXAKUTWOcRKNlq0GImrxM\nJfr7AWbLFFNKGLeTrVDBwpcokJCv0zcOKWe8fd2xkeXkZTdmM66IgM27cyYmtQ6YF26Kd0qrWJeVZJV9\n3fyLYYvKN5csbRY2BHoYE5ERARRW65IrpkXMf48OrCXMtDIP0Z7wxI9DiTeKKeH4uuguhCJnwzR3WxLA\nVU6eBJEd7ZjS6JA83w7decq8uDI7LGKjcz1FySp3B7fE9DkHRGXxbsL7Fjar6vW2mAv8CuvI20B6jctp\n2yLDs24sPfB3sSxrrlhbuT1m6DZqiN0dl6umKx7NGZhmOTVGr20jfcxhqPQwTJfd7kel4rvxip4BqkvT\n7STy8knJ2BXGyJeNgwo1PXUZRDVy0LCTsSF1RFuRZe8cktHl9lgw8ntdPn1pVFL0MwJkJfdXBNUp5gNv\n50FTkrpo1t6wq4CVbcfj2XOrOzvBUzNH26sXGABI1gGxCdp2jEZrHgqQaWIaTJVTuguZhxqDvdYsrwFW\nYN58uuNcKHIrGdRSigyZInwQDYk0pjcqdSeU0WVU3Y9htzZBR7XRaCJr5YTZvq7fwermb5tuwb37lPLq\nB2IGg0iftkVbXaSyfCwVaRbfLBb88so0QqpmJGirFu8FcDiXOV1zTr8yW9XLdYQuUjh43xrXLdgsuYff\nCagInUk1eU1aLjVZoJRsNmStmOEpAqlYMwTvx7w6j2f421Cxr5cNZBIVlAxlXN2QiDqJ9v3sHhHkTanc\nlQuH8ptUyX8qncpBuXXBn7cSez9N0EoxCBl1GHUagbjstgJo4gzLvTmVIY6MiWYOBitzNUHfyqKwtKUr\nVoSCdZcGeA9lHUPA7PUprRRaT3m1hGKPyshtVS2ikG48w3oVerln1N1qGdtz46gZCrndw3LZ1B362RfW\nzDPuXbpsyLsRMTt1Rz1oKHRXp3iE41hkhQH6pxlvyCW2INnHt5XU8zRamOB3oW0udOhMpQFDjRkOcy06\nb4t0QTHvoRqmBna3WXzIMZyeK3GChF5eF8oDXRbjhk7BB6YKCgqwWUzEJ5K47HMSlhFkBUjaPRjdGM0z\nzOMwhW6b1NvSwP7XM1P5yi1oPvOspts1vr29SXqrMMrBhVogeodWyd69NqrO4jkyBxKmlXifoTowpfiY\n2cUCE0XMZqxUN39LCP09JqZifaEcBEo3mgtm1tWu5QR2GNq7UyQf4RIPSDOpDCAtwoPhRgdT1lJdcj4U\nlnH0wrJ8Uwu7c08L7ErnIrDATqCrOjpSbzGP1xHENABYONC4TknFPrJ8pe40A8fzGT0qBw9mAM1SKcHO\nfoiLcMC9AjHTqJzDG3xplSLPG9or2rMeq7Fzp9r0y7uJRMxgg51EbjfvYlH466A3ggvL2WQlDXjJqPW3\nBJGWAWDNN9LK8f46bADKPxakpkx23S9O47rGSXfDhVSIZsDympxWX1UOzWwMZRHkofVeKqizgbKkGgUT\nWykE9gRoRAOd9wfHZDYKa9i0LaPDiaUMvnU1gdBIqIoiVsdJ9swX47oxvMtOxtcS0zlD6llDkBuIiU5g\nPwRCYmtkkb25c8iRJXwGFPjI1wJ34I1z1ENicPdosPiUe9ZC2jnXIKzEdv01x2ER7DNDF3yxOwOhxNxI\nGqsmC92j25UQQFu9ZstOZ28AoCkuOYs0Uycm5u8jR1T39dMBwrko09rC65ENLnsxM8oebmyFCPiGJ1ED\n5Xqc9qZ237f1OnETAoEOwqUSvrdPTv56U7hV91EMTyC812MLQpr2710E3VVpsUCUMNhIxdt7UXZ1UNFb\njgzpZLXnf4DHrv6B7kq6UI50KMxcw1HZE2GpODfUTzNFLaqdrvzxKe5eUWdcojBaRbD4fFdVYJTElYDH\nNNVh6ofkoeWcs9CWGFmSBe0T4K8phFeygQg0prKMELNEy6qENzVtG9ZDcqj3a7L6ZLtvq50anWp7fAVu\nfwz55g4iM2Z2fA0pnwHDL7tt67zTxGITvsnJsZSpeq1EQsZcwtkBV9liu7Rl7jiVT1IIRtchB8TsTiaA\nwVHIQQ9RIOTiPQdKNqi1kC9iGlUqWK93gblNWlBw1eYB9Wk8FQogutwTf0caNMx8D4nPbANcmOOlskIy\nzALh15OlTrWnhP95rf08AN2J026zDE2DUF9k0eCevYBQIDjqKNW4XCZnjbHoIcKzbY5VzPbMs3ZyMz8K\nSucBmgPg6wrSK5ykbkapS5vuqvXc9GbjQJ8bPNzoxoWGyjbZvDs2OBrIqBmcQb2DLJ8v38McQ4mC4UsS\njf4PyfSCtpk274QZjvLCZbLiCBxQegk7jUU0NmTFJAcYCxd9xMWdlFkiszcltT2YzwuFFz7iA6aa4n5L\nHpBNfUA01GcAi1aCMYhmooS4zSlYcSOZkovMz36U3Fd9WtqIEOJLi7HMgHQDgNMdK6DTzAdHQtxerxVF\nHJnPrfNVG7270r3bp0bPnLNYLhObbAn6zqSAUeLtI2Y4KJDjBKCAh2vvYGbu0e2REYJWRj7MkGevsSSy\nb1kCXLt6tKGWAb7lt5c0xyJgUIJW7pdtnwgT0ZCa24BecCAwNnG5U2EwQbcjZGsFxqNGfaemd3oFEhES\nBaE0Fxms9UKTnMafu8wvZ2xymMrUduuRzOjDeX7oD5YsLC88V8CGMLxbbxIpt94KGykbr6e7L0R4oZl1\ntKMgFwQ2p9Txdbp0Y293LcsJymKizqI0F2xEp7y4SmWOJqHZtsbz80wVV9nv41CvtfxuSoGZJ5cNB7pI\nBgzNcQCeH3Jt0RaGGwboxxpuFbzilmkMFXxJm87tD4WNgu01nHfGCKeQcySEBZpVfJgi6sDFJ8uWnvKm\n9mPLHurtWzEfKqUEa1iC71bXjw5wrvhv9BYW8JSUELHmDquftQyKdq0DZXhULMHGQLf4e95WIaoA14LL\nbThz77kuhKULPTu2MNrBUKGorurhGugo5gs4ZUezSsUOe3KxYdrFMdGgny1GgTxMSMTp2RAZytKjv4kQ\nVx7XgzvpQLIbDjUPAkJv6lScwIRq1W3Ne0Rh0V6Bmn6U5uIuWnJjULmbaQiSODj3z0mAZvak0mSWIGwT\nTX83HztcC4W7e1f6a1thmcc5K61Icehla2hBELWPpixTkyC4eEVmk9Rq0m0ZXtx0JX2ZQXqXDEyePyMe\nJ70sdSzXk72zusqhY4yuOMGgbYNHqxOToK6NxujR7e4dV3Wk5JnSUthym8scjcPeCiKDNY4cHfTMnDXJ\n9zLVy01LtNKYpJ1s8FxVxigmxQNKEbIamxhx6yqwGC4aiISVOOUEjvNOdaUfXfUsE6jEwtwxyGxjlRK1\ncLyxXttq4QWN6PehgHv7jXykzPjInbEysebFvvPOOMdunmJvcCNMSvjUda8fL6xfGo0FDrLg8XZipd6S\noPVdYtyIM1Dg40KbBA3JuumPYtXuJaHrZnjZmdnM5OVo4ZNxktfCVT0c6bnD4bAeyn4bYt1ZPaX6hQHh\nJtvNYfpD0ONYlmqKuToQAMlz52Fh6bj45EbX89L5eLlSpWeyBlGotzriB0EPlclrGi5l2B5oPb1aB1ag\nyyYuu44l0F1oOVYnBIZsxIsHVITxi9lEuVPFkWASOUNuVQXfM4n5hxWR9qtuKnIcPsvbJsv1U10XlKh3\nKisqPhHU15xrCLr5gwFxPUKiNTLUBrkzgBOHXPVsHcLCiSD0YU56TRGfvEom43TWUKPPfl9Z54tgVQuT\njCRlaljAzeniQIcbbHZnn3f0HxbDG3DFYqWSxNrXabHhRsIOhhUHSPENyhGSTVO5t0XX5CdMspJPCd02\n3Oqv32ccbUK4O3YH6LEvp0WO3kSl5n50odVkI9B0i0iq4UPFGMkM8bEQJbgJoOH71P10vtdevJFQE4g2\nyhimiM53ZJRWgSZveHtENZc0Gjo0F9eioak9BnPpY1QxAFPC817svuhEstcU69bLCA4D1rO5R8AuIIBq\nyQJcifFLvbpAEYTLKJqysZrU8EEl3TSdC13A9hZvk4NC8VGEDAxcNrKw313dZp17kZPO5HSd1y6sljAW\nA9M1d6FMYV5SlBWf3WZNCUPS7qKNlda2YBsC6IUVB363f5RLGQOQHwbaijBSRCkrVoRxBHtc0Bd5J9V9\nP5uMTXkpZOxRcCQvImGgcmGuxxLb5zTqfS2xu7v3Sf3IIesSt9tVzcEcdbEvLGVJkLk4mb3G30DbIbri\nPZ09JkweDvMaQ3bxT2nfkz3Ilihkw9jqikkCCCz7E8h6z6KbhQErEW9VzJZzMCgJsyPjFam6iNwpe07S\nhyOvNVw2t9wpzL5xM11DvVzQwDaWEytNRHzDBs4KwEtpI2IpjUyVZHSwA0UGqqkzoCgrJFlNOvPlXqcS\nIcREouUIBmuttkrhPWJtSxOOgpsdvBR3kTOzAXNzSKxoaBAb0c5SDMUc6FIyGA8x5wg5DkUgjFUUodEt\nOYaB2VHVePW9mxHeBTdKWLzJow4ZZvjnoBuVigXljKCNh137ckV2y3Yg3Xi4UzJEI2V5Rw9AfnMs7xUw\nVHOFCg189maD3bmZAe7b4eaGZhyy4HVKjqCXmIH7vsEjRvbnfB0SQxxpuqBDJbHNCtW4vM643ZQQBVPP\na7oXSQIq9w2dHp0A7dtkocCZdQp9FKR9XdJAFIbVSHzIF1ZogeZlc0pXuNE0tagvD57xwDRFkAuoQyMu\nYDdZasXrpSmEE5UjHVkyYsISn8QsfXurzDybX468aoRoks654jjmRY5zi1oB8TcMdC2c3sicNaqfeuhd\nH1nPX7l4RpdqWMR7gGx9slXtG8S3KxpOi4qCD7yg3saD66nun4dzksQURoTUdXyrJR5UpHsfIlTF1aJa\nMdXyQtQnrkl00TeghQd00rRFZsCnhi0qrCSKiBfB2EVrd9RPpbgwJGZHuIQecdBmNetc2ylSEClqVBPR\nGOPPIxrnswEZjmnS0jxKW9VSM1QVxSPJnPFswCqT95SoKD6CP4xdX28WIUGiNaIKodXXJHEIsXBCxLsr\nPwWPCtoplC6hhpKmW5dQo92iCTyY2KioKzO8XR6FKm6qonMKVEwQNtlYE9c97KMtEnp25VOdMP46SQXS\nYsSVp7vm8LP87VYI8SOKcW3s2oedYFtt45rvDzoTF0GmS6wELQ9uo98HhjQAI1Dt91cgjJOwygNmLoZE\nX5K2zQiNA163uMCl5xzaBqY4YTL0wgALg3IFdYSp0RFYLWdt6IxoGI1tnoxcjlUEPo5eGIc3mS3SmaLn\nOdumfUQQ4Jgmgaa5anUVQsfBDrlAN5oaX7O0JO71SSPSWiHBsT9WIPy2J1Cace9ZZLRxblFPSXcvsuHh\nhvnhWQltEDAe7MgvkFQ8lGVFa8jhzijoF9kLmMhMILSzYnfXnZPNP7TlAAwlLHK1RqlpHskJqb6CPpGP\nQvOAhEMsM3zJ2KejZx0esxkjxA0ZufVvGAMN3vTUMplQaF4RiQkp9fzBXf3CMk01dWjOMMIEXTeKzIQe\nEcffzjixWU9FpAyGp2rVl4ETRgqljOGw4UgK31r0ZIEGnH0xGz1FtbW1OcQM008JVujRqulCucEMmntr\n"
          }, **opts)
        end

      end

    end

    describe '#query_idempotency_token_auto_fill' do

      describe 'requests' do

        # Automatically adds idempotency token when not set
        it 'RailsJsonQueryIdempotencyTokenAutoFill' do
          allow(SecureRandom).to receive(:uuid).and_return('00000000-0000-4000-8000-000000000000')
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/QueryIdempotencyTokenAutoFill')
            expected_query = ::CGI.parse(['token=00000000-0000-4000-8000-000000000000'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.query_idempotency_token_auto_fill({

          }, **opts)
        end

        # Uses the given idempotency token as-is
        it 'RailsJsonQueryIdempotencyTokenAutoFillIsSet' do
          allow(SecureRandom).to receive(:uuid).and_return('00000000-0000-4000-8000-000000000000')
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/QueryIdempotencyTokenAutoFill')
            expected_query = ::CGI.parse(['token=00000000-0000-4000-8000-000000000000'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.query_idempotency_token_auto_fill({
            token: "00000000-0000-4000-8000-000000000000"
          }, **opts)
        end

      end

    end

    describe '#query_params_as_string_list_map' do

      describe 'requests' do

        # Serialize query params from map of list strings
        it 'RailsJsonQueryParamsStringListMap' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/StringListMap')
            expected_query = ::CGI.parse(['corge=named', 'baz=bar', 'baz=qux'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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

    describe '#query_precedence' do

      describe 'requests' do

        # Prefer named query parameters when serializing
        it 'RailsJsonQueryPrecedence' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/Precedence')
            expected_query = ::CGI.parse(['bar=named', 'qux=alsoFromMap'].join('&'))
            actual_query = ::CGI.parse(request.uri.query)
            expected_query.each do |k, v|
              expect(actual_query[k]).to eq(v)
            end
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.query_precedence({
            foo: "named",
            baz: {
              'bar' => "fromMap",
              'qux' => "alsoFromMap"
            }
          }, **opts)
        end

      end

    end

    describe '#recursive_shapes' do

      describe 'requests' do

        # Serializes recursive structures
        it 'RailsJsonRecursiveShapes' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/RecursiveShapes')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "nested": {
                    "foo": "Foo1",
                    "nested": {
                        "bar": "Bar1",
                        "recursive_member": {
                            "foo": "Foo2",
                            "nested": {
                                "bar": "Bar2"
                            }
                        }
                    }
                }
            }'))
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
        it 'RailsJsonRecursiveShapes' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "nested": {
                  "foo": "Foo1",
                  "nested": {
                      "bar": "Bar1",
                      "recursive_member": {
                          "foo": "Foo2",
                          "nested": {
                              "bar": "Bar2"
                          }
                      }
                  }
              }
          }')
          response.body.rewind
          client.stub_responses(:recursive_shapes, response)
          allow(Builders::RecursiveShapes).to receive(:build)
          output = client.recursive_shapes({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
        it 'stubs RailsJsonRecursiveShapes' do
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
          expect(output.data.to_h).to eq({
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

    describe '#simple_scalar_properties' do

      describe 'requests' do

        # Serializes simple scalar properties
        it 'RailsJsonSimpleScalarProperties' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/SimpleScalarProperties')
            { 'Content-Type' => 'application/json', 'X-Foo' => 'Foo' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "string_value": "string",
                "true_boolean_value": true,
                "false_boolean_value": false,
                "byte_value": 1,
                "short_value": 2,
                "integer_value": 3,
                "long_value": 4,
                "float_value": 5.5,
                "DoubleDribble": 6.5
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.simple_scalar_properties({
            foo: "Foo",
            string_value: "string",
            true_boolean_value: true,
            false_boolean_value: false,
            byte_value: 1,
            short_value: 2,
            integer_value: 3,
            long_value: 4,
            float_value: 5.5,
            double_value: 6.5
          }, **opts)
        end

        # Rails Json should not serialize null structure values
        it 'RailsJsonDoesntSerializeNullStructureValues' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/SimpleScalarProperties')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{}'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.simple_scalar_properties({
            string_value: nil
          }, **opts)
        end

        # Supports handling NaN float values.
        it 'RailsJsonSupportsNaNFloatInputs' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/SimpleScalarProperties')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "float_value": "NaN",
                "DoubleDribble": "NaN"
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.simple_scalar_properties({
            float_value: Float::NAN,
            double_value: Float::NAN
          }, **opts)
        end

        # Supports handling Infinity float values.
        it 'RailsJsonSupportsInfinityFloatInputs' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/SimpleScalarProperties')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "float_value": "Infinity",
                "DoubleDribble": "Infinity"
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.simple_scalar_properties({
            float_value: Float::INFINITY,
            double_value: Float::INFINITY
          }, **opts)
        end

        # Supports handling -Infinity float values.
        it 'RailsJsonSupportsNegativeInfinityFloatInputs' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/SimpleScalarProperties')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "float_value": "-Infinity",
                "DoubleDribble": "-Infinity"
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.simple_scalar_properties({
            float_value: -Float::INFINITY,
            double_value: -Float::INFINITY
          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes simple scalar properties
        it 'RailsJsonSimpleScalarProperties' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.headers['X-Foo'] = 'Foo'
          response.body.write('{
              "string_value": "string",
              "true_boolean_value": true,
              "false_boolean_value": false,
              "byte_value": 1,
              "short_value": 2,
              "integer_value": 3,
              "long_value": 4,
              "float_value": 5.5,
              "DoubleDribble": 6.5
          }')
          response.body.rewind
          client.stub_responses(:simple_scalar_properties, response)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          output = client.simple_scalar_properties({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            foo: "Foo",
            string_value: "string",
            true_boolean_value: true,
            false_boolean_value: false,
            byte_value: 1,
            short_value: 2,
            integer_value: 3,
            long_value: 4,
            float_value: 5.5,
            double_value: 6.5
          })
        end

        # Rails Json should not deserialize null structure values
        it 'RailsJsonDoesntDeserializeNullStructureValues' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "string_value": null
          }')
          response.body.rewind
          client.stub_responses(:simple_scalar_properties, response)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          output = client.simple_scalar_properties({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

        # Supports handling NaN float values.
        it 'RailsJsonSupportsNaNFloatInputs' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "float_value": "NaN",
              "DoubleDribble": "NaN"
          }')
          response.body.rewind
          client.stub_responses(:simple_scalar_properties, response)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          output = client.simple_scalar_properties({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            float_value: Float::NAN,
            double_value: Float::NAN
          })
        end

        # Supports handling Infinity float values.
        it 'RailsJsonSupportsInfinityFloatInputs' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "float_value": "Infinity",
              "DoubleDribble": "Infinity"
          }')
          response.body.rewind
          client.stub_responses(:simple_scalar_properties, response)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          output = client.simple_scalar_properties({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            float_value: Float::INFINITY,
            double_value: Float::INFINITY
          })
        end

        # Supports handling -Infinity float values.
        it 'RailsJsonSupportsNegativeInfinityFloatInputs' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "float_value": "-Infinity",
              "DoubleDribble": "-Infinity"
          }')
          response.body.rewind
          client.stub_responses(:simple_scalar_properties, response)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          output = client.simple_scalar_properties({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            float_value: -Float::INFINITY,
            double_value: -Float::INFINITY
          })
        end

      end

      describe 'stubs' do

        # Serializes simple scalar properties
        it 'stubs RailsJsonSimpleScalarProperties' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          client.stub_responses(:simple_scalar_properties, data: {
            foo: "Foo",
            string_value: "string",
            true_boolean_value: true,
            false_boolean_value: false,
            byte_value: 1,
            short_value: 2,
            integer_value: 3,
            long_value: 4,
            float_value: 5.5,
            double_value: 6.5
          })
          output = client.simple_scalar_properties({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            foo: "Foo",
            string_value: "string",
            true_boolean_value: true,
            false_boolean_value: false,
            byte_value: 1,
            short_value: 2,
            integer_value: 3,
            long_value: 4,
            float_value: 5.5,
            double_value: 6.5
          })
        end

        # Rails Json should not deserialize null structure values
        it 'stubs RailsJsonDoesntDeserializeNullStructureValues' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          client.stub_responses(:simple_scalar_properties, data: {

          })
          output = client.simple_scalar_properties({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

        # Supports handling NaN float values.
        it 'stubs RailsJsonSupportsNaNFloatInputs' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          client.stub_responses(:simple_scalar_properties, data: {
            float_value: Float::NAN,
            double_value: Float::NAN
          })
          output = client.simple_scalar_properties({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            float_value: Float::NAN,
            double_value: Float::NAN
          })
        end

        # Supports handling Infinity float values.
        it 'stubs RailsJsonSupportsInfinityFloatInputs' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          client.stub_responses(:simple_scalar_properties, data: {
            float_value: Float::INFINITY,
            double_value: Float::INFINITY
          })
          output = client.simple_scalar_properties({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            float_value: Float::INFINITY,
            double_value: Float::INFINITY
          })
        end

        # Supports handling -Infinity float values.
        it 'stubs RailsJsonSupportsNegativeInfinityFloatInputs' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SimpleScalarProperties).to receive(:build)
          client.stub_responses(:simple_scalar_properties, data: {
            float_value: -Float::INFINITY,
            double_value: -Float::INFINITY
          })
          output = client.simple_scalar_properties({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            float_value: -Float::INFINITY,
            double_value: -Float::INFINITY
          })
        end

      end

    end

    describe '#sparse_json_lists' do

      describe 'requests' do

        # Serializes null values in sparse lists
        it 'RailsJsonSparseListsSerializeNull' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('PUT')
            expect(request.uri.path).to eq('/SparseJsonLists')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "sparse_string_list": [
                    null,
                    "hi"
                ]
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.sparse_json_lists({
            sparse_string_list: [
              nil,
              "hi"
            ]
          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes null values in sparse lists
        it 'RailsJsonSparseListsSerializeNull' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "sparse_string_list": [
                  null,
                  "hi"
              ]
          }')
          response.body.rewind
          client.stub_responses(:sparse_json_lists, response)
          allow(Builders::SparseJsonLists).to receive(:build)
          output = client.sparse_json_lists({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            sparse_string_list: [
              nil,
              "hi"
            ]
          })
        end

      end

      describe 'stubs' do

        # Serializes null values in sparse lists
        it 'stubs RailsJsonSparseListsSerializeNull' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SparseJsonLists).to receive(:build)
          client.stub_responses(:sparse_json_lists, data: {
            sparse_string_list: [
              nil,
              "hi"
            ]
          })
          output = client.sparse_json_lists({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            sparse_string_list: [
              nil,
              "hi"
            ]
          })
        end

      end

    end

    describe '#sparse_json_maps' do

      describe 'requests' do

        # Serializes JSON maps
        it 'RailsJsonSparseJsonMaps' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/SparseJsonMaps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "sparse_struct_map": {
                    "foo": {
                        "hi": "there"
                    },
                    "baz": {
                        "hi": "bye"
                    }
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.sparse_json_maps({
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
        it 'RailsJsonSerializesSparseNullMapValues' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/SparseJsonMaps')
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
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.sparse_json_maps({
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
        it 'RailsJsonSerializesZeroValuesInSparseMaps' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/SparseJsonMaps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "sparse_number_map": {
                    "x": 0
                },
                "sparse_boolean_map": {
                    "x": false
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.sparse_json_maps({
            sparse_number_map: {
              'x' => 0
            },
            sparse_boolean_map: {
              'x' => false
            }
          }, **opts)
        end

        # A request that contains a sparse map of sets
        it 'RailsJsonSerializesSparseSetMap' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/SparseJsonMaps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "sparse_set_map": {
                    "x": [],
                    "y": ["a", "b"]
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.sparse_json_maps({
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
        it 'RailsJsonSerializesSparseSetMapAndRetainsNull' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/SparseJsonMaps')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{
                "sparse_set_map": {
                    "x": [],
                    "y": ["a", "b"],
                    "z": null
                }
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.sparse_json_maps({
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
        it 'RailsJsonSparseJsonMaps' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "sparse_struct_map": {
                  "foo": {
                      "hi": "there"
                  },
                  "baz": {
                      "hi": "bye"
                  }
             }
          }')
          response.body.rewind
          client.stub_responses(:sparse_json_maps, response)
          allow(Builders::SparseJsonMaps).to receive(:build)
          output = client.sparse_json_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
        it 'RailsJsonDeserializesSparseNullMapValues' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
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
          response.body.rewind
          client.stub_responses(:sparse_json_maps, response)
          allow(Builders::SparseJsonMaps).to receive(:build)
          output = client.sparse_json_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
        it 'RailsJsonDeserializesZeroValuesInSparseMaps' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "sparse_number_map": {
                  "x": 0
              },
              "sparse_boolean_map": {
                  "x": false
              }
          }')
          response.body.rewind
          client.stub_responses(:sparse_json_maps, response)
          allow(Builders::SparseJsonMaps).to receive(:build)
          output = client.sparse_json_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            sparse_number_map: {
              'x' => 0
            },
            sparse_boolean_map: {
              'x' => false
            }
          })
        end

        # A response that contains a sparse map of sets
        it 'RailsJsonDeserializesSparseSetMap' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "sparse_set_map": {
                  "x": [],
                  "y": ["a", "b"]
              }
          }')
          response.body.rewind
          client.stub_responses(:sparse_json_maps, response)
          allow(Builders::SparseJsonMaps).to receive(:build)
          output = client.sparse_json_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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

        # A response that contains a sparse map of sets.
        it 'RailsJsonDeserializesSparseSetMapAndRetainsNull' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/json'
          response.body.write('{
              "sparse_set_map": {
                  "x": [],
                  "y": ["a", "b"],
                  "z": null
              }
          }')
          response.body.rewind
          client.stub_responses(:sparse_json_maps, response)
          allow(Builders::SparseJsonMaps).to receive(:build)
          output = client.sparse_json_maps({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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

      end

      describe 'stubs' do

        # Deserializes JSON maps
        it 'stubs RailsJsonSparseJsonMaps' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SparseJsonMaps).to receive(:build)
          client.stub_responses(:sparse_json_maps, data: {
            sparse_struct_map: {
              'foo' => {
                hi: "there"
              },
              'baz' => {
                hi: "bye"
              }
            }
          })
          output = client.sparse_json_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
        it 'stubs RailsJsonDeserializesSparseNullMapValues' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SparseJsonMaps).to receive(:build)
          client.stub_responses(:sparse_json_maps, data: {
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
          output = client.sparse_json_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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
        it 'stubs RailsJsonDeserializesZeroValuesInSparseMaps' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SparseJsonMaps).to receive(:build)
          client.stub_responses(:sparse_json_maps, data: {
            sparse_number_map: {
              'x' => 0
            },
            sparse_boolean_map: {
              'x' => false
            }
          })
          output = client.sparse_json_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
            sparse_number_map: {
              'x' => 0
            },
            sparse_boolean_map: {
              'x' => false
            }
          })
        end

        # A response that contains a sparse map of sets
        it 'stubs RailsJsonDeserializesSparseSetMap' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SparseJsonMaps).to receive(:build)
          client.stub_responses(:sparse_json_maps, data: {
            sparse_set_map: {
              'x' => [

              ],
              'y' => [
                "a",
                "b"
              ]
            }
          })
          output = client.sparse_json_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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

        # A response that contains a sparse map of sets.
        it 'stubs RailsJsonDeserializesSparseSetMapAndRetainsNull' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::SparseJsonMaps).to receive(:build)
          client.stub_responses(:sparse_json_maps, data: {
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
          output = client.sparse_json_maps({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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

      end

    end

    describe '#streaming_traits' do

      describe 'requests' do

        # Serializes a blob in the HTTP payload
        it 'RailsJsonStreamingTraitsWithBlob' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/StreamingTraits')
            { 'Content-Type' => 'application/octet-stream', 'X-Foo' => 'Foo' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('blobby blob blob')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.streaming_traits({
            foo: "Foo",
            blob: 'blobby blob blob'
          }, **opts)
        end

        # Serializes an empty blob in the HTTP payload
        it 'RailsJsonStreamingTraitsWithNoBlobBody' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/StreamingTraits')
            { 'X-Foo' => 'Foo' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.streaming_traits({
            foo: "Foo"
          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes a blob in the HTTP payload
        it 'RailsJsonStreamingTraitsWithBlob' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'application/octet-stream'
          response.headers['X-Foo'] = 'Foo'
          response.body.write('blobby blob blob')
          response.body.rewind
          client.stub_responses(:streaming_traits, response)
          allow(Builders::StreamingTraits).to receive(:build)
          output = client.streaming_traits({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          output.data.blob.rewind
          output.data.blob = output.data.blob.read
          output.data.blob = nil if output.data.blob.empty?
          expect(output.data.to_h).to eq({
            foo: "Foo",
            blob: 'blobby blob blob'
          })
        end

        # Serializes an empty blob in the HTTP payload
        it 'RailsJsonStreamingTraitsWithNoBlobBody' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-Foo'] = 'Foo'
          response.body.write('')
          response.body.rewind
          client.stub_responses(:streaming_traits, response)
          allow(Builders::StreamingTraits).to receive(:build)
          output = client.streaming_traits({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          output.data.blob.rewind
          output.data.blob = output.data.blob.read
          output.data.blob = nil if output.data.blob.empty?
          expect(output.data.to_h).to eq({
            foo: "Foo"
          })
        end

      end

      describe 'stubs' do

        # Serializes a blob in the HTTP payload
        it 'stubs RailsJsonStreamingTraitsWithBlob' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::StreamingTraits).to receive(:build)
          client.stub_responses(:streaming_traits, data: {
            foo: "Foo",
            blob: 'blobby blob blob'
          })
          output = client.streaming_traits({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          output.data.blob.rewind
          output.data.blob = output.data.blob.read
          output.data.blob = nil if output.data.blob.empty?
          expect(output.data.to_h).to eq({
            foo: "Foo",
            blob: 'blobby blob blob'
          })
        end

        # Serializes an empty blob in the HTTP payload
        it 'stubs RailsJsonStreamingTraitsWithNoBlobBody' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::StreamingTraits).to receive(:build)
          client.stub_responses(:streaming_traits, data: {
            foo: "Foo"
          })
          output = client.streaming_traits({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          output.data.blob.rewind
          output.data.blob = output.data.blob.read
          output.data.blob = nil if output.data.blob.empty?
          expect(output.data.to_h).to eq({
            foo: "Foo"
          })
        end

      end

    end

    describe '#streaming_traits_require_length' do

      describe 'requests' do

        # Serializes a blob in the HTTP payload with a required length
        it 'RailsJsonStreamingTraitsRequireLengthWithBlob' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/StreamingTraitsRequireLength')
            { 'Content-Type' => 'application/octet-stream', 'X-Foo' => 'Foo' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(request.body.read).to eq('blobby blob blob')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.streaming_traits_require_length({
            foo: "Foo",
            blob: 'blobby blob blob'
          }, **opts)
        end

        # Serializes an empty blob in the HTTP payload
        it 'RailsJsonStreamingTraitsRequireLengthWithNoBlobBody' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/StreamingTraitsRequireLength')
            { 'X-Foo' => 'Foo' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.streaming_traits_require_length({
            foo: "Foo"
          }, **opts)
        end

      end

    end

    describe '#streaming_traits_with_media_type' do

      describe 'requests' do

        # Serializes a blob in the HTTP payload with a content-type
        it 'RailsJsonStreamingTraitsWithMediaTypeWithBlob' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/StreamingTraitsWithMediaType')
            { 'Content-Type' => 'text/plain', 'X-Foo' => 'Foo' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('blobby blob blob')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.streaming_traits_with_media_type({
            foo: "Foo",
            blob: 'blobby blob blob'
          }, **opts)
        end

      end

      describe 'responses' do

        # Serializes a blob in the HTTP payload with a content-type
        it 'RailsJsonStreamingTraitsWithMediaTypeWithBlob' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['Content-Type'] = 'text/plain'
          response.headers['X-Foo'] = 'Foo'
          response.body.write('blobby blob blob')
          response.body.rewind
          client.stub_responses(:streaming_traits_with_media_type, response)
          allow(Builders::StreamingTraitsWithMediaType).to receive(:build)
          output = client.streaming_traits_with_media_type({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          output.data.blob.rewind
          output.data.blob = output.data.blob.read
          output.data.blob = nil if output.data.blob.empty?
          expect(output.data.to_h).to eq({
            foo: "Foo",
            blob: 'blobby blob blob'
          })
        end

      end

      describe 'stubs' do

        # Serializes a blob in the HTTP payload with a content-type
        it 'stubs RailsJsonStreamingTraitsWithMediaTypeWithBlob' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::StreamingTraitsWithMediaType).to receive(:build)
          client.stub_responses(:streaming_traits_with_media_type, data: {
            foo: "Foo",
            blob: 'blobby blob blob'
          })
          output = client.streaming_traits_with_media_type({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          output.data.blob.rewind
          output.data.blob = output.data.blob.read
          output.data.blob = nil if output.data.blob.empty?
          expect(output.data.to_h).to eq({
            foo: "Foo",
            blob: 'blobby blob blob'
          })
        end

      end

    end

    describe '#test_body_structure' do

      describe 'requests' do

        # Serializes a structure
        it 'RailsJsonTestBodyStructure' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/body')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"test_config":
                {"timeout": 10}
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.test_body_structure({
            test_config: {
              timeout: 10
            }
          }, **opts)
        end

        # Serializes an empty structure in the body
        it 'RailsJsonHttpWithEmptyBody' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/body')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{}'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.test_body_structure({

          }, **opts)
        end

      end

    end

    describe '#test_no_payload' do

      describe 'requests' do

        # Serializes a GET request with no modeled body
        it 'RailsJsonHttpWithNoModeledBody' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/no_payload')
            ['Content-Length', 'Content-Type'].each { |k| expect(request.headers.key?(k)).to be(false) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.test_no_payload({

          }, **opts)
        end

        # Serializes a GET request with header member but no modeled body
        it 'RailsJsonHttpWithHeaderMemberNoModeledBody' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('GET')
            expect(request.uri.path).to eq('/no_payload')
            { 'X-Amz-Test-Id' => 't-12345' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length', 'Content-Type'].each { |k| expect(request.headers.key?(k)).to be(false) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.test_no_payload({
            test_id: "t-12345"
          }, **opts)
        end

      end

    end

    describe '#test_payload_blob' do

      describe 'requests' do

        # Serializes a payload targeting an empty blob
        it 'RailsJsonHttpWithEmptyBlobPayload' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/blob_payload')
            { 'Content-Type' => 'application/octet-stream' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.test_payload_blob({

          }, **opts)
        end

        # Serializes a payload targeting a blob
        it 'RailsJsonTestPayloadBlob' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/blob_payload')
            { 'Content-Type' => 'image/jpg' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(request.body.read).to eq('1234')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.test_payload_blob({
            content_type: "image/jpg",
            data: '1234'
          }, **opts)
        end

      end

    end

    describe '#test_payload_structure' do

      describe 'requests' do

        # Serializes a payload targeting an empty structure
        it 'RailsJsonHttpWithEmptyStructurePayload' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/payload')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{}'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.test_payload_structure({

          }, **opts)
        end

        # Serializes a payload targeting a structure
        it 'RailsJsonTestPayloadStructure' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/payload')
            { 'Content-Type' => 'application/json' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{"data": 25
            }'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.test_payload_structure({
            payload_config: {
              data: 25
            }
          }, **opts)
        end

        # Serializes an request with header members but no payload
        it 'RailsJsonHttpWithHeadersButNoPayload' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/payload')
            { 'Content-Type' => 'application/json', 'X-Amz-Test-Id' => 't-12345' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            ['Content-Length'].each { |k| expect(request.headers.key?(k)).to be(true) }
            expect(JSON.parse(request.body.read)).to eq(JSON.parse('{}'))
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.test_payload_structure({
            test_id: "t-12345"
          }, **opts)
        end

      end

    end

    describe '#timestamp_format_headers' do

      describe 'requests' do

        # Tests how timestamp request headers are serialized
        it 'RailsJsonTimestampFormatHeaders' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/TimestampFormatHeaders')
            { 'X-defaultFormat' => 'Mon, 16 Dec 2019 23:48:18 GMT', 'X-memberDateTime' => '2019-12-16T23:48:18Z', 'X-memberEpochSeconds' => '1576540098', 'X-memberHttpDate' => 'Mon, 16 Dec 2019 23:48:18 GMT', 'X-targetDateTime' => '2019-12-16T23:48:18Z', 'X-targetEpochSeconds' => '1576540098', 'X-targetHttpDate' => 'Mon, 16 Dec 2019 23:48:18 GMT' }.each { |k, v| expect(request.headers[k]).to eq(v) }
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
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
        it 'RailsJsonTimestampFormatHeaders' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.headers['X-defaultFormat'] = 'Mon, 16 Dec 2019 23:48:18 GMT'
          response.headers['X-memberDateTime'] = '2019-12-16T23:48:18Z'
          response.headers['X-memberEpochSeconds'] = '1576540098'
          response.headers['X-memberHttpDate'] = 'Mon, 16 Dec 2019 23:48:18 GMT'
          response.headers['X-targetDateTime'] = '2019-12-16T23:48:18Z'
          response.headers['X-targetEpochSeconds'] = '1576540098'
          response.headers['X-targetHttpDate'] = 'Mon, 16 Dec 2019 23:48:18 GMT'
          client.stub_responses(:timestamp_format_headers, response)
          allow(Builders::TimestampFormatHeaders).to receive(:build)
          output = client.timestamp_format_headers({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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

      describe 'stubs' do

        # Tests how timestamp response headers are serialized
        it 'stubs RailsJsonTimestampFormatHeaders' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::TimestampFormatHeaders).to receive(:build)
          client.stub_responses(:timestamp_format_headers, data: {
            member_epoch_seconds: Time.at(1576540098),
            member_http_date: Time.at(1576540098),
            member_date_time: Time.at(1576540098),
            default_format: Time.at(1576540098),
            target_epoch_seconds: Time.at(1576540098),
            target_http_date: Time.at(1576540098),
            target_date_time: Time.at(1576540098)
          })
          output = client.timestamp_format_headers({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({
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

    describe '#unit_input_and_output' do

      describe 'requests' do

        # A unit type input serializes no payload. When clients do not
        # need to serialize any data in the payload, they should omit
        # a payload altogether.
        it 'RailsJsonUnitInputAndOutput' do
          proc = proc do |context|
            request = context.request
            expect(request.http_method).to eq('POST')
            expect(request.uri.path).to eq('/UnitInputAndOutput')
            expect(request.body.read).to eq('')
          end
          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          opts = {interceptors: [interceptor]}
          client.unit_input_and_output({

          }, **opts)
        end

      end

      describe 'responses' do

        # When an operation defines Unit output, the service will respond
        # with an empty payload, and may optionally include the content-type
        # header.
        it 'RailsJsonUnitInputAndOutputNoOutput' do
          response = Hearth::HTTP::Response.new
          response.status = 200
          response.body.write('')
          response.body.rewind
          client.stub_responses(:unit_input_and_output, response)
          allow(Builders::UnitInputAndOutput).to receive(:build)
          output = client.unit_input_and_output({}, auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

      end

      describe 'stubs' do

        # When an operation defines Unit output, the service will respond
        # with an empty payload, and may optionally include the content-type
        # header.
        it 'stubs RailsJsonUnitInputAndOutputNoOutput' do
          proc = proc do |context|
            expect(context.response.status).to eq(200)
          end
          interceptor = Hearth::Interceptor.new(read_after_transmit: proc)
          allow(Builders::UnitInputAndOutput).to receive(:build)
          client.stub_responses(:unit_input_and_output, data: {

          })
          output = client.unit_input_and_output({}, interceptors: [interceptor], auth_resolver: Hearth::AnonymousAuthResolver.new)
          expect(output.data.to_h).to eq({

          })
        end

      end

    end

  end
end
