# frozen_string_literal: true

# This is generated code!

module ShapeService
  # When this service returns an error response, the SDK constructs and raises an error.
  # These errors all extend ShapeService::Errors::ServiceError < {Smithy::Client::Errors::ServiceError}
  #
  # You can rescue all errors using the ServiceError:
  #
  #     begin
  #       # do stuff
  #     rescue ShapeService::Errors::ServiceError
  #       # rescues all API errors
  #     end
  #
  # ## Request Context
  #
  # ServiceError objects have a {Smithy::Client::Errors::ServiceError#context #context} method
  # that returns information about the request that generated the error.
  # See {Smithy::Client::HandlerContext} for more information.
  #
  # ## Error Classes
  #
  #
  # Additionally, error classes are dynamically generated for service errors based on the error code
  # if they are not defined above.
  module Errors
    extend Smithy::Client::Errors::DynamicErrors
  end
end
