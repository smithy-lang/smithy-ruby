# frozen_string_literal: true

module Smithy
  module Client
    module Errors
      # Raised when a `streaming` operation has `requiresLength` trait
      # enabled but request payload size/length cannot be calculated
      class MissingContentLength < RuntimeError
        def initialize
          msg = 'Required `Content-Length` value missing for the request.'
          super(msg)
        end
      end
    end
  end
end
