# frozen_string_literal: true

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

  # Middleware used to test relative middleware ordering -
  # this is for 'BEFORE' type testing
  class BeforeMiddleware
    def initialize(app)
      @app = app
    end

    def call(input, context)
      context.metadata[:middleware_order] ||= []
      context.metadata[:middleware_order] << 1
      output = @app.call(input, context)
      output.metadata[:middleware_order] = context.metadata[:middleware_order]
      output
    end
  end

  # Middleware used to test relative middleware ordering -
  # tests a case when a relative middleware is not required
  class MidMiddleware
    def initialize(app)
      @app = app
    end

    def call(input, context)
      context.metadata[:middleware_order] ||= []
      context.metadata[:middleware_order] << 2
      output = @app.call(input, context)
      output.metadata[:middleware_order] = context.metadata[:middleware_order]
      output
    end
  end

  # Middleware used to test relative middleware ordering -
  # this is for 'AFTER' type testing
  class AfterMiddleware
    def initialize(app)
      @app = app
    end

    def call(input, context)
      context.metadata[:middleware_order] ||= []
      context.metadata[:middleware_order] << 3
      output = @app.call(input, context)
      output.metadata[:middleware_order] = context.metadata[:middleware_order]
      output
    end
  end
end
