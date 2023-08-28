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
      context.metadata[:before_middleware] = true
      @app.call(input, context)
    end
  end

  # Middleware used to test relative middleware ordering -
  # checks the 'BEFORE' middleware and an optional case
  # when a relative middleware is not required
  class MidMiddleware
    def initialize(app, verify_before_middleware:)
      @app = app
      @verify_before_middleware = verify_before_middleware
    end

    def call(input, context)
      @verify_before_middleware&.call(context.metadata)
      context.metadata[:mid_middleware] = true
      @app.call(input, context)
    end
  end

  # Middleware used to test relative middleware ordering -
  # this is for 'AFTER' type testing and verifies
  # the existence of the mid middleware
  class AfterMiddleware
    def initialize(app, verify_mid_middleware:)
      @app = app
      @verify_mid_middleware = verify_mid_middleware
    end

    def call(input, context)
      @verify_mid_middleware&.call(context.metadata)
      @app.call(input, context)
    end
  end
end
