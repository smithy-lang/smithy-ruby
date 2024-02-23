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
        unless input[:query_params_map_of_strings].nil? || input[:query_params_map_of_strings].empty?
          input[:query_params_map_of_strings].each do |k, v|
            params[k] = v.to_s unless v.nil?
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
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
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
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:string_value] = input[:string_value] unless input[:string_value].nil?
        data[:document_value] = input[:document_value] unless input[:document_value].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class DocumentTypeAsPayload
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/DocumentTypeAsPayload')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
        http_req.headers['Content-Type'] = 'application/json'
        http_req.body = StringIO.new(Hearth::JSON.dump(input[:document_value]))
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

    class EmptyOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/emptyoperation')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
      end
    end

    class EmptyStruct
      def self.build(input)
        data = {}
        data
      end
    end

    class EndpointOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/endpoint')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
      end
    end

    class EndpointWithHostLabelOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/endpointwithhostlabel')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:label_member] = input[:label_member] unless input[:label_member].nil?
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

    class RenamedGreeting
      def self.build(input)
        data = {}
        data[:salutation] = input[:salutation] unless input[:salutation].nil?
        data
      end
    end

    class GreetingStruct
      def self.build(input)
        data = {}
        data[:hi] = input[:hi] unless input[:hi].nil?
        data
      end
    end

    class GreetingWithErrors
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/greetingwitherrors')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
      end
    end

    class HttpPayloadTraits
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/HttpPayloadTraits')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
        http_req.headers['Content-Type'] = 'application/octet-stream'
        http_req.body = StringIO.new(input[:blob] || '')
        http_req.headers['X-Foo'] = input[:foo] unless input[:foo].nil? || input[:foo].empty?
      end
    end

    class HttpPayloadTraitsWithMediaType
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/HttpPayloadTraitsWithMediaType')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
        http_req.headers['Content-Type'] = 'text/plain'
        http_req.body = StringIO.new(input[:blob] || '')
        http_req.headers['X-Foo'] = input[:foo] unless input[:foo].nil? || input[:foo].empty?
      end
    end

    class HttpPayloadWithStructure
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/HttpPayloadWithStructure')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
        http_req.headers['Content-Type'] = 'application/json'
        data = Builders::NestedPayload.build(input[:nested]) unless input[:nested].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class HttpPrefixHeaders
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/HttpPrefixHeaders')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
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
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
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
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
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
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
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
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
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
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
      end
    end

    class HttpResponseCode
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/HttpResponseCode')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
      end
    end

    class IgnoreQueryParamsInResponse
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/IgnoreQueryParamsInResponse')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
      end
    end

    class InputAndOutputWithHeaders
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/InputAndOutputWithHeaders')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
        http_req.headers['X-String'] = input[:header_string] unless input[:header_string].nil? || input[:header_string].empty?
        http_req.headers['X-Byte'] = input[:header_byte].to_s unless input[:header_byte].nil?
        http_req.headers['X-Short'] = input[:header_short].to_s unless input[:header_short].nil?
        http_req.headers['X-Integer'] = input[:header_integer].to_s unless input[:header_integer].nil?
        http_req.headers['X-Long'] = input[:header_long].to_s unless input[:header_long].nil?
        http_req.headers['X-Float'] = Hearth::NumberHelper.serialize(input[:header_float]) unless input[:header_float].nil?
        http_req.headers['X-Double'] = Hearth::NumberHelper.serialize(input[:header_double]) unless input[:header_double].nil?
        http_req.headers['X-Boolean1'] = input[:header_true_bool].to_s unless input[:header_true_bool].nil?
        http_req.headers['X-Boolean2'] = input[:header_false_bool].to_s unless input[:header_false_bool].nil?
        http_req.headers['X-StringList'] = input[:header_string_list] unless input[:header_string_list].nil? || input[:header_string_list].empty?
        http_req.headers['X-StringSet'] = input[:header_string_set] unless input[:header_string_set].nil? || input[:header_string_set].empty?
        http_req.headers['X-IntegerList'] = input[:header_integer_list] unless input[:header_integer_list].nil? || input[:header_integer_list].empty?
        http_req.headers['X-BooleanList'] = input[:header_boolean_list] unless input[:header_boolean_list].nil? || input[:header_boolean_list].empty?
        http_req.headers['X-TimestampList'] = input[:header_timestamp_list] unless input[:header_timestamp_list].nil? || input[:header_timestamp_list].empty?
        http_req.headers['X-Enum'] = input[:header_enum] unless input[:header_enum].nil? || input[:header_enum].empty?
        http_req.headers['X-EnumList'] = input[:header_enum_list] unless input[:header_enum_list].nil? || input[:header_enum_list].empty?
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

    class JsonEnums
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/jsonenums')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)

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

    class JsonMaps
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/JsonMaps')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:dense_struct_map] = Builders::DenseStructMap.build(input[:dense_struct_map]) unless input[:dense_struct_map].nil?
        data[:sparse_struct_map] = Builders::SparseStructMap.build(input[:sparse_struct_map]) unless input[:sparse_struct_map].nil?
        data[:dense_number_map] = Builders::DenseNumberMap.build(input[:dense_number_map]) unless input[:dense_number_map].nil?
        data[:dense_boolean_map] = Builders::DenseBooleanMap.build(input[:dense_boolean_map]) unless input[:dense_boolean_map].nil?
        data[:dense_string_map] = Builders::DenseStringMap.build(input[:dense_string_map]) unless input[:dense_string_map].nil?
        data[:sparse_number_map] = Builders::SparseNumberMap.build(input[:sparse_number_map]) unless input[:sparse_number_map].nil?
        data[:sparse_boolean_map] = Builders::SparseBooleanMap.build(input[:sparse_boolean_map]) unless input[:sparse_boolean_map].nil?
        data[:sparse_string_map] = Builders::SparseStringMap.build(input[:sparse_string_map]) unless input[:sparse_string_map].nil?
        data[:dense_set_map] = Builders::DenseSetMap.build(input[:dense_set_map]) unless input[:dense_set_map].nil?
        data[:sparse_set_map] = Builders::SparseSetMap.build(input[:sparse_set_map]) unless input[:sparse_set_map].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class JsonUnions
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/jsonunions')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:contents] = Builders::MyUnion.build(input[:contents]) unless input[:contents].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class KitchenSink
      def self.build(input)
        data = {}
        data[:blob] = ::Base64::encode64(input[:blob]).strip unless input[:blob].nil?
        data[:boolean] = input[:boolean] unless input[:boolean].nil?
        data[:double] = Hearth::NumberHelper.serialize(input[:double]) unless input[:double].nil?
        data[:empty_struct] = Builders::EmptyStruct.build(input[:empty_struct]) unless input[:empty_struct].nil?
        data[:float] = Hearth::NumberHelper.serialize(input[:float]) unless input[:float].nil?
        data[:httpdate_timestamp] = Hearth::TimeHelper.to_http_date(input[:httpdate_timestamp]) unless input[:httpdate_timestamp].nil?
        data[:integer] = input[:integer] unless input[:integer].nil?
        data[:iso8601_timestamp] = Hearth::TimeHelper.to_date_time(input[:iso8601_timestamp]) unless input[:iso8601_timestamp].nil?
        data[:json_value] = input[:json_value] unless input[:json_value].nil?
        data[:list_of_lists] = Builders::ListOfListOfStrings.build(input[:list_of_lists]) unless input[:list_of_lists].nil?
        data[:list_of_maps_of_strings] = Builders::ListOfMapsOfStrings.build(input[:list_of_maps_of_strings]) unless input[:list_of_maps_of_strings].nil?
        data[:list_of_strings] = Builders::ListOfStrings.build(input[:list_of_strings]) unless input[:list_of_strings].nil?
        data[:list_of_structs] = Builders::ListOfStructs.build(input[:list_of_structs]) unless input[:list_of_structs].nil?
        data[:long] = input[:long] unless input[:long].nil?
        data[:map_of_lists_of_strings] = Builders::MapOfListsOfStrings.build(input[:map_of_lists_of_strings]) unless input[:map_of_lists_of_strings].nil?
        data[:map_of_maps] = Builders::MapOfMapOfStrings.build(input[:map_of_maps]) unless input[:map_of_maps].nil?
        data[:map_of_strings] = Builders::MapOfStrings.build(input[:map_of_strings]) unless input[:map_of_strings].nil?
        data[:map_of_structs] = Builders::MapOfStructs.build(input[:map_of_structs]) unless input[:map_of_structs].nil?
        data[:recursive_list] = Builders::ListOfKitchenSinks.build(input[:recursive_list]) unless input[:recursive_list].nil?
        data[:recursive_map] = Builders::MapOfKitchenSinks.build(input[:recursive_map]) unless input[:recursive_map].nil?
        data[:recursive_struct] = Builders::KitchenSink.build(input[:recursive_struct]) unless input[:recursive_struct].nil?
        data[:simple_struct] = Builders::SimpleStruct.build(input[:simple_struct]) unless input[:simple_struct].nil?
        data[:string] = input[:string] unless input[:string].nil?
        data[:struct_with_location_name] = Builders::StructWithLocationName.build(input[:struct_with_location_name]) unless input[:struct_with_location_name].nil?
        data[:timestamp] = Hearth::TimeHelper.to_date_time(input[:timestamp]) unless input[:timestamp].nil?
        data[:unix_timestamp] = Hearth::TimeHelper.to_epoch_seconds(input[:unix_timestamp]).to_i unless input[:unix_timestamp].nil?
        data
      end
    end

    class KitchenSinkOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:blob] = ::Base64::encode64(input[:blob]).strip unless input[:blob].nil?
        data[:boolean] = input[:boolean] unless input[:boolean].nil?
        data[:double] = Hearth::NumberHelper.serialize(input[:double]) unless input[:double].nil?
        data[:empty_struct] = Builders::EmptyStruct.build(input[:empty_struct]) unless input[:empty_struct].nil?
        data[:float] = Hearth::NumberHelper.serialize(input[:float]) unless input[:float].nil?
        data[:httpdate_timestamp] = Hearth::TimeHelper.to_http_date(input[:httpdate_timestamp]) unless input[:httpdate_timestamp].nil?
        data[:integer] = input[:integer] unless input[:integer].nil?
        data[:iso8601_timestamp] = Hearth::TimeHelper.to_date_time(input[:iso8601_timestamp]) unless input[:iso8601_timestamp].nil?
        data[:json_value] = input[:json_value] unless input[:json_value].nil?
        data[:list_of_lists] = Builders::ListOfListOfStrings.build(input[:list_of_lists]) unless input[:list_of_lists].nil?
        data[:list_of_maps_of_strings] = Builders::ListOfMapsOfStrings.build(input[:list_of_maps_of_strings]) unless input[:list_of_maps_of_strings].nil?
        data[:list_of_strings] = Builders::ListOfStrings.build(input[:list_of_strings]) unless input[:list_of_strings].nil?
        data[:list_of_structs] = Builders::ListOfStructs.build(input[:list_of_structs]) unless input[:list_of_structs].nil?
        data[:long] = input[:long] unless input[:long].nil?
        data[:map_of_lists_of_strings] = Builders::MapOfListsOfStrings.build(input[:map_of_lists_of_strings]) unless input[:map_of_lists_of_strings].nil?
        data[:map_of_maps] = Builders::MapOfMapOfStrings.build(input[:map_of_maps]) unless input[:map_of_maps].nil?
        data[:map_of_strings] = Builders::MapOfStrings.build(input[:map_of_strings]) unless input[:map_of_strings].nil?
        data[:map_of_structs] = Builders::MapOfStructs.build(input[:map_of_structs]) unless input[:map_of_structs].nil?
        data[:recursive_list] = Builders::ListOfKitchenSinks.build(input[:recursive_list]) unless input[:recursive_list].nil?
        data[:recursive_map] = Builders::MapOfKitchenSinks.build(input[:recursive_map]) unless input[:recursive_map].nil?
        data[:recursive_struct] = Builders::KitchenSink.build(input[:recursive_struct]) unless input[:recursive_struct].nil?
        data[:simple_struct] = Builders::SimpleStruct.build(input[:simple_struct]) unless input[:simple_struct].nil?
        data[:string] = input[:string] unless input[:string].nil?
        data[:struct_with_location_name] = Builders::StructWithLocationName.build(input[:struct_with_location_name]) unless input[:struct_with_location_name].nil?
        data[:timestamp] = Hearth::TimeHelper.to_date_time(input[:timestamp]) unless input[:timestamp].nil?
        data[:unix_timestamp] = Hearth::TimeHelper.to_epoch_seconds(input[:unix_timestamp]).to_i unless input[:unix_timestamp].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class ListOfKitchenSinks
      def self.build(input)
        data = []
        input.each do |element|
          data << Builders::KitchenSink.build(element) unless element.nil?
        end
        data
      end
    end

    class ListOfListOfStrings
      def self.build(input)
        data = []
        input.each do |element|
          data << Builders::ListOfStrings.build(element) unless element.nil?
        end
        data
      end
    end

    class ListOfMapsOfStrings
      def self.build(input)
        data = []
        input.each do |element|
          data << Builders::MapOfStrings.build(element) unless element.nil?
        end
        data
      end
    end

    class ListOfStrings
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class ListOfStructs
      def self.build(input)
        data = []
        input.each do |element|
          data << Builders::SimpleStruct.build(element) unless element.nil?
        end
        data
      end
    end

    class MapOfKitchenSinks
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = Builders::KitchenSink.build(value) unless value.nil?
        end
        data
      end
    end

    class MapOfListsOfStrings
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = Builders::ListOfStrings.build(value) unless value.nil?
        end
        data
      end
    end

    class MapOfMapOfStrings
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = Builders::MapOfStrings.build(value) unless value.nil?
        end
        data
      end
    end

    class MapOfStrings
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class MapOfStructs
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = Builders::SimpleStruct.build(value) unless value.nil?
        end
        data
      end
    end

    class MediaTypeHeader
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/MediaTypeHeader')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
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
          data[:timestamp_value] = Hearth::TimeHelper.to_date_time(input)
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

    class NestedAttributesOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/nestedattributes')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:simple_struct_attributes] = Builders::SimpleStruct.build(input[:simple_struct]) unless input[:simple_struct].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
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

    class NullAndEmptyHeadersClient
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/NullAndEmptyHeadersClient')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
        http_req.headers['X-A'] = input[:a] unless input[:a].nil? || input[:a].empty?
        http_req.headers['X-B'] = input[:b] unless input[:b].nil? || input[:b].empty?
        http_req.headers['X-C'] = input[:c] unless input[:c].nil? || input[:c].empty?
      end
    end

    class NullOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/nulloperation')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:string] = input[:string] unless input[:string].nil?
        data[:sparse_string_list] = Builders::SparseStringList.build(input[:sparse_string_list]) unless input[:sparse_string_list].nil?
        data[:sparse_string_map] = Builders::SparseStringMap.build(input[:sparse_string_map]) unless input[:sparse_string_map].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
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

    class OperationWithOptionalInputOutput
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/operationwithoptionalinputoutput')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:value] = input[:value] unless input[:value].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
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

    class SimpleStruct
      def self.build(input)
        data = {}
        data[:value] = input[:value] unless input[:value].nil?
        data
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

    class StreamingOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/streamingoperation')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
        http_req.body = input[:output]
        http_req.headers['Transfer-Encoding'] = 'chunked'
        http_req.headers['Content-Type'] = 'application/octet-stream'
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

    class StructWithLocationName
      def self.build(input)
        data = {}
        data['RenamedMember'] = input[:value] unless input[:value].nil?
        data
      end
    end

    class TimestampFormatHeaders
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/TimestampFormatHeaders')
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)
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

    class Struct____456efg
      def self.build(input)
        data = {}
        data[:__123foo] = input[:member___123foo] unless input[:member___123foo].nil?
        data
      end
    end

    class Operation____789BadName
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        if input[:member___123abc].to_s.empty?
          raise ArgumentError, "HTTP label :member___123abc cannot be empty."
        end
        http_req.append_path(format(
            '/BadName/%<__123abc>s',
            __123abc: Hearth::HTTP.uri_escape(input[:member___123abc].to_s)
          )
        )
        params = Hearth::Query::ParamList.new
        http_req.append_query_param_list(params)

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:member] = Builders::Struct____456efg.build(input[:member]) unless input[:member].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end
  end
end
