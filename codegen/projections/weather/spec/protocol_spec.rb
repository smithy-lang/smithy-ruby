# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'weather'

module Weather
  describe Client do
    let(:client) do
      Client.new(
        stub_responses: true,
        validate_input: false,
        endpoint: 'http://127.0.0.1',
        retry_strategy: Hearth::Retry::Standard.new(max_attempts: 0)
      )
    end

    describe '#operation____789_bad_name' do

    end

    describe '#get_city' do

    end

    describe '#get_city_announcements' do

    end

    describe '#get_city_image' do

    end

    describe '#get_current_time' do

    end

    describe '#get_forecast' do

    end

    describe '#list_cities' do

    end

  end
end
