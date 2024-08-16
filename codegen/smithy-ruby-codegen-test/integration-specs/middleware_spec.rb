# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    let(:client) { Client.new(stub_responses: true) }

    it 'uses auth resolver, schemes, and identity resolvers' do
      expect(Hearth::Middleware::Auth)
        .to receive(:new)
        .with(anything,
              auth_params: anything,
              auth_resolver: client.config.auth_resolver,
              auth_schemes: client.config.auth_schemes,
              Hearth::Identities::HTTPLogin =>
                client.config.http_login_provider,
              Hearth::Identities::HTTPBearer =>
                client.config.http_bearer_provider,
              Hearth::Identities::HTTPApiKey =>
                client.config.http_api_key_provider,
              Auth::HTTPCustomKey =>
                client.config.http_custom_key_provider)
        .and_call_original

      client.kitchen_sink
    end

    it 'uses disable_host_prefix' do
      expect(Hearth::Middleware::HostPrefix)
        .to receive(:new)
        .with(anything,
              disable_host_prefix: client.config.disable_host_prefix,
              host_prefix: anything)
        .and_call_original

      client.endpoint_operation
    end

    it 'uses disable_request_compression and ' \
       'request_min_compression_size_bytes' do
      expect(Hearth::HTTP::Middleware::RequestCompression)
        .to receive(:new)
        .with(anything,
              disable_request_compression:
                client.config.disable_request_compression,
              request_min_compression_size_bytes:
                client.config.request_min_compression_size_bytes,
              encodings: anything,
              streaming: anything)
        .and_call_original

      client.request_compression
    end

    it 'uses endpoint and endpoint_resolver' do
      expect(Hearth::Middleware::Endpoint)
        .to receive(:new)
        .with(anything,
              endpoint: client.config.endpoint,
              endpoint_resolver: client.config.endpoint_resolver,
              param_builder: anything,
              stage: anything)
        .and_call_original

      client.kitchen_sink
    end

    it 'uses stubs, stub_responses, and http client' do
      expect(Hearth::Middleware::Send)
        .to receive(:new)
        .with(anything,
              stubs: client.config.stubs,
              stub_responses: client.config.stub_responses,
              client: client.config.http_client,
              stub_error_classes: anything,
              stub_data_class: anything,
              stub_message_encoder: anything)
        .and_call_original

      client.kitchen_sink
    end

    it 'uses retry_strategy' do
      expect(Hearth::Middleware::Retry)
        .to receive(:new)
        .with(anything,
              retry_strategy: client.config.retry_strategy,
              error_inspector_class: anything)
        .and_call_original

      client.kitchen_sink
    end

    it 'uses validate_input' do
      expect(Hearth::Middleware::Validate)
        .to receive(:new)
        .with(anything,
              validate_input: client.config.validate_input,
              validator: anything)
        .and_call_original

      client.kitchen_sink
    end

    it 'allows a specific order of middleware to their relatives' do
      output = client.relative_middleware
      expect(output.metadata[:middleware_order])
        .to eq(
          [
            WhiteLabel::Middleware::BeforeMiddleware,
            WhiteLabel::Middleware::MidMiddleware,
            WhiteLabel::Middleware::AfterMiddleware
          ]
        )
    end
  end
end
