# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module DefaultValues
  module Endpoint
    Params = ::Struct.new(
      :bar,
      :baz,
      :endpoint,
      keyword_init: true
    ) do
      include Hearth::Structure

      def initialize(*)
        super
        self.baz = 'baz' if self.baz.nil?
        self.endpoint = 'asdf' if self.endpoint.nil?
      end
    end

    class Resolver
      def resolve(params)
        bar = params.bar
        baz = params.baz
        endpoint = params.endpoint

        if bar != nil
          return Hearth::EndpointRules::Endpoint.new(uri: "https://example.com/#{baz}")
        end
        # error fallthrough
        raise ArgumentError, "endpoint error"

      end
    end

    module Parameters

      class GetThing
        def self.build(config, input, context)
          params = Params.new
          params.bar = config[:bar] unless config[:bar].nil?
          params.baz = config[:baz] unless config[:baz].nil?
          params.endpoint = config[:endpoint] unless config[:endpoint].nil?
          params
        end
      end
    end

  end
end
