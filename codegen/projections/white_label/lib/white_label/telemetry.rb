# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  # @api private
  module Telemetry

    class CustomAuth
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'CustomAuth',
          'code.function' => 'custom_auth',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.CustomAuth', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class DataplaneEndpoint
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'DataplaneEndpoint',
          'code.function' => 'dataplane_endpoint',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.DataplaneEndpoint', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class DefaultsTest
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'DefaultsTest',
          'code.function' => 'defaults_test',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.DefaultsTest', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class EndpointOperation
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'EndpointOperation',
          'code.function' => 'endpoint_operation',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.EndpointOperation', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class EndpointWithHostLabelOperation
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'EndpointWithHostLabelOperation',
          'code.function' => 'endpoint_with_host_label_operation',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.EndpointWithHostLabelOperation', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpApiKeyAuth
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'HttpApiKeyAuth',
          'code.function' => 'http_api_key_auth',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.HttpApiKeyAuth', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpBasicAuth
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'HttpBasicAuth',
          'code.function' => 'http_basic_auth',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.HttpBasicAuth', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpBearerAuth
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'HttpBearerAuth',
          'code.function' => 'http_bearer_auth',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.HttpBearerAuth', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class HttpDigestAuth
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'HttpDigestAuth',
          'code.function' => 'http_digest_auth',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.HttpDigestAuth', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class KitchenSink
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'KitchenSink',
          'code.function' => 'kitchen_sink',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.KitchenSink', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class MixinTest
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'MixinTest',
          'code.function' => 'mixin_test',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.MixinTest', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class NoAuth
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'NoAuth',
          'code.function' => 'no_auth',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.NoAuth', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class OptionalAuth
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'OptionalAuth',
          'code.function' => 'optional_auth',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.OptionalAuth', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class OrderedAuth
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'OrderedAuth',
          'code.function' => 'ordered_auth',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.OrderedAuth', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class PaginatorsTest
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'PaginatorsTest',
          'code.function' => 'paginators_test',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.PaginatorsTest', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class PaginatorsTestWithItems
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'PaginatorsTestWithItems',
          'code.function' => 'paginators_test_with_items',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.PaginatorsTestWithItems', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class RelativeMiddleware
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'RelativeMiddleware',
          'code.function' => 'relative_middleware',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.RelativeMiddleware', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class RequestCompression
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'RequestCompression',
          'code.function' => 'request_compression',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.RequestCompression', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class RequestCompressionStreaming
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'RequestCompressionStreaming',
          'code.function' => 'request_compression_streaming',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.RequestCompressionStreaming', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class ResourceEndpoint
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'ResourceEndpoint',
          'code.function' => 'resource_endpoint',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.ResourceEndpoint', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class Streaming
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'Streaming',
          'code.function' => 'streaming',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.Streaming', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class StreamingWithLength
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'StreamingWithLength',
          'code.function' => 'streaming_with_length',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.StreamingWithLength', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class TelemetryTest
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'TelemetryTest',
          'code.function' => 'telemetry_test',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.TelemetryTest', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class WaitersTest
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'WaitersTest',
          'code.function' => 'waiters_test',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.WaitersTest', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class Operation____PaginatorsTestWithBadNames
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'WhiteLabel',
          'rpc.method' => 'Operation____PaginatorsTestWithBadNames',
          'code.function' => 'operation____paginators_test_with_bad_names',
          'code.namespace' => 'WhiteLabel::Telemetry'
        }
        context.tracer.in_span('WhiteLabel.Operation____PaginatorsTestWithBadNames', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

  end
end
