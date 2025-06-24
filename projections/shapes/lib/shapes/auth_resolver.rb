# frozen_string_literal: true

# This is generated code!

module ShapeService
  # Resolves the auth scheme from {AuthParameters}.
  class AuthResolver
    # @param [HandlerContext] context
    # @return [String]
    def resolve(context)
      parameters = AuthParameters.create(context)
      options = []
      options << 'smithy.api#noAuth'
      options
    end
  end
end
