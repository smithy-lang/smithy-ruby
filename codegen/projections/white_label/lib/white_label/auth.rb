# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require_relative 'auth/http_custom_auth'

module WhiteLabel
  module Auth
    Params = Struct.new(:operation_name, :custom_param, keyword_init: true)

    SCHEMES = [
      Hearth::AuthSchemes::HTTPApiKey.new,
      Hearth::AuthSchemes::HTTPBasic.new,
      Hearth::AuthSchemes::HTTPBearer.new,
      Hearth::AuthSchemes::HTTPDigest.new,
      Hearth::AuthSchemes::Anonymous.new,
      HTTPCustomAuthScheme.new
    ].freeze

    class Resolver

      def resolve(auth_params)
        options = []
        case auth_params.operation_name
        when :operation____paginators_test_with_bad_names
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :custom_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :dataplane_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :defaults_test
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :endpoint_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :endpoint_operation_with_resource
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :endpoint_with_host_label_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :http_api_key_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
        when :http_basic_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        when :http_bearer_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        when :http_digest_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :kitchen_sink
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :mixin_test
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :no_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :optional_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :ordered_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
        when :paginators_test
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :paginators_test_with_items
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :relative_middleware_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :request_compression_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :request_compression_streaming_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :streaming_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :streaming_with_length
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        when :waiters_test
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { scheme: 'Authorization', in: 'header', name: 'X-API-Key' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { static_value: 'static', model_value: 'signer' }, identity_properties: { static_value: 'static', model_value: 'identity' })
        end
      end

    end
  end
end
