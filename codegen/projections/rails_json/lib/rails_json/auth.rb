# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module RailsJson
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
        when :all_query_string_types
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :constant_and_variable_query_string
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :constant_query_string
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :document_type
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :document_type_as_payload
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :empty_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :endpoint_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :endpoint_with_host_label_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :greeting_with_errors
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :http_payload_traits
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :http_payload_traits_with_media_type
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :http_payload_with_structure
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :http_prefix_headers
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :http_prefix_headers_in_response
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :http_request_with_float_labels
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :http_request_with_greedy_label_in_path
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :http_request_with_labels
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :http_request_with_labels_and_timestamp_format
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :http_response_code
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :ignore_query_params_in_response
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :input_and_output_with_headers
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :json_enums
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :json_maps
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :json_unions
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :kitchen_sink_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :media_type_header
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :nested_attributes_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :null_and_empty_headers_client
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :null_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :omits_null_serializes_empty_string
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :operation_with_optional_input_output
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :query_idempotency_token_auto_fill
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :query_params_as_string_list_map
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :streaming_operation
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        when :timestamp_format_headers
          options << Hearth::AuthOption.new(scheme_id: 'smithy.api#noAuth')
        else nil
        end
        options
      end

    end
  end
end
