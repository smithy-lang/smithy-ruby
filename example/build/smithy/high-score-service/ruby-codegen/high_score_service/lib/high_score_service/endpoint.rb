# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
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

      class CreateHighScore
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class DeleteHighScore
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class GetHighScore
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class ListHighScores
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end

      class UpdateHighScore
        def self.build(config, input, context)
          params = Params.new
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end
    end

  end
end
