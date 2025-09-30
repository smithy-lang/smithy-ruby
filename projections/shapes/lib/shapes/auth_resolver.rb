# frozen_string_literal: true

# This is generated code!

module ShapeService
  # Resolves the auth scheme from {AuthParameters}.
  class AuthResolver
    # @param [AuthParameters] parameters
    # @return [Array<Hash>]
    def resolve(parameters)
      options = []
      options << { scheme_id: 'smithy.api#noAuth' }
      options
    end
  end
end
