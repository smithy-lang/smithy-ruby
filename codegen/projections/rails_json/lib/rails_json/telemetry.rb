# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module RailsJson
  # @api private
  module Telemetry

    class AllQueryStringTypes
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'AllQueryStringTypes',
          'code.function' => 'all_query_string_types',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.AllQueryStringTypes', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class ConstantAndVariableQueryString
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'ConstantAndVariableQueryString',
          'code.function' => 'constant_and_variable_query_string',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.ConstantAndVariableQueryString', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class ConstantQueryString
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'ConstantQueryString',
          'code.function' => 'constant_query_string',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.ConstantQueryString', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class DatetimeOffsets
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'DatetimeOffsets',
          'code.function' => 'datetime_offsets',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.DatetimeOffsets', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class DocumentType
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'DocumentType',
          'code.function' => 'document_type',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.DocumentType', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class DocumentTypeAsMapValue
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'DocumentTypeAsMapValue',
          'code.function' => 'document_type_as_map_value',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.DocumentTypeAsMapValue', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class DocumentTypeAsPayload
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'DocumentTypeAsPayload',
          'code.function' => 'document_type_as_payload',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.DocumentTypeAsPayload', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class EmptyInputAndEmptyOutput
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'EmptyInputAndEmptyOutput',
          'code.function' => 'empty_input_and_empty_output',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.EmptyInputAndEmptyOutput', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class EndpointOperation
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'EndpointOperation',
          'code.function' => 'endpoint_operation',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.EndpointOperation', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class EndpointWithHostLabelOperation
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'EndpointWithHostLabelOperation',
          'code.function' => 'endpoint_with_host_label_operation',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.EndpointWithHostLabelOperation', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class FractionalSeconds
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'FractionalSeconds',
          'code.function' => 'fractional_seconds',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.FractionalSeconds', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class GreetingWithErrors
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'GreetingWithErrors',
          'code.function' => 'greeting_with_errors',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.GreetingWithErrors', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HostWithPathOperation
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HostWithPathOperation',
          'code.function' => 'host_with_path_operation',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HostWithPathOperation', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpChecksumRequired
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpChecksumRequired',
          'code.function' => 'http_checksum_required',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpChecksumRequired', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpEnumPayload
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpEnumPayload',
          'code.function' => 'http_enum_payload',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpEnumPayload', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpPayloadTraits
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpPayloadTraits',
          'code.function' => 'http_payload_traits',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpPayloadTraits', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpPayloadTraitsWithMediaType
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpPayloadTraitsWithMediaType',
          'code.function' => 'http_payload_traits_with_media_type',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpPayloadTraitsWithMediaType', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpPayloadWithStructure
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpPayloadWithStructure',
          'code.function' => 'http_payload_with_structure',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpPayloadWithStructure', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpPayloadWithUnion
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpPayloadWithUnion',
          'code.function' => 'http_payload_with_union',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpPayloadWithUnion', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpPrefixHeaders
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpPrefixHeaders',
          'code.function' => 'http_prefix_headers',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpPrefixHeaders', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpPrefixHeadersInResponse
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpPrefixHeadersInResponse',
          'code.function' => 'http_prefix_headers_in_response',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpPrefixHeadersInResponse', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpRequestWithFloatLabels
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpRequestWithFloatLabels',
          'code.function' => 'http_request_with_float_labels',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpRequestWithFloatLabels', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpRequestWithGreedyLabelInPath
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpRequestWithGreedyLabelInPath',
          'code.function' => 'http_request_with_greedy_label_in_path',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpRequestWithGreedyLabelInPath', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpRequestWithLabels
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpRequestWithLabels',
          'code.function' => 'http_request_with_labels',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpRequestWithLabels', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpRequestWithLabelsAndTimestampFormat
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpRequestWithLabelsAndTimestampFormat',
          'code.function' => 'http_request_with_labels_and_timestamp_format',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpRequestWithLabelsAndTimestampFormat', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpRequestWithRegexLiteral
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpRequestWithRegexLiteral',
          'code.function' => 'http_request_with_regex_literal',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpRequestWithRegexLiteral', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpResponseCode
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpResponseCode',
          'code.function' => 'http_response_code',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpResponseCode', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpStringPayload
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'HttpStringPayload',
          'code.function' => 'http_string_payload',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.HttpStringPayload', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class IgnoreQueryParamsInResponse
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'IgnoreQueryParamsInResponse',
          'code.function' => 'ignore_query_params_in_response',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.IgnoreQueryParamsInResponse', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class InputAndOutputWithHeaders
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'InputAndOutputWithHeaders',
          'code.function' => 'input_and_output_with_headers',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.InputAndOutputWithHeaders', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class JsonBlobs
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'JsonBlobs',
          'code.function' => 'json_blobs',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.JsonBlobs', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class JsonEnums
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'JsonEnums',
          'code.function' => 'json_enums',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.JsonEnums', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class JsonIntEnums
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'JsonIntEnums',
          'code.function' => 'json_int_enums',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.JsonIntEnums', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class JsonLists
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'JsonLists',
          'code.function' => 'json_lists',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.JsonLists', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class JsonMaps
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'JsonMaps',
          'code.function' => 'json_maps',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.JsonMaps', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class JsonTimestamps
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'JsonTimestamps',
          'code.function' => 'json_timestamps',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.JsonTimestamps', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class JsonUnions
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'JsonUnions',
          'code.function' => 'json_unions',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.JsonUnions', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class MediaTypeHeader
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'MediaTypeHeader',
          'code.function' => 'media_type_header',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.MediaTypeHeader', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class NoInputAndNoOutput
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'NoInputAndNoOutput',
          'code.function' => 'no_input_and_no_output',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.NoInputAndNoOutput', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class NoInputAndOutput
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'NoInputAndOutput',
          'code.function' => 'no_input_and_output',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.NoInputAndOutput', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class NullAndEmptyHeadersClient
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'NullAndEmptyHeadersClient',
          'code.function' => 'null_and_empty_headers_client',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.NullAndEmptyHeadersClient', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class NullAndEmptyHeadersServer
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'NullAndEmptyHeadersServer',
          'code.function' => 'null_and_empty_headers_server',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.NullAndEmptyHeadersServer', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class OmitsNullSerializesEmptyString
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'OmitsNullSerializesEmptyString',
          'code.function' => 'omits_null_serializes_empty_string',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.OmitsNullSerializesEmptyString', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class OmitsSerializingEmptyLists
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'OmitsSerializingEmptyLists',
          'code.function' => 'omits_serializing_empty_lists',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.OmitsSerializingEmptyLists', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class OperationWithDefaults
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'OperationWithDefaults',
          'code.function' => 'operation_with_defaults',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.OperationWithDefaults', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class OperationWithNestedStructure
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'OperationWithNestedStructure',
          'code.function' => 'operation_with_nested_structure',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.OperationWithNestedStructure', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class PostPlayerAction
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'PostPlayerAction',
          'code.function' => 'post_player_action',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.PostPlayerAction', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class PostUnionWithJsonName
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'PostUnionWithJsonName',
          'code.function' => 'post_union_with_json_name',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.PostUnionWithJsonName', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class PutWithContentEncoding
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'PutWithContentEncoding',
          'code.function' => 'put_with_content_encoding',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.PutWithContentEncoding', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class QueryIdempotencyTokenAutoFill
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'QueryIdempotencyTokenAutoFill',
          'code.function' => 'query_idempotency_token_auto_fill',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.QueryIdempotencyTokenAutoFill', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class QueryParamsAsStringListMap
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'QueryParamsAsStringListMap',
          'code.function' => 'query_params_as_string_list_map',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.QueryParamsAsStringListMap', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class QueryPrecedence
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'QueryPrecedence',
          'code.function' => 'query_precedence',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.QueryPrecedence', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class RecursiveShapes
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'RecursiveShapes',
          'code.function' => 'recursive_shapes',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.RecursiveShapes', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class SimpleScalarProperties
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'SimpleScalarProperties',
          'code.function' => 'simple_scalar_properties',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.SimpleScalarProperties', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class SparseJsonLists
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'SparseJsonLists',
          'code.function' => 'sparse_json_lists',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.SparseJsonLists', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class SparseJsonMaps
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'SparseJsonMaps',
          'code.function' => 'sparse_json_maps',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.SparseJsonMaps', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class StreamingTraits
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'StreamingTraits',
          'code.function' => 'streaming_traits',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.StreamingTraits', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class StreamingTraitsRequireLength
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'StreamingTraitsRequireLength',
          'code.function' => 'streaming_traits_require_length',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.StreamingTraitsRequireLength', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class StreamingTraitsWithMediaType
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'StreamingTraitsWithMediaType',
          'code.function' => 'streaming_traits_with_media_type',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.StreamingTraitsWithMediaType', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class TestBodyStructure
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'TestBodyStructure',
          'code.function' => 'test_body_structure',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.TestBodyStructure', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class TestNoPayload
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'TestNoPayload',
          'code.function' => 'test_no_payload',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.TestNoPayload', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class TestPayloadBlob
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'TestPayloadBlob',
          'code.function' => 'test_payload_blob',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.TestPayloadBlob', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class TestPayloadStructure
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'TestPayloadStructure',
          'code.function' => 'test_payload_structure',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.TestPayloadStructure', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class TimestampFormatHeaders
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'TimestampFormatHeaders',
          'code.function' => 'timestamp_format_headers',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.TimestampFormatHeaders', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class UnitInputAndOutput
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RailsJson',
          'rpc.method' => 'UnitInputAndOutput',
          'code.function' => 'unit_input_and_output',
          'code.namespace' => 'RailsJson::Telemetry'
        }
        context.tracer.in_span('RailsJson.UnitInputAndOutput', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

  end
end
