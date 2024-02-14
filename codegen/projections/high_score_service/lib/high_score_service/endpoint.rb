# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
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
          return Hearth::RulesEngine::Endpoint.new(url: endpoint)
        end
        raise ArgumentError, "Endpoint is not set - you must configure an endpoint."

        raise ArgumentError, 'No endpoint could be resolved'
      end
    end

    module Parameters

      class ApiKeyAuth
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint]
          params
        end
      end

      class BasicAuth
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint]
          params
        end
      end

      class BearerAuth
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint]
          params
        end
      end

      class CreateHighScore
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint]
          params
        end
      end

      class DeleteHighScore
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint]
          params
        end
      end

      class DigestAuth
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint]
          params
        end
      end

      class GetHighScore
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint]
          params
        end
      end

      class ListHighScores
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint]
          params
        end
      end

      class UpdateHighScore
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint]
          params
        end
      end
    end

  end
end
