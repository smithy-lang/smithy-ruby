# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'base64'

module RailsJson
  # @api private
  module Builders

    class AllQueryStringTypes
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/AllQueryStringTypesInput')
        params = Hearth::Query::ParamList.new
        unless input[:query_params_map_of_string_list].nil? || input[:query_params_map_of_string_list].empty?
          input[:query_params_map_of_string_list].each do |k, v|
            unless v.nil? || v.empty?
              params[k] = v.map do |value|
                value.to_s unless value.nil?
              end
            end
          end
        end
        params['String'] = input[:query_string].to_s unless input[:query_string].nil?
        unless input[:query_string_list].nil? || input[:query_string_list].empty?
          params['StringList'] = input[:query_string_list].map do |value|
            value.to_s unless value.nil?
          end
        end
        unless input[:query_string_set].nil? || input[:query_string_set].empty?
          params['StringSet'] = input[:query_string_set].map do |value|
            value.to_s unless value.nil?
          end
        end
        params['Byte'] = input[:query_byte].to_s unless input[:query_byte].nil?
        params['Short'] = input[:query_short].to_s unless input[:query_short].nil?
        params['Integer'] = input[:query_integer].to_s unless input[:query_integer].nil?
        unless input[:query_integer_list].nil? || input[:query_integer_list].empty?
          params['IntegerList'] = input[:query_integer_list].map do |value|
            value.to_s unless value.nil?
          end
        end
        unless input[:query_integer_set].nil? || input[:query_integer_set].empty?
          params['IntegerSet'] = input[:query_integer_set].map do |value|
            value.to_s unless value.nil?
          end
        end
        params['Long'] = input[:query_long].to_s unless input[:query_long].nil?
        params['Float'] = input[:query_float].to_s unless input[:query_float].nil?
        params['Double'] = input[:query_double].to_s unless input[:query_double].nil?
        unless input[:query_double_list].nil? || input[:query_double_list].empty?
          params['DoubleList'] = input[:query_double_list].map do |value|
            value.to_s unless value.nil?
          end
        end
        params['Boolean'] = input[:query_boolean].to_s unless input[:query_boolean].nil?
        unless input[:query_boolean_list].nil? || input[:query_boolean_list].empty?
          params['BooleanList'] = input[:query_boolean_list].map do |value|
            value.to_s unless value.nil?
          end
        end
        params['Timestamp'] = Hearth::TimeHelper.to_date_time(input[:query_timestamp]) unless input[:query_timestamp].nil?
        unless input[:query_timestamp_list].nil? || input[:query_timestamp_list].empty?
          params['TimestampList'] = input[:query_timestamp_list].map do |value|
            Hearth::TimeHelper.to_date_time(value) unless value.nil?
          end
        end
        params['Enum'] = input[:query_enum].to_s unless input[:query_enum].nil?
        unless input[:query_enum_list].nil? || input[:query_enum_list].empty?
          params['EnumList'] = input[:query_enum_list].map do |value|
            value.to_s unless value.nil?
          end
        end
        params['IntegerEnum'] = input[:query_integer_enum].to_s unless input[:query_integer_enum].nil?
        unless input[:query_integer_enum_list].nil? || input[:query_integer_enum_list].empty?
          params['IntegerEnumList'] = input[:query_integer_enum_list].map do |value|
            value.to_s unless value.nil?
          end
        end
        http_req.append_query_param_list(params)
      end
    end

    class BooleanList
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class ClientOptionalDefaults
      def self.build(input)
        data = {}
        data[:member] = input[:member] unless input[:member].nil?
        data
      end
    end

    class ConstantAndVariableQueryString
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        CGI.parse('foo=bar').each do |k,v|
          v.each { |q_v| http_req.append_query_param(k, q_v) }
        end
        http_req.append_path('/ConstantAndVariableQueryString')
        params = Hearth::Query::ParamList.new
        params['baz'] = input[:baz].to_s unless input[:baz].nil?
        params['maybeSet'] = input[:maybe_set].to_s unless input[:maybe_set].nil?
        http_req.append_query_param_list(params)
      end
    end

    class ConstantQueryString
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        CGI.parse('foo=bar&hello').each do |k,v|
          v.each { |q_v| http_req.append_query_param(k, q_v) }
        end
        if input[:hello].to_s.empty?
          raise ArgumentError, "HTTP label :hello cannot be empty."
        end
        http_req.append_path(format(
            '/ConstantQueryString/%<hello>s',
            hello: Hearth::HTTP.uri_escape(input[:hello].to_s)
          )
        )
      end
    end

    class DatetimeOffsets
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/DatetimeOffsets')
      end
    end

    class Defaults
      def self.build(input)
        data = {}
        data[:default_string] = input[:default_string] unless input[:default_string].nil?
        data[:default_boolean] = input[:default_boolean] unless input[:default_boolean].nil?
        data[:default_list] = Builders::TestStringList.build(input[:default_list]) unless input[:default_list].nil?
        data[:default_document_map] = input[:default_document_map] unless input[:default_document_map].nil?
        data[:default_document_string] = input[:default_document_string] unless input[:default_document_string].nil?
        data[:default_document_boolean] = input[:default_document_boolean] unless input[:default_document_boolean].nil?
        data[:default_document_list] = input[:default_document_list] unless input[:default_document_list].nil?
        data[:default_null_document] = input[:default_null_document] unless input[:default_null_document].nil?
        data[:default_timestamp] = Hearth::TimeHelper.to_date_time(input[:default_timestamp]) unless input[:default_timestamp].nil?
        data[:default_blob] = ::Base64::encode64(input[:default_blob]).strip unless input[:default_blob].nil?
        data[:default_byte] = input[:default_byte] unless input[:default_byte].nil?
        data[:default_short] = input[:default_short] unless input[:default_short].nil?
        data[:default_integer] = input[:default_integer] unless input[:default_integer].nil?
        data[:default_long] = input[:default_long] unless input[:default_long].nil?
        data[:default_float] = Hearth::NumberHelper.serialize(input[:default_float]) unless input[:default_float].nil?
        data[:default_double] = Hearth::NumberHelper.serialize(input[:default_double]) unless input[:default_double].nil?
        data[:default_map] = Builders::TestStringMap.build(input[:default_map]) unless input[:default_map].nil?
        data[:default_enum] = input[:default_enum] unless input[:default_enum].nil?
        data[:default_int_enum] = input[:default_int_enum] unless input[:default_int_enum].nil?
        data[:empty_string] = input[:empty_string] unless input[:empty_string].nil?
        data[:false_boolean] = input[:false_boolean] unless input[:false_boolean].nil?
        data[:empty_blob] = ::Base64::encode64(input[:empty_blob]).strip unless input[:empty_blob].nil?
        data[:zero_byte] = input[:zero_byte] unless input[:zero_byte].nil?
        data[:zero_short] = input[:zero_short] unless input[:zero_short].nil?
        data[:zero_integer] = input[:zero_integer] unless input[:zero_integer].nil?
        data[:zero_long] = input[:zero_long] unless input[:zero_long].nil?
        data[:zero_float] = Hearth::NumberHelper.serialize(input[:zero_float]) unless input[:zero_float].nil?
        data[:zero_double] = Hearth::NumberHelper.serialize(input[:zero_double]) unless input[:zero_double].nil?
        data
      end
    end

    class DenseBooleanMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseNumberMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseSetMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = Builders::StringSet.build(value) unless value.nil?
        end
        data
      end
    end

    class DenseStringMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseStructMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = Builders::GreetingStruct.build(value) unless value.nil?
        end
        data
      end
    end

    class DocumentType
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/DocumentType')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:string_value] = input[:string_value] unless input[:string_value].nil?
        data[:document_value] = input[:document_value] unless input[:document_value].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class DocumentTypeAsMapValue
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/DocumentTypeAsMapValue')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:doc_valued_map] = Builders::DocumentValuedMap.build(input[:doc_valued_map]) unless input[:doc_valued_map].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class DocumentTypeAsPayload
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/DocumentTypeAsPayload')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.body = StringIO.new(Hearth::JSON.dump(input[:document_value]))
      end
    end

    class DocumentValuedMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DoubleList
      def self.build(input)
        data = []
        input.each do |element|
          data << Hearth::NumberHelper.serialize(element) unless element.nil?
        end
        data
      end
    end

    class EmptyInputAndEmptyOutput
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/EmptyInputAndEmptyOutput')
      end
    end

    class EndpointOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/EndpointOperation')
      end
    end

    class EndpointWithHostLabelOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/EndpointWithHostLabelOperation')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:label] = input[:label] unless input[:label].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class FooEnumList
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class FooEnumMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class FooEnumSet
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class FractionalSeconds
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/FractionalSeconds')
      end
    end

    class GreetingStruct
      def self.build(input)
        data = {}
        data[:hi] = input[:hi] unless input[:hi].nil?
        data
      end
    end

    class RenamedGreeting
      def self.build(input)
        data = {}
        data[:salutation] = input[:salutation] unless input[:salutation].nil?
        data
      end
    end

    class GreetingWithErrors
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/GreetingWithErrors')
      end
    end

    class HostWithPathOperation
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/HostWithPathOperation')
      end
    end

    class HttpChecksumRequired
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/HttpChecksumRequired')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:foo] = input[:foo] unless input[:foo].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class HttpEnumPayload
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/EnumPayload')
        http_req.headers['Content-Type'] = 'text/plain'
        http_req.body = StringIO.new(input[:payload] || '')
      end
    end

    class HttpPayloadTraits
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/HttpPayloadTraits')
        http_req.headers['Content-Type'] = 'application/octet-stream'
        http_req.body = StringIO.new(input[:blob] || '')
        http_req.headers['X-Foo'] = input[:foo] unless input[:foo].nil? || input[:foo].empty?
      end
    end

    class HttpPayloadTraitsWithMediaType
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/HttpPayloadTraitsWithMediaType')
        http_req.headers['Content-Type'] = 'text/plain'
        http_req.body = StringIO.new(input[:blob] || '')
        http_req.headers['X-Foo'] = input[:foo] unless input[:foo].nil? || input[:foo].empty?
      end
    end

    class HttpPayloadWithStructure
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/HttpPayloadWithStructure')
        http_req.headers['Content-Type'] = 'application/json'
        data = Builders::NestedPayload.build(input[:nested]) unless input[:nested].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data || {}))
      end
    end

    class HttpPayloadWithUnion
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/HttpPayloadWithUnion')
        http_req.headers['Content-Type'] = 'application/json'
        data = Builders::UnionPayload.build(input[:nested]) unless input[:nested].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data || {}))
      end
    end

    class HttpPrefixHeaders
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/HttpPrefixHeaders')
        http_req.headers['X-Foo'] = input[:foo] unless input[:foo].nil? || input[:foo].empty?
        input[:foo_map]&.each do |key, value|
          http_req.headers["X-Foo-#{key}"] = value unless value.nil? || value.empty?
        end
      end
    end

    class HttpPrefixHeadersInResponse
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/HttpPrefixHeadersResponse')
      end
    end

    class HttpRequestWithFloatLabels
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        if input[:float].to_s.empty?
          raise ArgumentError, "HTTP label :float cannot be empty."
        end
        if input[:double].to_s.empty?
          raise ArgumentError, "HTTP label :double cannot be empty."
        end
        http_req.append_path(format(
            '/FloatHttpLabels/%<float>s/%<double>s',
            float: Hearth::HTTP.uri_escape(input[:float].to_s),
            double: Hearth::HTTP.uri_escape(input[:double].to_s)
          )
        )
      end
    end

    class HttpRequestWithGreedyLabelInPath
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        if input[:foo].to_s.empty?
          raise ArgumentError, "HTTP label :foo cannot be empty."
        end
        if input[:baz].to_s.empty?
          raise ArgumentError, "HTTP label :baz cannot be empty."
        end
        http_req.append_path(format(
            '/HttpRequestWithGreedyLabelInPath/foo/%<foo>s/baz/%<baz>s',
            foo: Hearth::HTTP.uri_escape(input[:foo].to_s),
            baz: (input[:baz].to_s).split('/').map { |s| Hearth::HTTP.uri_escape(s) }.join('/')
          )
        )
      end
    end

    class HttpRequestWithLabels
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        if input[:string].to_s.empty?
          raise ArgumentError, "HTTP label :string cannot be empty."
        end
        if input[:short].to_s.empty?
          raise ArgumentError, "HTTP label :short cannot be empty."
        end
        if input[:integer].to_s.empty?
          raise ArgumentError, "HTTP label :integer cannot be empty."
        end
        if input[:long].to_s.empty?
          raise ArgumentError, "HTTP label :long cannot be empty."
        end
        if input[:float].to_s.empty?
          raise ArgumentError, "HTTP label :float cannot be empty."
        end
        if input[:double].to_s.empty?
          raise ArgumentError, "HTTP label :double cannot be empty."
        end
        if input[:boolean].to_s.empty?
          raise ArgumentError, "HTTP label :boolean cannot be empty."
        end
        if Hearth::TimeHelper.to_date_time(input[:timestamp]).empty?
          raise ArgumentError, "HTTP label :timestamp cannot be empty."
        end
        http_req.append_path(format(
            '/HttpRequestWithLabels/%<string>s/%<short>s/%<integer>s/%<long>s/%<float>s/%<double>s/%<boolean>s/%<timestamp>s',
            string: Hearth::HTTP.uri_escape(input[:string].to_s),
            short: Hearth::HTTP.uri_escape(input[:short].to_s),
            integer: Hearth::HTTP.uri_escape(input[:integer].to_s),
            long: Hearth::HTTP.uri_escape(input[:long].to_s),
            float: Hearth::HTTP.uri_escape(input[:float].to_s),
            double: Hearth::HTTP.uri_escape(input[:double].to_s),
            boolean: Hearth::HTTP.uri_escape(input[:boolean].to_s),
            timestamp: Hearth::HTTP.uri_escape(Hearth::TimeHelper.to_date_time(input[:timestamp]))
          )
        )
      end
    end

    class HttpRequestWithLabelsAndTimestampFormat
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        if Hearth::TimeHelper.to_epoch_seconds(input[:member_epoch_seconds]).to_i.to_s.empty?
          raise ArgumentError, "HTTP label :member_epoch_seconds cannot be empty."
        end
        if Hearth::TimeHelper.to_http_date(input[:member_http_date]).empty?
          raise ArgumentError, "HTTP label :member_http_date cannot be empty."
        end
        if Hearth::TimeHelper.to_date_time(input[:member_date_time]).empty?
          raise ArgumentError, "HTTP label :member_date_time cannot be empty."
        end
        if Hearth::TimeHelper.to_date_time(input[:default_format]).empty?
          raise ArgumentError, "HTTP label :default_format cannot be empty."
        end
        if Hearth::TimeHelper.to_epoch_seconds(input[:target_epoch_seconds]).to_i.to_s.empty?
          raise ArgumentError, "HTTP label :target_epoch_seconds cannot be empty."
        end
        if Hearth::TimeHelper.to_http_date(input[:target_http_date]).empty?
          raise ArgumentError, "HTTP label :target_http_date cannot be empty."
        end
        if Hearth::TimeHelper.to_date_time(input[:target_date_time]).empty?
          raise ArgumentError, "HTTP label :target_date_time cannot be empty."
        end
        http_req.append_path(format(
            '/HttpRequestWithLabelsAndTimestampFormat/%<memberEpochSeconds>s/%<memberHttpDate>s/%<memberDateTime>s/%<defaultFormat>s/%<targetEpochSeconds>s/%<targetHttpDate>s/%<targetDateTime>s',
            memberEpochSeconds: Hearth::HTTP.uri_escape(Hearth::TimeHelper.to_epoch_seconds(input[:member_epoch_seconds]).to_i.to_s),
            memberHttpDate: Hearth::HTTP.uri_escape(Hearth::TimeHelper.to_http_date(input[:member_http_date])),
            memberDateTime: Hearth::HTTP.uri_escape(Hearth::TimeHelper.to_date_time(input[:member_date_time])),
            defaultFormat: Hearth::HTTP.uri_escape(Hearth::TimeHelper.to_date_time(input[:default_format])),
            targetEpochSeconds: Hearth::HTTP.uri_escape(Hearth::TimeHelper.to_epoch_seconds(input[:target_epoch_seconds]).to_i.to_s),
            targetHttpDate: Hearth::HTTP.uri_escape(Hearth::TimeHelper.to_http_date(input[:target_http_date])),
            targetDateTime: Hearth::HTTP.uri_escape(Hearth::TimeHelper.to_date_time(input[:target_date_time]))
          )
        )
      end
    end

    class HttpRequestWithRegexLiteral
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        if input[:str].to_s.empty?
          raise ArgumentError, "HTTP label :str cannot be empty."
        end
        http_req.append_path(format(
            '/ReDosLiteral/%<str>s/(a+)+',
            str: Hearth::HTTP.uri_escape(input[:str].to_s)
          )
        )
      end
    end

    class HttpResponseCode
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/HttpResponseCode')
      end
    end

    class HttpStringPayload
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/StringPayload')
        http_req.headers['Content-Type'] = 'text/plain'
        http_req.body = StringIO.new(input[:payload] || '')
      end
    end

    class IgnoreQueryParamsInResponse
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/IgnoreQueryParamsInResponse')
      end
    end

    class InputAndOutputWithHeaders
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/InputAndOutputWithHeaders')
        http_req.headers['X-String'] = input[:header_string] unless input[:header_string].nil? || input[:header_string].empty?
        http_req.headers['X-Byte'] = input[:header_byte].to_s unless input[:header_byte].nil?
        http_req.headers['X-Short'] = input[:header_short].to_s unless input[:header_short].nil?
        http_req.headers['X-Integer'] = input[:header_integer].to_s unless input[:header_integer].nil?
        http_req.headers['X-Long'] = input[:header_long].to_s unless input[:header_long].nil?
        http_req.headers['X-Float'] = Hearth::NumberHelper.serialize(input[:header_float]) unless input[:header_float].nil?
        http_req.headers['X-Double'] = Hearth::NumberHelper.serialize(input[:header_double]) unless input[:header_double].nil?
        http_req.headers['X-Boolean1'] = input[:header_true_bool].to_s unless input[:header_true_bool].nil?
        http_req.headers['X-Boolean2'] = input[:header_false_bool].to_s unless input[:header_false_bool].nil?
        unless input[:header_string_list].nil? || input[:header_string_list].empty?
          http_req.headers['X-StringList'] = Hearth::HTTP::HeaderListBuilder.build_string_list(input[:header_string_list])
        end
        unless input[:header_string_set].nil? || input[:header_string_set].empty?
          http_req.headers['X-StringSet'] = Hearth::HTTP::HeaderListBuilder.build_string_list(input[:header_string_set])
        end
        unless input[:header_integer_list].nil? || input[:header_integer_list].empty?
          http_req.headers['X-IntegerList'] = Hearth::HTTP::HeaderListBuilder.build_list(input[:header_integer_list])
        end
        unless input[:header_boolean_list].nil? || input[:header_boolean_list].empty?
          http_req.headers['X-BooleanList'] = Hearth::HTTP::HeaderListBuilder.build_list(input[:header_boolean_list])
        end
        unless input[:header_timestamp_list].nil? || input[:header_timestamp_list].empty?
          http_req.headers['X-TimestampList'] = Hearth::HTTP::HeaderListBuilder.build_http_date_list(input[:header_timestamp_list])
        end
        http_req.headers['X-Enum'] = input[:header_enum] unless input[:header_enum].nil? || input[:header_enum].empty?
        unless input[:header_enum_list].nil? || input[:header_enum_list].empty?
          http_req.headers['X-EnumList'] = Hearth::HTTP::HeaderListBuilder.build_string_list(input[:header_enum_list])
        end
        http_req.headers['X-IntegerEnum'] = input[:header_integer_enum].to_s unless input[:header_integer_enum].nil?
        unless input[:header_integer_enum_list].nil? || input[:header_integer_enum_list].empty?
          http_req.headers['X-IntegerEnumList'] = Hearth::HTTP::HeaderListBuilder.build_list(input[:header_integer_enum_list])
        end
      end
    end

    class IntegerEnumList
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class IntegerEnumMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class IntegerEnumSet
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class IntegerList
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class IntegerSet
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class JsonBlobs
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/JsonBlobs')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:data] = ::Base64::encode64(input[:data]).strip unless input[:data].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class JsonEnums
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/JsonEnums')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:foo_enum1] = input[:foo_enum1] unless input[:foo_enum1].nil?
        data[:foo_enum2] = input[:foo_enum2] unless input[:foo_enum2].nil?
        data[:foo_enum3] = input[:foo_enum3] unless input[:foo_enum3].nil?
        data[:foo_enum_list] = Builders::FooEnumList.build(input[:foo_enum_list]) unless input[:foo_enum_list].nil?
        data[:foo_enum_set] = Builders::FooEnumSet.build(input[:foo_enum_set]) unless input[:foo_enum_set].nil?
        data[:foo_enum_map] = Builders::FooEnumMap.build(input[:foo_enum_map]) unless input[:foo_enum_map].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class JsonIntEnums
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/JsonIntEnums')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:integer_enum1] = input[:integer_enum1] unless input[:integer_enum1].nil?
        data[:integer_enum2] = input[:integer_enum2] unless input[:integer_enum2].nil?
        data[:integer_enum3] = input[:integer_enum3] unless input[:integer_enum3].nil?
        data[:integer_enum_list] = Builders::IntegerEnumList.build(input[:integer_enum_list]) unless input[:integer_enum_list].nil?
        data[:integer_enum_set] = Builders::IntegerEnumSet.build(input[:integer_enum_set]) unless input[:integer_enum_set].nil?
        data[:integer_enum_map] = Builders::IntegerEnumMap.build(input[:integer_enum_map]) unless input[:integer_enum_map].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class JsonLists
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/JsonLists')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:string_list] = Builders::StringList.build(input[:string_list]) unless input[:string_list].nil?
        data[:string_set] = Builders::StringSet.build(input[:string_set]) unless input[:string_set].nil?
        data[:integer_list] = Builders::IntegerList.build(input[:integer_list]) unless input[:integer_list].nil?
        data[:boolean_list] = Builders::BooleanList.build(input[:boolean_list]) unless input[:boolean_list].nil?
        data[:timestamp_list] = Builders::TimestampList.build(input[:timestamp_list]) unless input[:timestamp_list].nil?
        data[:enum_list] = Builders::FooEnumList.build(input[:enum_list]) unless input[:enum_list].nil?
        data[:int_enum_list] = Builders::IntegerEnumList.build(input[:int_enum_list]) unless input[:int_enum_list].nil?
        data[:nested_string_list] = Builders::NestedStringList.build(input[:nested_string_list]) unless input[:nested_string_list].nil?
        data['myStructureList'] = Builders::StructureList.build(input[:structure_list]) unless input[:structure_list].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class JsonMaps
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/JsonMaps')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:dense_struct_map] = Builders::DenseStructMap.build(input[:dense_struct_map]) unless input[:dense_struct_map].nil?
        data[:dense_number_map] = Builders::DenseNumberMap.build(input[:dense_number_map]) unless input[:dense_number_map].nil?
        data[:dense_boolean_map] = Builders::DenseBooleanMap.build(input[:dense_boolean_map]) unless input[:dense_boolean_map].nil?
        data[:dense_string_map] = Builders::DenseStringMap.build(input[:dense_string_map]) unless input[:dense_string_map].nil?
        data[:dense_set_map] = Builders::DenseSetMap.build(input[:dense_set_map]) unless input[:dense_set_map].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class JsonTimestamps
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/JsonTimestamps')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:normal] = Hearth::TimeHelper.to_epoch_seconds(input[:normal]).to_i unless input[:normal].nil?
        data[:date_time] = Hearth::TimeHelper.to_date_time(input[:date_time]) unless input[:date_time].nil?
        data[:date_time_on_target] = Hearth::TimeHelper.to_date_time(input[:date_time_on_target]) unless input[:date_time_on_target].nil?
        data[:epoch_seconds] = Hearth::TimeHelper.to_epoch_seconds(input[:epoch_seconds]).to_i unless input[:epoch_seconds].nil?
        data[:epoch_seconds_on_target] = Hearth::TimeHelper.to_epoch_seconds(input[:epoch_seconds_on_target]).to_i unless input[:epoch_seconds_on_target].nil?
        data[:http_date] = Hearth::TimeHelper.to_http_date(input[:http_date]) unless input[:http_date].nil?
        data[:http_date_on_target] = Hearth::TimeHelper.to_http_date(input[:http_date_on_target]) unless input[:http_date_on_target].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class JsonUnions
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/JsonUnions')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:contents] = Builders::MyUnion.build(input[:contents]) unless input[:contents].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class MediaTypeHeader
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/MediaTypeHeader')
        http_req.headers['X-Json'] = ::Base64::encode64(input[:json]).strip unless input[:json].nil? || input[:json].empty?
      end
    end

    class MyUnion
      def self.build(input)
        data = {}
        case input
        when Types::MyUnion::StringValue
          data[:string_value] = input
        when Types::MyUnion::BooleanValue
          data[:boolean_value] = input
        when Types::MyUnion::NumberValue
          data[:number_value] = input
        when Types::MyUnion::BlobValue
          data[:blob_value] = ::Base64::encode64(input).strip
        when Types::MyUnion::TimestampValue
          data[:timestamp_value] = Hearth::TimeHelper.to_epoch_seconds(input).to_i
        when Types::MyUnion::EnumValue
          data[:enum_value] = input
        when Types::MyUnion::ListValue
          data[:list_value] = (Builders::StringList.build(input) unless input.nil?)
        when Types::MyUnion::MapValue
          data[:map_value] = (Builders::StringMap.build(input) unless input.nil?)
        when Types::MyUnion::StructureValue
          data[:structure_value] = (Builders::GreetingStruct.build(input) unless input.nil?)
        when Types::MyUnion::RenamedStructureValue
          data[:renamed_structure_value] = (Builders::RenamedGreeting.build(input) unless input.nil?)
        else
          raise ArgumentError,
          "Expected input to be one of the subclasses of Types::MyUnion"
        end

        data
      end
    end

    class NestedPayload
      def self.build(input)
        data = {}
        data[:greeting] = input[:greeting] unless input[:greeting].nil?
        data[:name] = input[:name] unless input[:name].nil?
        data
      end
    end

    class NestedStringList
      def self.build(input)
        data = []
        input.each do |element|
          data << Builders::StringList.build(element) unless element.nil?
        end
        data
      end
    end

    class NoInputAndNoOutput
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/NoInputAndNoOutput')
      end
    end

    class NoInputAndOutput
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/NoInputAndOutputOutput')
      end
    end

    class NullAndEmptyHeadersClient
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/NullAndEmptyHeadersClient')
        http_req.headers['X-A'] = input[:a] unless input[:a].nil? || input[:a].empty?
        http_req.headers['X-B'] = input[:b] unless input[:b].nil? || input[:b].empty?
        unless input[:c].nil? || input[:c].empty?
          http_req.headers['X-C'] = Hearth::HTTP::HeaderListBuilder.build_string_list(input[:c])
        end
      end
    end

    class NullAndEmptyHeadersServer
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/NullAndEmptyHeadersServer')
        http_req.headers['X-A'] = input[:a] unless input[:a].nil? || input[:a].empty?
        http_req.headers['X-B'] = input[:b] unless input[:b].nil? || input[:b].empty?
        unless input[:c].nil? || input[:c].empty?
          http_req.headers['X-C'] = Hearth::HTTP::HeaderListBuilder.build_string_list(input[:c])
        end
      end
    end

    class OmitsNullSerializesEmptyString
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/OmitsNullSerializesEmptyString')
        params = Hearth::Query::ParamList.new
        params['Null'] = input[:null_value].to_s unless input[:null_value].nil?
        params['Empty'] = input[:empty_string].to_s unless input[:empty_string].nil?
        http_req.append_query_param_list(params)
      end
    end

    class OmitsSerializingEmptyLists
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/OmitsSerializingEmptyLists')
        params = Hearth::Query::ParamList.new
        unless input[:query_string_list].nil? || input[:query_string_list].empty?
          params['StringList'] = input[:query_string_list].map do |value|
            value.to_s unless value.nil?
          end
        end
        unless input[:query_integer_list].nil? || input[:query_integer_list].empty?
          params['IntegerList'] = input[:query_integer_list].map do |value|
            value.to_s unless value.nil?
          end
        end
        unless input[:query_double_list].nil? || input[:query_double_list].empty?
          params['DoubleList'] = input[:query_double_list].map do |value|
            value.to_s unless value.nil?
          end
        end
        unless input[:query_boolean_list].nil? || input[:query_boolean_list].empty?
          params['BooleanList'] = input[:query_boolean_list].map do |value|
            value.to_s unless value.nil?
          end
        end
        unless input[:query_timestamp_list].nil? || input[:query_timestamp_list].empty?
          params['TimestampList'] = input[:query_timestamp_list].map do |value|
            Hearth::TimeHelper.to_date_time(value) unless value.nil?
          end
        end
        unless input[:query_enum_list].nil? || input[:query_enum_list].empty?
          params['EnumList'] = input[:query_enum_list].map do |value|
            value.to_s unless value.nil?
          end
        end
        unless input[:query_integer_enum_list].nil? || input[:query_integer_enum_list].empty?
          params['IntegerEnumList'] = input[:query_integer_enum_list].map do |value|
            value.to_s unless value.nil?
          end
        end
        http_req.append_query_param_list(params)
      end
    end

    class OperationWithDefaults
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/OperationWithDefaults')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:defaults] = Builders::Defaults.build(input[:defaults]) unless input[:defaults].nil?
        data[:client_optional_defaults] = Builders::ClientOptionalDefaults.build(input[:client_optional_defaults]) unless input[:client_optional_defaults].nil?
        data[:top_level_default] = input[:top_level_default] unless input[:top_level_default].nil?
        data[:other_top_level_default] = input[:other_top_level_default] unless input[:other_top_level_default].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class PayloadConfig
      def self.build(input)
        data = {}
        data[:data] = input[:data] unless input[:data].nil?
        data
      end
    end

    class PlayerAction
      def self.build(input)
        data = {}
        case input
        when Types::PlayerAction::Quit
          data[:quit] = (Builders::Unit.build(input) unless input.nil?)
        else
          raise ArgumentError,
          "Expected input to be one of the subclasses of Types::PlayerAction"
        end

        data
      end
    end

    class PostPlayerAction
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/PostPlayerAction')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:action] = Builders::PlayerAction.build(input[:action]) unless input[:action].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class PostUnionWithJsonName
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/PostUnionWithJsonName')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:value] = Builders::UnionWithJsonName.build(input[:value]) unless input[:value].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class PutWithContentEncoding
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/requestcompression/putcontentwithencoding')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:data] = input[:data] unless input[:data].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
        http_req.headers['Content-Encoding'] = input[:encoding] unless input[:encoding].nil? || input[:encoding].empty?
      end
    end

    class QueryIdempotencyTokenAutoFill
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/QueryIdempotencyTokenAutoFill')
        params = Hearth::Query::ParamList.new
        params['token'] = input[:token].to_s unless input[:token].nil?
        http_req.append_query_param_list(params)
      end
    end

    class QueryParamsAsStringListMap
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/StringListMap')
        params = Hearth::Query::ParamList.new
        unless input[:foo].nil? || input[:foo].empty?
          input[:foo].each do |k, v|
            unless v.nil? || v.empty?
              params[k] = v.map do |value|
                value.to_s unless value.nil?
              end
            end
          end
        end
        params['corge'] = input[:qux].to_s unless input[:qux].nil?
        http_req.append_query_param_list(params)
      end
    end

    class QueryPrecedence
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/Precedence')
        params = Hearth::Query::ParamList.new
        unless input[:baz].nil? || input[:baz].empty?
          input[:baz].each do |k, v|
            params[k] = v.to_s unless v.nil?
          end
        end
        params['bar'] = input[:foo].to_s unless input[:foo].nil?
        http_req.append_query_param_list(params)
      end
    end

    class RecursiveShapes
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/RecursiveShapes')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:nested] = Builders::RecursiveShapesInputOutputNested1.build(input[:nested]) unless input[:nested].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class RecursiveShapesInputOutputNested1
      def self.build(input)
        data = {}
        data[:foo] = input[:foo] unless input[:foo].nil?
        data[:nested] = Builders::RecursiveShapesInputOutputNested2.build(input[:nested]) unless input[:nested].nil?
        data
      end
    end

    class RecursiveShapesInputOutputNested2
      def self.build(input)
        data = {}
        data[:bar] = input[:bar] unless input[:bar].nil?
        data[:recursive_member] = Builders::RecursiveShapesInputOutputNested1.build(input[:recursive_member]) unless input[:recursive_member].nil?
        data
      end
    end

    class SimpleScalarProperties
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/SimpleScalarProperties')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:string_value] = input[:string_value] unless input[:string_value].nil?
        data[:true_boolean_value] = input[:true_boolean_value] unless input[:true_boolean_value].nil?
        data[:false_boolean_value] = input[:false_boolean_value] unless input[:false_boolean_value].nil?
        data[:byte_value] = input[:byte_value] unless input[:byte_value].nil?
        data[:short_value] = input[:short_value] unless input[:short_value].nil?
        data[:integer_value] = input[:integer_value] unless input[:integer_value].nil?
        data[:long_value] = input[:long_value] unless input[:long_value].nil?
        data[:float_value] = Hearth::NumberHelper.serialize(input[:float_value]) unless input[:float_value].nil?
        data['DoubleDribble'] = Hearth::NumberHelper.serialize(input[:double_value]) unless input[:double_value].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
        http_req.headers['X-Foo'] = input[:foo] unless input[:foo].nil? || input[:foo].empty?
      end
    end

    class SparseBooleanMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseJsonLists
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/SparseJsonLists')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:sparse_string_list] = Builders::SparseStringList.build(input[:sparse_string_list]) unless input[:sparse_string_list].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class SparseJsonMaps
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/SparseJsonMaps')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:sparse_struct_map] = Builders::SparseStructMap.build(input[:sparse_struct_map]) unless input[:sparse_struct_map].nil?
        data[:sparse_number_map] = Builders::SparseNumberMap.build(input[:sparse_number_map]) unless input[:sparse_number_map].nil?
        data[:sparse_boolean_map] = Builders::SparseBooleanMap.build(input[:sparse_boolean_map]) unless input[:sparse_boolean_map].nil?
        data[:sparse_string_map] = Builders::SparseStringMap.build(input[:sparse_string_map]) unless input[:sparse_string_map].nil?
        data[:sparse_set_map] = Builders::SparseSetMap.build(input[:sparse_set_map]) unless input[:sparse_set_map].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class SparseNumberMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseSetMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = (Builders::StringSet.build(value) unless value.nil?)
        end
        data
      end
    end

    class SparseStringList
      def self.build(input)
        data = []
        input.each do |element|
          data << element
        end
        data
      end
    end

    class SparseStringMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseStructMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = (Builders::GreetingStruct.build(value) unless value.nil?)
        end
        data
      end
    end

    class StreamingTraits
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/StreamingTraits')
        http_req.body = input[:blob]
        http_req.headers['Transfer-Encoding'] = 'chunked'
        http_req.headers['Content-Type'] = 'application/octet-stream'
        http_req.headers['X-Foo'] = input[:foo] unless input[:foo].nil? || input[:foo].empty?
      end
    end

    class StreamingTraitsRequireLength
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/StreamingTraitsRequireLength')
        http_req.body = input[:blob]
        http_req.headers['Content-Type'] = 'application/octet-stream'
        http_req.headers['X-Foo'] = input[:foo] unless input[:foo].nil? || input[:foo].empty?
      end
    end

    class StreamingTraitsWithMediaType
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/StreamingTraitsWithMediaType')
        http_req.body = input[:blob]
        http_req.headers['Transfer-Encoding'] = 'chunked'
        http_req.headers['Content-Type'] = 'text/plain'
        http_req.headers['X-Foo'] = input[:foo] unless input[:foo].nil? || input[:foo].empty?
      end
    end

    class StringList
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class StringListMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = Builders::StringList.build(value) unless value.nil?
        end
        data
      end
    end

    class StringMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class StringSet
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class StructureList
      def self.build(input)
        data = []
        input.each do |element|
          data << Builders::StructureListMember.build(element) unless element.nil?
        end
        data
      end
    end

    class StructureListMember
      def self.build(input)
        data = {}
        data['value'] = input[:a] unless input[:a].nil?
        data['other'] = input[:b] unless input[:b].nil?
        data
      end
    end

    class TestBodyStructure
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/body')
        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:test_config] = Builders::TestConfig.build(input[:test_config]) unless input[:test_config].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
        http_req.headers['x-amz-test-id'] = input[:test_id] unless input[:test_id].nil? || input[:test_id].empty?
      end
    end

    class TestConfig
      def self.build(input)
        data = {}
        data[:timeout] = input[:timeout] unless input[:timeout].nil?
        data
      end
    end

    class TestNoPayload
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/no_payload')
        http_req.headers['X-Amz-Test-Id'] = input[:test_id] unless input[:test_id].nil? || input[:test_id].empty?
      end
    end

    class TestPayloadBlob
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/blob_payload')
        http_req.headers['Content-Type'] = 'application/octet-stream'
        http_req.body = StringIO.new(input[:data] || '')
        http_req.headers['Content-Type'] = input[:content_type] unless input[:content_type].nil? || input[:content_type].empty?
      end
    end

    class TestPayloadStructure
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/payload')
        http_req.headers['Content-Type'] = 'application/json'
        data = Builders::PayloadConfig.build(input[:payload_config]) unless input[:payload_config].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data || {}))
        http_req.headers['x-amz-test-id'] = input[:test_id] unless input[:test_id].nil? || input[:test_id].empty?
      end
    end

    class TestStringList
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class TestStringMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class TimestampFormatHeaders
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/TimestampFormatHeaders')
        http_req.headers['X-memberEpochSeconds'] = Hearth::TimeHelper.to_epoch_seconds(input[:member_epoch_seconds]).to_i unless input[:member_epoch_seconds].nil?
        http_req.headers['X-memberHttpDate'] = Hearth::TimeHelper.to_http_date(input[:member_http_date]) unless input[:member_http_date].nil?
        http_req.headers['X-memberDateTime'] = Hearth::TimeHelper.to_date_time(input[:member_date_time]) unless input[:member_date_time].nil?
        http_req.headers['X-defaultFormat'] = Hearth::TimeHelper.to_http_date(input[:default_format]) unless input[:default_format].nil?
        http_req.headers['X-targetEpochSeconds'] = Hearth::TimeHelper.to_epoch_seconds(input[:target_epoch_seconds]).to_i unless input[:target_epoch_seconds].nil?
        http_req.headers['X-targetHttpDate'] = Hearth::TimeHelper.to_http_date(input[:target_http_date]) unless input[:target_http_date].nil?
        http_req.headers['X-targetDateTime'] = Hearth::TimeHelper.to_date_time(input[:target_date_time]) unless input[:target_date_time].nil?
      end
    end

    class TimestampList
      def self.build(input)
        data = []
        input.each do |element|
          data << Hearth::TimeHelper.to_date_time(element) unless element.nil?
        end
        data
      end
    end

    class UnionPayload
      def self.build(input)
        data = {}
        case input
        when Types::UnionPayload::Greeting
          data[:greeting] = input
        else
          raise ArgumentError,
          "Expected input to be one of the subclasses of Types::UnionPayload"
        end

        data
      end
    end

    class UnionWithJsonName
      def self.build(input)
        data = {}
        case input
        when Types::UnionWithJsonName::Foo
          data['FOO'] = input
        when Types::UnionWithJsonName::Bar
          data[:bar] = input
        when Types::UnionWithJsonName::Baz
          data['_baz'] = input
        else
          raise ArgumentError,
          "Expected input to be one of the subclasses of Types::UnionWithJsonName"
        end

        data
      end
    end

    class Unit
      def self.build(input)
        data = {}
        data
      end
    end

    class UnitInputAndOutput
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/UnitInputAndOutput')
      end
    end
  end
end
