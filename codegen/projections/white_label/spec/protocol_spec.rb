# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'white_label'

module WhiteLabel
  describe Client do
    let(:client) do
      Client.new(
        stub_responses: true,
        validate_input: false,
        endpoint: 'http://127.0.0.1',
        retry_strategy: Hearth::Retry::Standard.new(max_attempts: 0)
      )
    end

    describe '#operation____paginators_test_with_bad_names' do

    end

    describe '#custom_auth' do

    end

    describe '#defaults_test' do

    end

    describe '#endpoint_operation' do

    end

    describe '#endpoint_with_host_label_operation' do

    end

    describe '#http_api_key_auth' do

    end

    describe '#http_basic_auth' do

    end

    describe '#http_bearer_auth' do

    end

    describe '#http_digest_auth' do

    end

    describe '#kitchen_sink' do

    end

    describe '#mixin_test' do

    end

    describe '#no_auth' do

    end

    describe '#optional_auth' do

    end

    describe '#ordered_auth' do

    end

    describe '#paginators_test' do

    end

    describe '#paginators_test_with_items' do

    end

    describe '#relative_middleware_operation' do

    end

    describe '#request_compression_operation' do

    end

    describe '#request_compression_streaming_operation' do

    end

    describe '#streaming_operation' do

    end

    describe '#streaming_with_length' do

    end

    describe '#waiters_test' do

    end

  end
end
