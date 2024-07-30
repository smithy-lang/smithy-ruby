# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Rpcv2Cbor
  # @api private
  module Telemetry

    class EmptyInputOutput
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RpcV2Protocol',
          'rpc.method' => 'EmptyInputOutput',
          'code.function' => 'empty_input_output',
          'code.namespace' => 'Rpcv2Cbor::Telemetry'
        }
        context.tracer.in_span('RpcV2Protocol.EmptyInputOutput', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class Float16
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RpcV2Protocol',
          'rpc.method' => 'Float16',
          'code.function' => 'float16',
          'code.namespace' => 'Rpcv2Cbor::Telemetry'
        }
        context.tracer.in_span('RpcV2Protocol.Float16', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class FractionalSeconds
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RpcV2Protocol',
          'rpc.method' => 'FractionalSeconds',
          'code.function' => 'fractional_seconds',
          'code.namespace' => 'Rpcv2Cbor::Telemetry'
        }
        context.tracer.in_span('RpcV2Protocol.FractionalSeconds', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class GreetingWithErrors
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RpcV2Protocol',
          'rpc.method' => 'GreetingWithErrors',
          'code.function' => 'greeting_with_errors',
          'code.namespace' => 'Rpcv2Cbor::Telemetry'
        }
        context.tracer.in_span('RpcV2Protocol.GreetingWithErrors', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class NoInputOutput
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RpcV2Protocol',
          'rpc.method' => 'NoInputOutput',
          'code.function' => 'no_input_output',
          'code.namespace' => 'Rpcv2Cbor::Telemetry'
        }
        context.tracer.in_span('RpcV2Protocol.NoInputOutput', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class OperationWithDefaults
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RpcV2Protocol',
          'rpc.method' => 'OperationWithDefaults',
          'code.function' => 'operation_with_defaults',
          'code.namespace' => 'Rpcv2Cbor::Telemetry'
        }
        context.tracer.in_span('RpcV2Protocol.OperationWithDefaults', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class OptionalInputOutput
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RpcV2Protocol',
          'rpc.method' => 'OptionalInputOutput',
          'code.function' => 'optional_input_output',
          'code.namespace' => 'Rpcv2Cbor::Telemetry'
        }
        context.tracer.in_span('RpcV2Protocol.OptionalInputOutput', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class RecursiveShapes
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RpcV2Protocol',
          'rpc.method' => 'RecursiveShapes',
          'code.function' => 'recursive_shapes',
          'code.namespace' => 'Rpcv2Cbor::Telemetry'
        }
        context.tracer.in_span('RpcV2Protocol.RecursiveShapes', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class RpcV2CborDenseMaps
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RpcV2Protocol',
          'rpc.method' => 'RpcV2CborDenseMaps',
          'code.function' => 'rpc_v2_cbor_dense_maps',
          'code.namespace' => 'Rpcv2Cbor::Telemetry'
        }
        context.tracer.in_span('RpcV2Protocol.RpcV2CborDenseMaps', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class RpcV2CborLists
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RpcV2Protocol',
          'rpc.method' => 'RpcV2CborLists',
          'code.function' => 'rpc_v2_cbor_lists',
          'code.namespace' => 'Rpcv2Cbor::Telemetry'
        }
        context.tracer.in_span('RpcV2Protocol.RpcV2CborLists', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class RpcV2CborSparseMaps
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RpcV2Protocol',
          'rpc.method' => 'RpcV2CborSparseMaps',
          'code.function' => 'rpc_v2_cbor_sparse_maps',
          'code.namespace' => 'Rpcv2Cbor::Telemetry'
        }
        context.tracer.in_span('RpcV2Protocol.RpcV2CborSparseMaps', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class SimpleScalarProperties
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RpcV2Protocol',
          'rpc.method' => 'SimpleScalarProperties',
          'code.function' => 'simple_scalar_properties',
          'code.namespace' => 'Rpcv2Cbor::Telemetry'
        }
        context.tracer.in_span('RpcV2Protocol.SimpleScalarProperties', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

    class SparseNullsOperation
      def self.in_span(context, &block)
        attributes = {
          'rpc.service' => 'RpcV2Protocol',
          'rpc.method' => 'SparseNullsOperation',
          'code.function' => 'sparse_nulls_operation',
          'code.namespace' => 'Rpcv2Cbor::Telemetry'
        }
        context.tracer.in_span('RpcV2Protocol.SparseNullsOperation', attributes: attributes, kind: Hearth::Telemetry::SpanKind::CLIENT) do
          block.call
        end
      end
    end

  end
end
