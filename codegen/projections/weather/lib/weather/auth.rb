# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Weather
  module Auth
    Params = Struct.new(:operation_name, keyword_init: true)

    SCHEMES = [
      Hearth::AuthSchemes::Anonymous.new
    ].freeze

    class Resolver

      def resolve(params)
        options = []
        case params.operation_name
        when :operation____789_bad_name
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :get_city
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :get_city_announcements
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :get_city_image
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :get_current_time
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :get_forecast
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :list_cities
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        else nil
        end
        options
      end

    end
  end
end
