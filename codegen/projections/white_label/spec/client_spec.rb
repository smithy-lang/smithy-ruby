# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    let(:client) { Client.new(stub_responses: true) }

    describe '#kitchen_sink' do
      it 'validates config' do
        expect do
          Client.new(stub_responses: 'false')
        end.to raise_error(ArgumentError, /config\[:stub_responses\]/)
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

      it 'uses retry_strategy' do
        expect(Hearth::Middleware::Retry)
          .to receive(:new)
          .with(anything,
                retry_strategy: client.config.retry_strategy,
                error_inspector_class: anything)
          .and_call_original

        client.kitchen_sink
      end

      # it 'uses resolver, schemes, and identity resolvers' do
      #   expect(Hearth::Middleware::Auth)
      #     .to receive(:new)
      #     .with(anything,
      #           auth_params: anything,
      #           auth_resolver: client.config.auth_resolver,
      #           auth_schemes: client.config.auth_schemes,
      #           Hearth::Identities::HTTPLogin =>
      #             client.config.http_login_identity_resolver,
      #           Hearth::Identities::HTTPBearer =>
      #             client.config.http_bearer_identity_resolver,
      #           Hearth::Identities::HTTPApiKey =>
      #             client.config.http_api_key_identity_resolver,
      #           Auth::HTTPCustomAuthIdentity =>
      #             client.config.http_custom_auth_identity_resolver)
      #     .and_call_original
      #
      #   client.kitchen_sink
      # end

      it 'uses stub_responses and transmission client' do
        expect(Hearth::Middleware::Send)
          .to receive(:new)
          .with(anything,
                stub_responses: client.config.stub_responses,
                client: client.config.http_client,
                stub_error_classes: anything,
                stub_data_class: anything,
                stubs: anything)
          .and_call_original

        client.kitchen_sink
      end

      it 'uses logger' do
        expect(Hearth::Context)
          .to receive(:new)
          .with(hash_including(logger: client.config.logger))
          .and_call_original

        client.kitchen_sink
      end

      it 'uses endpoint' do
        proc = proc do |context|
          expect(context.request.uri)
            .to eq(URI(client.config.endpoint))
        end
        interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
        client.kitchen_sink({}, interceptors: [interceptor])
      end

      context 'operation overrides' do
        it 'validates config' do
          expect do
            client.kitchen_sink({}, stub_responses: 'false')
          end.to raise_error(ArgumentError, /config\[:stub_responses\]/)
        end

        it 'uses validate_input from options' do
          expect(Hearth::Middleware::Validate)
            .to receive(:new)
            .with(anything,
                  validate_input: false,
                  validator: anything)
            .and_call_original

          client.kitchen_sink({}, validate_input: false)
        end

        it 'uses retry_strategy from options' do
          retry_strategy = Hearth::Retry::Adaptive.new
          expect(Hearth::Middleware::Retry)
            .to receive(:new)
            .with(anything,
                  retry_strategy: retry_strategy,
                  error_inspector_class: anything)
            .and_call_original

          client.kitchen_sink({}, retry_strategy: retry_strategy)
        end

        it 'uses stub_responses and transmission client from options' do
          http_client = Hearth::HTTP::Client.new
          expect(Hearth::Middleware::Send)
            .to receive(:new)
            .with(anything,
                  stub_responses: true,
                  client: http_client,
                  stub_error_classes: anything,
                  stub_data_class: anything,
                  stubs: anything)
            .and_call_original

          client.kitchen_sink(
            {},
            stub_responses: true, http_client: http_client
          )
        end

        it 'uses logger from options' do
          logger = Logger.new(IO::NULL, level: :debug)
          expect(Hearth::Context)
            .to receive(:new)
            .with(hash_including(logger: logger))
            .and_call_original

          client.kitchen_sink({}, logger: logger)
        end

        it 'uses endpoint from options' do
          proc = proc do |context|
            expect(context.request.uri)
              .to eq(URI('https://override.com'))
          end

          interceptor = Hearth::Interceptor.new(read_before_transmit: proc)
          client.kitchen_sink(
            {},
            endpoint: 'https://override.com',
            interceptors: [interceptor]
          )
        end
      end
    end

    context '#relative_middleware_operation' do
      it 'allows a specific order of middleware to their relatives' do
        output = client.relative_middleware_operation
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
end
