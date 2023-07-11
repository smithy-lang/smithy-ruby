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
    let(:endpoint) { 'http://127.0.0.1' }
    let(:retry_strategy) { Hearth::Retry::Standard.new(max_attempts: 1) }
    let(:config) do
      Config.new(
        stub_responses: true,
        validate_input: false,
        endpoint: endpoint,
        retry_strategy: retry_strategy
      )
    end
    let(:client) { Client.new(config) }
    let(:before_send) do
      Class.new do
        def initialize(&block)
          @block = block
        end

        def read_before_transmit(context)
          @block.call(context)
        end
      end
    end

    let(:after_send) do
      Class.new do
        def initialize(&block)
          @block = block
        end

        def read_after_transmit(context)
          @block.call(context)
        end
      end
    end

    describe '#operation____paginators_test_with_bad_names' do

    end

    describe '#defaults_test' do

    end

    describe '#endpoint_operation' do

    end

    describe '#endpoint_with_host_label_operation' do

    end

    describe '#kitchen_sink' do

    end

    describe '#mixin_test' do

    end

    describe '#paginators_test' do

    end

    describe '#paginators_test_with_items' do

    end

    describe '#streaming_operation' do

    end

    describe '#streaming_with_length' do

    end

    describe '#waiters_test' do

    end

  end
end
