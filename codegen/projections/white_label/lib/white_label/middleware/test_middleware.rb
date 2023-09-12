# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Middleware
    # Middleware used for testing plugins and interceptors -
    # applies test_config to the output metadata.
    class TestMiddleware
      def initialize(app, test_config:)
        @app = app
        @test_config = test_config
      end

      def call(input, context)
        output = @app.call(input, context)
        output.metadata[:test_config] = @test_config
        output
      end
    end
  end

end
