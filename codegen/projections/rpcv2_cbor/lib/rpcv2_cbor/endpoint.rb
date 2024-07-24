# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Rpcv2Cbor
  module Endpoint
    class Params
      def initialize(endpoint: nil)
        @endpoint = endpoint
      end

      attr_accessor :endpoint
    end

    class Resolver
      def resolve(params)
        endpoint = params.endpoint

        if endpoint != nil
          return Hearth::EndpointRules::Endpoint.new(uri: endpoint)
        end
        raise ArgumentError, "Endpoint is not set - you must configure an endpoint."

      end
    end

    module Parameters

      class EmptyInputOutput
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class Float16
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class FractionalSeconds
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class GreetingWithErrors
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class NoInputOutput
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class OperationWithDefaults
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class OptionalInputOutput
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class RecursiveShapes
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class RpcV2CborDenseMaps
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class RpcV2CborLists
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class RpcV2CborSparseMaps
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class SimpleScalarProperties
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class SparseNullsOperation
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end
    end

  end
end
