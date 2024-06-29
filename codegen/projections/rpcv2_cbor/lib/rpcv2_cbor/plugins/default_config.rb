# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Rpcv2Cbor
  module Plugins
    class DefaultConfig
      def call(config)
      end

      private

      def defaults
        {
          auth_resolver: [Auth::Resolver.new],
          auth_schemes: [Auth::SCHEMES],
          disable_host_prefix: [false],
          endpoint: [proc { |cfg| cfg[:stub_responses] ? 'http://localhost' : nil }],
          endpoint_resolver: [Endpoint::Resolver.new],
          http_client: [proc { |cfg| Hearth::HTTP::Client.new(logger: cfg[:logger]) }],
          interceptors: [Hearth::InterceptorList.new],
          logger: [Logger.new(IO::NULL)],
          plugins: [Hearth::PluginList.new],
          retry_strategy: [Hearth::Retry::Standard.new],
          stub_responses: [false],
          stubs: [Hearth::Stubs.new],
          validate_input: [true]
        }.freeze
      end
    end
  end
end
