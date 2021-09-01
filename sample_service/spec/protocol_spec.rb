# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'webmock/rspec'

module SampleService
  describe Client do
    let(:endpoint) { 'http://127.0.0.1' }
    let(:client) { Client.new(endpoint: endpoint) }


    describe '#create_high_score' do
    end
    describe '#delete_high_score' do
    end
    describe '#get_high_score' do
      describe 'requests' do

        it 'serializes_http_label' do
          stub_request(:get, "#{endpoint}/high_scores/1")
            .to_return(body: '{}')
          client.get_high_score(id: '1')
        end
      end
    end
    describe '#list_high_scores' do
    end
    describe '#update_high_score' do
    end
  end
end
