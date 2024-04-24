# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module GetAttr
  module Endpoint
    Params = ::Struct.new(
      :bucket,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    class Resolver
      def resolve(params)
        bucket = params.bucket

        # bucket is set, handle bucket specific endpoints
        if bucket != nil && (bucket_url = Hearth::EndpointRules::parse_url(bucket)) && (path = bucket_url['path'])
          return Hearth::EndpointRules::Endpoint.new(uri: "https://#{bucket_url['authority']}/#{path}")
        end

        raise ArgumentError, 'No endpoint could be resolved'
      end
    end

    module Parameters
    end

  end
end
