# frozen_string_literal: true

# This is generated code!

module ShapeService
  # Resolves the auth scheme from {AuthParameters}.
  class AuthResolver
    # @param [AuthParameters] parameters
    # @return [String]
    def resolve(parameters)
      options = []
      options << 'smithy.api#noAuth'
      options
    end
  end
end
