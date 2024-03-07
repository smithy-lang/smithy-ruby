# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  # frozen_string_literal: true

  module Middleware
    # A middleware that extracts a request id from a response and sets it
    # on output's metadata.
    # @api private
    class RequestId
      def initialize(app, _ = {})
        @app = app
      end

      def call(input, context)
        output = @app.call(input, context)
        output.metadata[:request_id] = context.response.headers['x-request-id']
        output
      end
    end
  end

end
