# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Auth
    Params = Struct.new(:operation_name, keyword_init: true)

    SCHEMES = [
      Hearth::AuthSchemes::HTTPBasic.new,
      Hearth::AuthSchemes::HTTPBearer.new,
      Hearth::AuthSchemes::HTTPDigest.new,
      Hearth::AuthSchemes::HTTPApiKey.new,
      Hearth::AuthSchemes::Anonymous.new
    ].freeze

    class Resolver

      def resolve(auth_params)
        options = []
        case auth_params.operation_name
        when :operation____paginators_test_with_bad_names
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :defaults_test
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :endpoint_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :endpoint_with_host_label_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :http_api_key_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        when :http_basic_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        when :http_bearer_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        when :http_digest_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :kitchen_sink
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :mixin_test
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :no_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :optional_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :ordered_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        when :paginators_test
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :paginators_test_with_items
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :request_compression_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :request_compression_streaming_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :streaming_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :streaming_with_length
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :waiters_test
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        end
      end

    end
  end
end
