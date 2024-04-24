# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module UrlEncode
  module Endpoint
    Params = ::Struct.new(
      :test_case_id,
      :input,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    class Resolver
      def resolve(params)
        test_case_id = params.test_case_id
        input = params.input

        # uriEncode on input
        if test_case_id == "1" && (output = Hearth::EndpointRules::uri_encode(input))
          raise ArgumentError, "The value is: `#{output}`"
        end
        # fallback when no tests match
        raise ArgumentError, "No tests matched"

      end
    end

    module Parameters
    end

  end
end
