# frozen_string_literal: true

module Middleware
  # Middleware used to test relative middleware ordering -
  # this is for 'BEFORE' type testing
  class BeforeMiddleware
    def initialize(app)
      @app = app
    end

    def call(input, context)
      output = @app.call(input, context)
      output.metadata[:middleware_order].unshift(self.class)
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
      output = @app.call(input, context)
      output.metadata[:middleware_order].unshift(self.class)
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
      output = @app.call(input, context)
      output.metadata[:middleware_order] = [self.class]
      output
    end
  end
end
