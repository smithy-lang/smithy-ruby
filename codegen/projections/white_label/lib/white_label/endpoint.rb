# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Endpoint
    Params = ::Struct.new(
      :stage,
      :dataplane,
      :resource_url,
      :endpoint,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    class Provider
      def resolve_endpoint(params)
        stage = params.stage
        dataplane = params.dataplane
        resource_url = params.resource_url
        endpoint = params.endpoint

        if (endpoint != nil) && (resource_url != nil)
          raise ArgumentError, "Unable to set both Endpoint and ResourceUrl: \"#{resource_url}\""
        end
        if (endpoint != nil)
          return Hearth::EndpointRules::Endpoint.new(uri: endpoint)
        end
        # Use a user provided resource
        if (resource_url != nil) && (parsed_url = Hearth::EndpointRules::parse_url(resource_url)) && (path = parsed_url['path'])
          return Hearth::EndpointRules::Endpoint.new(
            uri: "https://#{parsed_url['authority']}#{path}",
            headers: {'x-resource-type' => ["custom"]},
            auth_schemes: [Hearth::EndpointRules::AuthScheme.new(scheme_id: "smithy.api#httpBearerAuth", properties: {})]
          )
        end
        if (stage != nil) && (stage == "alpha")
          return Hearth::EndpointRules::Endpoint.new(uri: "https://alpha.whitelabel.dev")
        end
        if (stage != nil) && (stage == "beta")
          return Hearth::EndpointRules::Endpoint.new(uri: "https://beta.whitelabel.dev")
        end
        if (stage != nil) && (stage == "gamma")
          return Hearth::EndpointRules::Endpoint.new(uri: "https://gamma.whitelabel.dev")
        end
        if (dataplane != nil)
          return Hearth::EndpointRules::Endpoint.new(uri: "https://data.whitelabel.com")
        end
        return Hearth::EndpointRules::Endpoint.new(uri: "https://whitelabel.com")

      end
    end

    module Parameters

      class Operation____PaginatorsTestWithBadNames
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class CustomAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class DataplaneOperation
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.dataplane = true
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class DefaultsTest
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class EndpointOperation
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class EndpointOperationWithResource
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.resource_url = input.resource_url unless input.resource_url.nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class EndpointWithHostLabelOperation
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.dataplane = true
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class HttpApiKeyAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class HttpBasicAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class HttpBearerAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class HttpDigestAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class KitchenSink
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class MixinTest
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class NoAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class OptionalAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class OrderedAuth
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class PaginatorsTest
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class PaginatorsTestWithItems
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class RelativeMiddlewareOperation
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class RequestCompressionOperation
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class RequestCompressionStreamingOperation
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class StreamingOperation
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class StreamingWithLength
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class WaitersTest
        def self.build(config, input, context)
          params = Params.new
          params.stage = config[:stage] unless config[:stage].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end
    end

  end
end
