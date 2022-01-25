# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'base64'

module RailsJson
  module Builders

    # Operation Builder for AllQueryStringTypes
    class AllQueryStringTypes
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/AllQueryStringTypesInput')
        unless input[:query_params_map_of_strings].nil? || input[:query_params_map_of_strings].empty?
          input[:query_params_map_of_strings].each do |k, v|
            http_req.append_query_param(k, v.to_s) unless v.nil?
          end
        end
        http_req.append_query_param('String', input[:query_string].to_s) unless input[:query_string].nil?
        unless input[:query_string_list].nil? || input[:query_string_list].empty?
          input[:query_string_list].each do |value|
            http_req.append_query_param('StringList', value.to_s) unless value.nil?
          end
        end
        unless input[:query_string_set].nil? || input[:query_string_set].empty?
          input[:query_string_set].each do |value|
            http_req.append_query_param('StringSet', value.to_s) unless value.nil?
          end
        end
        http_req.append_query_param('Byte', input[:query_byte].to_s) unless input[:query_byte].nil?
        http_req.append_query_param('Short', input[:query_short].to_s) unless input[:query_short].nil?
        http_req.append_query_param('Integer', input[:query_integer].to_s) unless input[:query_integer].nil?
        unless input[:query_integer_list].nil? || input[:query_integer_list].empty?
          input[:query_integer_list].each do |value|
            http_req.append_query_param('IntegerList', value.to_s) unless value.nil?
          end
        end
        unless input[:query_integer_set].nil? || input[:query_integer_set].empty?
          input[:query_integer_set].each do |value|
            http_req.append_query_param('IntegerSet', value.to_s) unless value.nil?
          end
        end
        http_req.append_query_param('Long', input[:query_long].to_s) unless input[:query_long].nil?
        http_req.append_query_param('Float', input[:query_float].to_s) unless input[:query_float].nil?
        http_req.append_query_param('Double', input[:query_double].to_s) unless input[:query_double].nil?
        unless input[:query_double_list].nil? || input[:query_double_list].empty?
          input[:query_double_list].each do |value|
            http_req.append_query_param('DoubleList', value.to_s) unless value.nil?
          end
        end
        http_req.append_query_param('Boolean', input[:query_boolean].to_s) unless input[:query_boolean].nil?
        unless input[:query_boolean_list].nil? || input[:query_boolean_list].empty?
          input[:query_boolean_list].each do |value|
            http_req.append_query_param('BooleanList', value.to_s) unless value.nil?
          end
        end
        http_req.append_query_param('Timestamp', Seahorse::TimeHelper.to_date_time(input[:query_timestamp])) unless input[:query_timestamp].nil?
        unless input[:query_timestamp_list].nil? || input[:query_timestamp_list].empty?
          input[:query_timestamp_list].each do |value|
            http_req.append_query_param('TimestampList', Seahorse::TimeHelper.to_date_time(value)) unless value.nil?
          end
        end
        http_req.append_query_param('Enum', input[:query_enum].to_s) unless input[:query_enum].nil?
        unless input[:query_enum_list].nil? || input[:query_enum_list].empty?
          input[:query_enum_list].each do |value|
            http_req.append_query_param('EnumList', value.to_s) unless value.nil?
          end
        end
      end
    end

    # Map Builder for StringMap
    class StringMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    # List Builder for FooEnumList
    class FooEnumList
      def self.build(input)
        data = []
        input.each do |element|
          data << element
        end
        data
      end
    end

    # List Builder for TimestampList
    class TimestampList
      def self.build(input)
        data = []
        input.each do |element|
          data << Seahorse::TimeHelper.to_date_time(element)
        end
        data
      end
    end

    # List Builder for BooleanList
    class BooleanList
      def self.build(input)
        data = []
        input.each do |element|
          data << element
        end
        data
      end
    end

    # List Builder for DoubleList
    class DoubleList
      def self.build(input)
        data = []
        input.each do |element|
          data << element
        end
        data
      end
    end

    # Set Builder for IntegerSet

    class IntegerSet
      def self.build(input)
        data = Set.new
        input.each do |element|
          data << element
        end
        data
      end
    end

    # List Builder for IntegerList
    class IntegerList
      def self.build(input)
        data = []
        input.each do |element|
          data << element
        end
        data
      end
    end

    # Set Builder for StringSet

    class StringSet
      def self.build(input)
        data = Set.new
        input.each do |element|
          data << element
        end
        data
      end
    end

    # List Builder for StringList
    class StringList
      def self.build(input)
        data = []
        input.each do |element|
          data << element
        end
        data
      end
    end

    # Operation Builder for ConstantAndVariableQueryString
    class ConstantAndVariableQueryString
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        CGI.parse('foo=bar').each do |k,v|
          v.each { |q_v| http_req.append_query_param(k, q_v) }
        end
        http_req.append_path('/ConstantAndVariableQueryString')
        http_req.append_query_param('baz', input[:baz].to_s) unless input[:baz].nil?
        http_req.append_query_param('maybeSet', input[:maybe_set].to_s) unless input[:maybe_set].nil?
      end
    end

    # Operation Builder for ConstantQueryString
    class ConstantQueryString
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        CGI.parse('foo=bar&hello').each do |k,v|
          v.each { |q_v| http_req.append_query_param(k, q_v) }
        end
        http_req.append_path(format(
            '/ConstantQueryString/%<hello>s',
            hello: Seahorse::HTTP.uri_escape(input[:hello].to_s)
          )
        )
      end
    end

    # Operation Builder for EmptyOperation
    class EmptyOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/emptyoperation')
      end
    end

    # Operation Builder for EndpointOperation
    class EndpointOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/endpoint')
      end
    end

    # Operation Builder for EndpointWithHostLabelOperation
    class EndpointWithHostLabelOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/endpointwithhostlabel')

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:label] = input[:label] unless input[:label].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Operation Builder for GreetingWithErrors
    class GreetingWithErrors
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/greetingwitherrors')
      end
    end

    # Operation Builder for HttpPayloadTraits
    class HttpPayloadTraits
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/HttpPayloadTraits')
        http_req.headers['Content-Type'] = 'application/octet-stream'
        http_req.body = StringIO.new(input[:blob] || '')
        http_req.headers['X-Foo'] = input[:foo] unless input[:foo].nil? || input[:foo].empty?
      end
    end

    # Operation Builder for HttpPayloadTraitsWithMediaType
    class HttpPayloadTraitsWithMediaType
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/HttpPayloadTraitsWithMediaType')
        http_req.headers['Content-Type'] = 'text/plain'
        http_req.body = StringIO.new(input[:blob] || '')
        http_req.headers['X-Foo'] = input[:foo] unless input[:foo].nil? || input[:foo].empty?
      end
    end

    # Operation Builder for HttpPayloadWithStructure
    class HttpPayloadWithStructure
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/HttpPayloadWithStructure')
        http_req.headers['Content-Type'] = 'application/json'
        data = Builders::NestedPayload.build(input[:nested]) unless input[:nested].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Structure Builder for NestedPayload
    class NestedPayload
      def self.build(input)
        data = {}
        data[:greeting] = input[:greeting] unless input[:greeting].nil?
        data[:name] = input[:member_name] unless input[:member_name].nil?
        data
      end
    end

    # Operation Builder for HttpPrefixHeaders
    class HttpPrefixHeaders
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/HttpPrefixHeaders')
        http_req.headers['X-Foo'] = input[:foo] unless input[:foo].nil? || input[:foo].empty?
        input[:foo_map].each do |key, value|
          http_req.headers["X-Foo-#{key}"] = value unless value.nil? || value.empty?
        end
      end
    end

    # Operation Builder for HttpPrefixHeadersInResponse
    class HttpPrefixHeadersInResponse
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/HttpPrefixHeadersResponse')
      end
    end

    # Operation Builder for HttpRequestWithFloatLabels
    class HttpRequestWithFloatLabels
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path(format(
            '/FloatHttpLabels/%<float>s/%<double>s',
            float: Seahorse::HTTP.uri_escape(input[:float].to_s),
            double: Seahorse::HTTP.uri_escape(input[:double].to_s)
          )
        )
      end
    end

    # Operation Builder for HttpRequestWithGreedyLabelInPath
    class HttpRequestWithGreedyLabelInPath
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path(format(
            '/HttpRequestWithGreedyLabelInPath/foo/%<foo>s/baz/%<baz>s',
            foo: Seahorse::HTTP.uri_escape(input[:foo].to_s),
            baz: (input[:baz].to_s).split('/').map { |s| Seahorse::HTTP.uri_escape(s) }.join('/')
          )
        )
      end
    end

    # Operation Builder for HttpRequestWithLabels
    class HttpRequestWithLabels
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path(format(
            '/HttpRequestWithLabels/%<string>s/%<short>s/%<integer>s/%<long>s/%<float>s/%<double>s/%<boolean>s/%<timestamp>s',
            string: Seahorse::HTTP.uri_escape(input[:string].to_s),
            short: Seahorse::HTTP.uri_escape(input[:short].to_s),
            integer: Seahorse::HTTP.uri_escape(input[:integer].to_s),
            long: Seahorse::HTTP.uri_escape(input[:long].to_s),
            float: Seahorse::HTTP.uri_escape(input[:float].to_s),
            double: Seahorse::HTTP.uri_escape(input[:double].to_s),
            boolean: Seahorse::HTTP.uri_escape(input[:boolean].to_s),
            timestamp: Seahorse::HTTP.uri_escape(Seahorse::TimeHelper.to_date_time(input[:timestamp]))
          )
        )
      end
    end

    # Operation Builder for HttpRequestWithLabelsAndTimestampFormat
    class HttpRequestWithLabelsAndTimestampFormat
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path(format(
            '/HttpRequestWithLabelsAndTimestampFormat/%<memberEpochSeconds>s/%<memberHttpDate>s/%<memberDateTime>s/%<defaultFormat>s/%<targetEpochSeconds>s/%<targetHttpDate>s/%<targetDateTime>s',
            memberEpochSeconds: Seahorse::HTTP.uri_escape(Seahorse::TimeHelper.to_epoch_seconds(input[:member_epoch_seconds]).to_i.to_s),
            memberHttpDate: Seahorse::HTTP.uri_escape(Seahorse::TimeHelper.to_http_date(input[:member_http_date])),
            memberDateTime: Seahorse::HTTP.uri_escape(Seahorse::TimeHelper.to_date_time(input[:member_date_time])),
            defaultFormat: Seahorse::HTTP.uri_escape(Seahorse::TimeHelper.to_date_time(input[:default_format])),
            targetEpochSeconds: Seahorse::HTTP.uri_escape(Seahorse::TimeHelper.to_epoch_seconds(input[:target_epoch_seconds]).to_i.to_s),
            targetHttpDate: Seahorse::HTTP.uri_escape(Seahorse::TimeHelper.to_http_date(input[:target_http_date])),
            targetDateTime: Seahorse::HTTP.uri_escape(Seahorse::TimeHelper.to_date_time(input[:target_date_time]))
          )
        )
      end
    end

    # Operation Builder for HttpResponseCode
    class HttpResponseCode
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path('/HttpResponseCode')
      end
    end

    # Operation Builder for IgnoreQueryParamsInResponse
    class IgnoreQueryParamsInResponse
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/IgnoreQueryParamsInResponse')
      end
    end

    # Operation Builder for InputAndOutputWithHeaders
    class InputAndOutputWithHeaders
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/InputAndOutputWithHeaders')
        http_req.headers['X-String'] = input[:header_string] unless input[:header_string].nil? || input[:header_string].empty?
        http_req.headers['X-Byte'] = input[:header_byte].to_s unless input[:header_byte].nil?
        http_req.headers['X-Short'] = input[:header_short].to_s unless input[:header_short].nil?
        http_req.headers['X-Integer'] = input[:header_integer].to_s unless input[:header_integer].nil?
        http_req.headers['X-Long'] = input[:header_long].to_s unless input[:header_long].nil?
        http_req.headers['X-Float'] = Seahorse::NumberHelper.serialize(input[:header_float]) unless input[:header_float].nil?
        http_req.headers['X-Double'] = Seahorse::NumberHelper.serialize(input[:header_double]) unless input[:header_double].nil?
        http_req.headers['X-Boolean1'] = input[:header_true_bool].to_s unless input[:header_true_bool].nil?
        http_req.headers['X-Boolean2'] = input[:header_false_bool].to_s unless input[:header_false_bool].nil?
        unless input[:header_string_list].nil? || input[:header_string_list].empty?
          http_req.headers['X-StringList'] = input[:header_string_list]
            .compact
            .map { |s| (s.include?('"') || s.include?(",")) ? "\"#{s.gsub('"', '\"')}\"" : s }
            .join(', ')
        end
        unless input[:header_string_set].nil? || input[:header_string_set].empty?
          http_req.headers['X-StringSet'] = input[:header_string_set]
            .to_a
            .compact
            .map { |s| (s.include?('"') || s.include?(",")) ? "\"#{s.gsub('"', '\"')}\"" : s }
            .join(', ')
        end
        unless input[:header_integer_list].nil? || input[:header_integer_list].empty?
          http_req.headers['X-IntegerList'] = input[:header_integer_list]
            .compact
            .map { |s| s.to_s }
            .join(', ')
        end
        unless input[:header_boolean_list].nil? || input[:header_boolean_list].empty?
          http_req.headers['X-BooleanList'] = input[:header_boolean_list]
            .compact
            .map { |s| s.to_s }
            .join(', ')
        end
        unless input[:header_timestamp_list].nil? || input[:header_timestamp_list].empty?
          http_req.headers['X-TimestampList'] = input[:header_timestamp_list]
            .compact
            .map { |s| Seahorse::TimeHelper.to_http_date(s) }
            .join(', ')
        end
        http_req.headers['X-Enum'] = input[:header_enum] unless input[:header_enum].nil? || input[:header_enum].empty?
        unless input[:header_enum_list].nil? || input[:header_enum_list].empty?
          http_req.headers['X-EnumList'] = input[:header_enum_list]
            .compact
            .map { |s| (s.include?('"') || s.include?(",")) ? "\"#{s.gsub('"', '\"')}\"" : s }
            .join(', ')
        end
      end
    end

    # Operation Builder for JsonEnums
    class JsonEnums
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/jsonenums')

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:foo_enum1] = input[:foo_enum1] unless input[:foo_enum1].nil?
        data[:foo_enum2] = input[:foo_enum2] unless input[:foo_enum2].nil?
        data[:foo_enum3] = input[:foo_enum3] unless input[:foo_enum3].nil?
        data[:foo_enum_list] = Builders::FooEnumList.build(input[:foo_enum_list]) unless input[:foo_enum_list].nil?
        data[:foo_enum_set] = Builders::FooEnumSet.build(input[:foo_enum_set]).to_a unless input[:foo_enum_set].nil?
        data[:foo_enum_map] = Builders::FooEnumMap.build(input[:foo_enum_map]) unless input[:foo_enum_map].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Map Builder for FooEnumMap
    class FooEnumMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    # Set Builder for FooEnumSet

    class FooEnumSet
      def self.build(input)
        data = Set.new
        input.each do |element|
          data << element
        end
        data
      end
    end

    # Operation Builder for JsonUnions
    class JsonUnions
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/jsonunions')

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:contents] = Builders::MyUnion.build(input[:contents]) unless input[:contents].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Structure Builder for MyUnion
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
          data[:blob_value] = Base64::encode64(input).strip
        when Types::MyUnion::TimestampValue
          data[:timestamp_value] = Seahorse::TimeHelper.to_date_time(input)
        when Types::MyUnion::EnumValue
          data[:enum_value] = input
        when Types::MyUnion::ListValue
          data[:list_value] = Builders::StringList.build(input)
        when Types::MyUnion::MapValue
          data[:map_value] = Builders::StringMap.build(input)
        when Types::MyUnion::StructureValue
          data[:structure_value] = Builders::GreetingStruct.build(input)
        else
          raise ArgumentError,
          "Expected input to be one of the subclasses of Types::MyUnion"
        end

        data
      end
    end

    # Structure Builder for GreetingStruct
    class GreetingStruct
      def self.build(input)
        data = {}
        data[:hi] = input[:hi] unless input[:hi].nil?
        data
      end
    end

    # Operation Builder for KitchenSinkOperation
    class KitchenSinkOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:blob] = Base64::encode64(input[:blob]).strip unless input[:blob].nil?
        data[:boolean] = input[:boolean] unless input[:boolean].nil?
        data[:double] = input[:double] unless input[:double].nil?
        data[:empty_struct] = Builders::EmptyStruct.build(input[:empty_struct]) unless input[:empty_struct].nil?
        data[:float] = input[:float] unless input[:float].nil?
        data[:httpdate_timestamp] = Seahorse::TimeHelper.to_http_date(input[:httpdate_timestamp]) unless input[:httpdate_timestamp].nil?
        data[:integer] = input[:integer] unless input[:integer].nil?
        data[:iso8601_timestamp] = Seahorse::TimeHelper.to_date_time(input[:iso8601_timestamp]) unless input[:iso8601_timestamp].nil?
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
        data[:timestamp] = Seahorse::TimeHelper.to_date_time(input[:timestamp]) unless input[:timestamp].nil?
        data[:unix_timestamp] = Seahorse::TimeHelper.to_epoch_seconds(input[:unix_timestamp]) unless input[:unix_timestamp].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Structure Builder for StructWithLocationName
    class StructWithLocationName
      def self.build(input)
        data = {}
        data['RenamedMember'] = input[:value] unless input[:value].nil?
        data
      end
    end

    # Structure Builder for SimpleStruct
    class SimpleStruct
      def self.build(input)
        data = {}
        data[:value] = input[:value] unless input[:value].nil?
        data
      end
    end

    # Structure Builder for KitchenSink
    class KitchenSink
      def self.build(input)
        data = {}
        data[:blob] = Base64::encode64(input[:blob]).strip unless input[:blob].nil?
        data[:boolean] = input[:boolean] unless input[:boolean].nil?
        data[:double] = input[:double] unless input[:double].nil?
        data[:empty_struct] = Builders::EmptyStruct.build(input[:empty_struct]) unless input[:empty_struct].nil?
        data[:float] = input[:float] unless input[:float].nil?
        data[:httpdate_timestamp] = Seahorse::TimeHelper.to_http_date(input[:httpdate_timestamp]) unless input[:httpdate_timestamp].nil?
        data[:integer] = input[:integer] unless input[:integer].nil?
        data[:iso8601_timestamp] = Seahorse::TimeHelper.to_date_time(input[:iso8601_timestamp]) unless input[:iso8601_timestamp].nil?
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
        data[:timestamp] = Seahorse::TimeHelper.to_date_time(input[:timestamp]) unless input[:timestamp].nil?
        data[:unix_timestamp] = Seahorse::TimeHelper.to_epoch_seconds(input[:unix_timestamp]) unless input[:unix_timestamp].nil?
        data
      end
    end

    # Map Builder for MapOfKitchenSinks
    class MapOfKitchenSinks
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = Builders::KitchenSink.build(value)
        end
        data
      end
    end

    # List Builder for ListOfKitchenSinks
    class ListOfKitchenSinks
      def self.build(input)
        data = []
        input.each do |element|
          data << Builders::KitchenSink.build(element)
        end
        data
      end
    end

    # Map Builder for MapOfStructs
    class MapOfStructs
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = Builders::SimpleStruct.build(value)
        end
        data
      end
    end

    # Map Builder for MapOfStrings
    class MapOfStrings
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    # Map Builder for MapOfMapOfStrings
    class MapOfMapOfStrings
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = Builders::MapOfStrings.build(value)
        end
        data
      end
    end

    # Map Builder for MapOfListsOfStrings
    class MapOfListsOfStrings
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = Builders::ListOfStrings.build(value)
        end
        data
      end
    end

    # List Builder for ListOfStrings
    class ListOfStrings
      def self.build(input)
        data = []
        input.each do |element|
          data << element
        end
        data
      end
    end

    # List Builder for ListOfStructs
    class ListOfStructs
      def self.build(input)
        data = []
        input.each do |element|
          data << Builders::SimpleStruct.build(element)
        end
        data
      end
    end

    # List Builder for ListOfMapsOfStrings
    class ListOfMapsOfStrings
      def self.build(input)
        data = []
        input.each do |element|
          data << Builders::MapOfStrings.build(element)
        end
        data
      end
    end

    # List Builder for ListOfListOfStrings
    class ListOfListOfStrings
      def self.build(input)
        data = []
        input.each do |element|
          data << Builders::ListOfStrings.build(element)
        end
        data
      end
    end

    # Structure Builder for EmptyStruct
    class EmptyStruct
      def self.build(input)
        data = {}
        data
      end
    end

    # Operation Builder for MediaTypeHeader
    class MediaTypeHeader
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/MediaTypeHeader')
        http_req.headers['X-Json'] = Base64::encode64(input[:json]).strip unless input[:json].nil? || input[:json].empty?
      end
    end

    # Operation Builder for NestedAttributesOperation
    class NestedAttributesOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/nestedattributes')

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:simple_struct_attributes] = Builders::SimpleStruct.build(input[:simple_struct]) unless input[:simple_struct].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Operation Builder for NullAndEmptyHeadersClient
    class NullAndEmptyHeadersClient
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/NullAndEmptyHeadersClient')
        http_req.headers['X-A'] = input[:a] unless input[:a].nil? || input[:a].empty?
        http_req.headers['X-B'] = input[:b] unless input[:b].nil? || input[:b].empty?
        unless input[:c].nil? || input[:c].empty?
          http_req.headers['X-C'] = input[:c]
            .compact
            .map { |s| (s.include?('"') || s.include?(",")) ? "\"#{s.gsub('"', '\"')}\"" : s }
            .join(', ')
        end
      end
    end

    # Operation Builder for NullOperation
    class NullOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/nulloperation')

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:string] = input[:string] unless input[:string].nil?
        data[:sparse_string_list] = Builders::SparseStringList.build(input[:sparse_string_list]) unless input[:sparse_string_list].nil?
        data[:sparse_string_map] = Builders::SparseStringMap.build(input[:sparse_string_map]) unless input[:sparse_string_map].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Map Builder for SparseStringMap
    class SparseStringMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    # List Builder for SparseStringList
    class SparseStringList
      def self.build(input)
        data = []
        input.each do |element|
          data << element
        end
        data
      end
    end

    # Operation Builder for OmitsNullSerializesEmptyString
    class OmitsNullSerializesEmptyString
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/OmitsNullSerializesEmptyString')
        http_req.append_query_param('Null', input[:null_value].to_s) unless input[:null_value].nil?
        http_req.append_query_param('Empty', input[:empty_string].to_s) unless input[:empty_string].nil?
      end
    end

    # Operation Builder for OperationWithOptionalInputOutput
    class OperationWithOptionalInputOutput
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/operationwithoptionalinputoutput')

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:value] = input[:value] unless input[:value].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Operation Builder for PutAndGetInlineDocuments
    class PutAndGetInlineDocuments
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/putandgetinlinedocuments')

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:inline_document] = input[:inline_document] unless input[:inline_document].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Operation Builder for QueryParamsAsStringListMap
    class QueryParamsAsStringListMap
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/StringListMap')
        unless input[:foo].nil? || input[:foo].empty?
          input[:foo].each do |k, v|
            unless v.nil? || v.empty?
              v.each do |value|
                http_req.append_query_param(k, value.to_s) unless value.nil?
              end
            end
          end
        end
        http_req.append_query_param('corge', input[:qux].to_s) unless input[:qux].nil?
      end
    end

    # Map Builder for StringListMap
    class StringListMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = Builders::StringList.build(value)
        end
        data
      end
    end

    # Operation Builder for TimestampFormatHeaders
    class TimestampFormatHeaders
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/TimestampFormatHeaders')
        http_req.headers['X-memberEpochSeconds'] = Seahorse::TimeHelper.to_epoch_seconds(input[:member_epoch_seconds]).to_i unless input[:member_epoch_seconds].nil?
        http_req.headers['X-memberHttpDate'] = Seahorse::TimeHelper.to_http_date(input[:member_http_date]) unless input[:member_http_date].nil?
        http_req.headers['X-memberDateTime'] = Seahorse::TimeHelper.to_date_time(input[:member_date_time]) unless input[:member_date_time].nil?
        http_req.headers['X-defaultFormat'] = Seahorse::TimeHelper.to_http_date(input[:default_format]) unless input[:default_format].nil?
        http_req.headers['X-targetEpochSeconds'] = Seahorse::TimeHelper.to_epoch_seconds(input[:target_epoch_seconds]).to_i unless input[:target_epoch_seconds].nil?
        http_req.headers['X-targetHttpDate'] = Seahorse::TimeHelper.to_http_date(input[:target_http_date]) unless input[:target_http_date].nil?
        http_req.headers['X-targetDateTime'] = Seahorse::TimeHelper.to_date_time(input[:target_date_time]) unless input[:target_date_time].nil?
      end
    end

    # Operation Builder for __789BadName
    class Operation____789BadName
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path(format(
            '/BadName/%<__123abc>s',
            __123abc: Seahorse::HTTP.uri_escape(input[:member____123abc].to_s)
          )
        )

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:member] = Builders::Struct____456efg.build(input[:member]) unless input[:member].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Structure Builder for __456efg
    class Struct____456efg
      def self.build(input)
        data = {}
        data[:__123foo] = input[:member____123foo] unless input[:member____123foo].nil?
        data
      end
    end
  end
end
