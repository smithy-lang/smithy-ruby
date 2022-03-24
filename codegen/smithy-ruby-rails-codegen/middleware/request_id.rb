module Middleware
  # A middleware that extracts a request id from a response and sets it
  # on the context.
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