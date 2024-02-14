# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Endpoint
    Params = ::Struct.new(
      :stage,
      :dataplane,
      :context_path,
      :endpoint,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    class Provider
      def resolve_endpoint(params)
        stage = params.stage
        dataplane = params.dataplane
        context_path = params.context_path
        endpoint = params.endpoint

        if (endpoint != nil)
          return Hearth::RulesEngine::Endpoint.new(uri: endpoint)
        end
        if (stage != nil) && (stage == "alpha")
          return Hearth::RulesEngine::Endpoint.new(uri: "https://alpha.whitelabel.dev")
        end
        if (stage != nil) && (stage == "beta")
          return Hearth::RulesEngine::Endpoint.new(uri: "https://beta.whitelabel.dev")
        end
        if (stage != nil) && (stage == "gamma")
          return Hearth::RulesEngine::Endpoint.new(uri: "https://gamma.whitelabel.dev")
        end
        if (dataplane != nil)
          return Hearth::RulesEngine::Endpoint.new(uri: "https://data.whitelabel.com")
        end
        if (context_path != nil)
          return Hearth::RulesEngine::Endpoint.new(uri: "https://whitelabel.com/#{context_path}")
        end
        return Hearth::RulesEngine::Endpoint.new(uri: "https://whitelabel.com")

        raise ArgumentError, 'No endpoint could be resolved'
      end
    end

    module Parameters

      class Operation____PaginatorsTestWithBadNames
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class CustomAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class DataplaneOperation
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.dataplane = true
          params.endpoint = config[:endpoint]
          params
        end
      end

      class DefaultsTest
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class EndpointOperation
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class EndpointOperationWithPath
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.context_path = input.path_member
          params.endpoint = config[:endpoint]
          params
        end
      end

      class EndpointWithHostLabelOperation
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class HttpApiKeyAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class HttpBasicAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class HttpBearerAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class HttpDigestAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class KitchenSink
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class MixinTest
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class NoAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class OptionalAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class OrderedAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class PaginatorsTest
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class PaginatorsTestWithItems
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class RelativeMiddlewareOperation
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class RequestCompressionOperation
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class RequestCompressionStreamingOperation
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class StreamingOperation
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class StreamingWithLength
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end

      class WaitersTest
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage]
          params.endpoint = config[:endpoint]
          params
        end
      end
    end

  end
end
