# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module ParseUrl
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

        # endpoint is set and is a valid URL
        if endpoint != nil && (url = Hearth::EndpointRules::parse_url(endpoint))
          if url['isIp'] == true
            return Hearth::EndpointRules::Endpoint.new(uri: "#{url['scheme']}://#{url['authority']}#{url['normalizedPath']}is-ip-addr")
          end
          if url['path'] == "/port"
            return Hearth::EndpointRules::Endpoint.new(uri: "#{url['scheme']}://#{url['authority']}/uri-with-port")
          end
          if url['normalizedPath'] == "/"
            return Hearth::EndpointRules::Endpoint.new(uri: "https://#{url['scheme']}-#{url['authority']}-nopath.example.com")
          end
          return Hearth::EndpointRules::Endpoint.new(uri: "https://#{url['scheme']}-#{url['authority']}.example.com/path-is#{url['path']}")
        end
        raise ArgumentError, "endpoint was invalid"

      end
    end

    module Parameters
    end

  end
end
