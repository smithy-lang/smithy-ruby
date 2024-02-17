# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  module Auth
    Params = Struct.new(:operation_name, keyword_init: true)

    SCHEMES = [
      Hearth::AuthSchemes::HTTPApiKey.new,
      Hearth::AuthSchemes::HTTPBasic.new,
      Hearth::AuthSchemes::HTTPBearer.new,
      Hearth::AuthSchemes::HTTPDigest.new,
      Hearth::AuthSchemes::Anonymous.new
    ].freeze

    class Resolver

      def resolve(auth_params)
        options = []
        case auth_params.operation_name
        when :api_key_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'Authorization' })
        end
        when :basic_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        end
        when :bearer_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        end
        when :create_high_score
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        end
        when :delete_high_score
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        end
        when :digest_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        end
        when :get_high_score
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        end
        when :list_high_scores
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        end
        when :update_high_score
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        end
        end
      end

    end
  end
end
