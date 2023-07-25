module WhiteLabel
  # frozen_string_literal: true

  module Middleware
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
