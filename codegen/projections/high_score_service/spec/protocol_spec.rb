# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'high_score_service'

module HighScoreService
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

    describe '#create_high_score' do

    end

    describe '#delete_high_score' do

    end

    describe '#get_high_score' do

    end

    describe '#list_high_scores' do

    end

    describe '#update_high_score' do

    end

  end
end
