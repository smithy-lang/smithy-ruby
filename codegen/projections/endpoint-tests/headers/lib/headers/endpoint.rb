# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Headers
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
        if region != nil
          return Hearth::EndpointRules::Endpoint.new(
            uri: "https://#{region}.amazonaws.com",
            headers: {'x-amz-region' => [region], 'x-amz-multi' => ["*", region]},
            auth_schemes: []
          )
        end
        # fallback when region is unset
        raise ArgumentError, "Region must be set to resolve a valid endpoint"

      end
    end

    module Parameters
    end

  end
end
