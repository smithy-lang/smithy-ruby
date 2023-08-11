# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Weather
  class AuthResolver

    def resolve(auth_params = {})
      options = []
      case auth_params[:operation_name]
        when :operation____789_bad_name
        when :get_city
        when :get_city_announcements
        when :get_city_image
        when :get_current_time
        when :get_forecast
        when :list_cities
      end
    end
  end

end
