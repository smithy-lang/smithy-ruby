# frozen_string_literal: true

# This is generated code!

module Weather
  # Resolves the auth scheme from {AuthParameters}.
  class AuthResolver
    # @param [AuthParameters] parameters
    # @return [Smithy::Client::AuthOption]
    def resolve(_parameters)
      options = []
      case params.operation_name
      when :get_city
      when :get_current_time
      when :get_forecast
      when :list_cities
      end
      options
    end
  end
end
