# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  class AuthResolver

    def resolve(auth_params = {})
      options = []
      case auth_params[:operation_name]
      when :operation____paginators_test_with_bad_names
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      when :custom_auth
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      when :defaults_test
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      when :endpoint_operation
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      when :endpoint_with_host_label_operation
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      when :http_api_key_auth
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
      when :http_basic_auth
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
      when :http_bearer_auth
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
      when :http_digest_auth
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
      when :kitchen_sink
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      when :mixin_test
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      when :no_auth
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
      when :optional_auth
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
      when :ordered_auth
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
      when :paginators_test
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      when :paginators_test_with_items
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      when :request_compression_operation
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      when :request_compression_streaming_operation
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      when :streaming_operation
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      when :streaming_with_length
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      when :waiters_test
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      else
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signing_properties: { name: 'X-API-Key', in: 'header', scheme: 'Authorization' })
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth')
      end
    end

  end
end
