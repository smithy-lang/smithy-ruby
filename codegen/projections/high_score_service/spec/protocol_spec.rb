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
    let(:client) do
      Client.new(
        stub_responses: true,
        validate_input: false,
        endpoint: 'http://127.0.0.1',
        retry_strategy: Hearth::Retry::Standard.new(max_attempts: 0)
      )
    end

    describe '#api_key_auth' do

    end

    describe '#basic_auth' do

    end

    describe '#bearer_auth' do

    end

    describe '#create_high_score' do

    end

    describe '#delete_high_score' do

    end

    describe '#digest_auth' do

    end

    describe '#get_high_score' do

    end

    describe '#list_high_scores' do

    end

    describe '#update_high_score' do

    end

  end
end
