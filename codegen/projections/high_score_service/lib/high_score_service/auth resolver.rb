# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  class AuthResolver

    def resolve(auth_params = {})
      options = []
      case auth_params[:operation_name]
        when :create_high_score
        when :delete_high_score
        when :get_high_score
        when :list_high_scores
        when :update_high_score
      end
    end
  end

end
