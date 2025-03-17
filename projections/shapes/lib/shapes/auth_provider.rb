# frozen_string_literal: true

# This is generated code!

module ShapeService
  # Resolves the auth scheme from {AuthParameters}.
  class AuthResolver
    # @param [AuthParameters] parameters
    # @return [Smithy::Client::AuthOption]
    def resolve(parameters)
      options = []
      case params.operation_name
      when :operation
      else nil
      end
      options
    end
  end
end
