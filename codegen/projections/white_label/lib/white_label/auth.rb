# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require_relative 'auth/http_custom_auth'

module WhiteLabel
  module Auth
    class Params
      def initialize(custom_param: nil, operation_name: nil)
        @custom_param = custom_param
        @operation_name = operation_name
      end

      attr_accessor :custom_param, :operation_name
    end

    SCHEMES = [
      Hearth::AuthSchemes::HTTPApiKey.new,
      Hearth::AuthSchemes::HTTPBasic.new,
      Hearth::AuthSchemes::HTTPBearer.new,
      Hearth::AuthSchemes::HTTPDigest.new,
      Hearth::AuthSchemes::Anonymous.new,
      HTTPCustomAuthScheme.new
    ].freeze

    class Resolver

      def resolve(params)
        options = []
        case params.operation_name
        when :operation____paginators_test_with_bad_names
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :custom_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :dataplane_endpoint
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :defaults_test
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :endpoint_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :endpoint_with_host_label_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :http_api_key_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
        when :http_basic_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
        when :http_bearer_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
        when :http_digest_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
        when :kitchen_sink
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :mixin_test
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :no_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :optional_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :ordered_auth
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
        when :paginators_test
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :paginators_test_with_items
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :relative_middleware
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :request_compression
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :request_compression_streaming
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :resource_endpoint
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :start_event_stream
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :streaming
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :streaming_with_length
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        when :telemetry_test
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :waiters_test
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpApiKeyAuth', signer_properties: { in: 'header', name: 'X-API-Key', scheme: 'Authorization' })
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBasicAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpBearerAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#httpDigestAuth')
          options << Hearth::AuthOption.new(scheme_id: 'smithy.ruby.tests#httpCustomAuth', signer_properties: { model_value: 'signer', static_value: 'static' }, identity_properties: { model_value: 'identity', static_value: 'static' })
        else nil
        end
        options
      end

    end
  end
end
