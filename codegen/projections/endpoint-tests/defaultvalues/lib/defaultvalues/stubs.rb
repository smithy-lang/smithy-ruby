# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module DefaultValues
  # @api private
  module Stubs

    class GetThing
      def self.build(params, context:)
        Params::GetThingOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::GetThingOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end
  end
end
