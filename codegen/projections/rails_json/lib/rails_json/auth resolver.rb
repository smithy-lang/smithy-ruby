# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module RailsJson
  class AuthResolver

    def resolve(auth_params = {})
      options = []
      case auth_params[:operation_name]
        when :operation____789_bad_name
        when :all_query_string_types
        when :constant_and_variable_query_string
        when :constant_query_string
        when :document_type
        when :document_type_as_payload
        when :empty_operation
        when :endpoint_operation
        when :endpoint_with_host_label_operation
        when :greeting_with_errors
        when :http_payload_traits
        when :http_payload_traits_with_media_type
        when :http_payload_with_structure
        when :http_prefix_headers
        when :http_prefix_headers_in_response
        when :http_request_with_float_labels
        when :http_request_with_greedy_label_in_path
        when :http_request_with_labels
        when :http_request_with_labels_and_timestamp_format
        when :http_response_code
        when :ignore_query_params_in_response
        when :input_and_output_with_headers
        when :json_enums
        when :json_maps
        when :json_unions
        when :kitchen_sink_operation
        when :media_type_header
        when :nested_attributes_operation
        when :null_and_empty_headers_client
        when :null_operation
        when :omits_null_serializes_empty_string
        when :operation_with_optional_input_output
        when :query_idempotency_token_auto_fill
        when :query_params_as_string_list_map
        when :streaming_operation
        when :timestamp_format_headers
      end
    end
  end

end
