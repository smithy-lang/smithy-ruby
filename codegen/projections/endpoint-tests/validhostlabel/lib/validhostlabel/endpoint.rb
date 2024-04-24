# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module ValidHostlabel
  module Endpoint
    Params = ::Struct.new(
      :region,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    class Resolver
      def resolve(params)
        region = params.region

        # Template the region into the URI when region is set
        if Hearth::EndpointRules::valid_host_label?(region, false)
          return Hearth::EndpointRules::Endpoint.new(uri: "https://#{region}.amazonaws.com")
        end
        # Template the region into the URI when region is set
        if Hearth::EndpointRules::valid_host_label?(region, true)
          return Hearth::EndpointRules::Endpoint.new(uri: "https://#{region}-subdomains.amazonaws.com")
        end
        # Region was not a valid host label
        raise ArgumentError, "Invalid hostlabel"

      end
    end

    module Parameters
    end

  end
end
