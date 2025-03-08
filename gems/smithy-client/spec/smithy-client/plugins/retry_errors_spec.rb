# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/retry_errors'

module Smithy
  module Client
    module Plugins
      describe RetryErrors do
        let(:sample_service) { ClientHelper.sample_service }
        let(:client_class) { sample_service.const_get(:Client) }
        let(:client) { client_class.new(stub_responses: true) }

        it 'adds a :retry_strategy option to config' do
          expect(client.config).to respond_to(:retry_strategy)
        end

        it 'adds a :retry_max_attempts option to config' do
          expect(client.config).to respond_to(:retry_max_attempts)
        end

        it 'adds a :retry_backoff option to config' do
          expect(client.config).to respond_to(:retry_backoff)
        end

        it 'adds an :adaptive_retry_wait_to_fill option to config' do
          expect(client.config).to respond_to(:adaptive_retry_wait_to_fill)
        end

        it 'creates a Standard retry strategy from a string' do
          client = client_class.new(retry_strategy: 'standard')
          expect(client.config.retry_strategy).to be_a(Retry::Standard)
        end

        it 'creates an Adaptive retry strategy from a string' do
          client = client_class.new(retry_strategy: 'adaptive')
          expect(client.config.retry_strategy).to be_a(Retry::Adaptive)
        end

        it 'uses a custom retry strategy' do
          retry_strategy = double('CustomRetryStrategy')
          client = client_class.new(retry_strategy: retry_strategy)
          expect(client.config.retry_strategy).to be(retry_strategy)
        end

        it 'passes flat options to the standard retry strategy class' do
          client = client_class.new(
            retry_strategy: 'standard',
            retry_max_attempts: 5,
            retry_backoff: 2
          )
          expect(client.config.retry_max_attempts).to eq(5)
          expect(client.config.retry_backoff).to eq(2)
          retry_strategy = client.config.retry_strategy
          expect(retry_strategy.max_attempts).to eq(5)
          expect(retry_strategy.backoff).to eq(2)
        end

        it 'passes flat options to the adaptive retry strategy class' do
          client = client_class.new(
            retry_strategy: 'adaptive',
            retry_max_attempts: 5,
            retry_backoff: 2,
            adaptive_retry_wait_to_fill: 5
          )
          expect(client.config.retry_max_attempts).to eq(5)
          expect(client.config.retry_backoff).to eq(2)
          expect(client.config.adaptive_retry_wait_to_fill).to eq(5)
          retry_strategy = client.config.retry_strategy
          expect(retry_strategy.max_attempts).to eq(5)
          expect(retry_strategy.backoff).to eq(2)
          expect(retry_strategy.wait_to_fill).to eq(5)
        end

        it 'adds the handler' do
          expect(client.handlers).to include(Retry::Handler)
        end
      end
    end
  end
end
