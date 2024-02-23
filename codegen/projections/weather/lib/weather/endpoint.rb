# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Weather
  module Endpoint
    Params = ::Struct.new(
      :endpoint,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    class Provider
      def resolve_endpoint(params)
        endpoint = params.endpoint

        if (endpoint != nil)
          return Hearth::EndpointRules::Endpoint.new(uri: endpoint)
        end
        raise ArgumentError, "Endpoint is not set - you must configure an endpoint."

      end
    end

    module Parameters

      class Operation____789BadName
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class GetCity
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class GetCityAnnouncements
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class GetCityImage
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class GetCurrentTime
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class GetForecast
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class ListCities
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end
    end

  end
end
