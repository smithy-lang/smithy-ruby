# frozen_string_literal: true

require_relative '../http_bearer_provider'
require_relative '../identities/http_bearer'

module Smithy
  module Client
    module Plugins
      # @api private
      class HttpBearerAuth < Plugin
        option(
          :http_bearer_token,
          doc_type: String,
          docstring: 'The bearer token to use for authentication.'
        ) do |config|
          'stubbed-bearer-token' if config.stub_responses
        end

        option(
          :http_bearer_provider,
          doc_type: Smithy::Client::HttpBearerProvider,
          docstring: <<~DOCS) do |config|
            A bearer token identity provider. This can be an instance of a {Smithy::Client::HttpBearerProvider} or any
            class that responds to #identity and returns a {Smithy::Client::Identities::HttpBearer}.
          DOCS
          Smithy::Client::HttpBearerProvider.new(config.http_bearer_token) if config.http_bearer_token
        end

        def after_initialize(client)
          client.config.auth_schemes['smithy.api#httpBearerAuth'] = client.config.http_bearer_provider
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            sign(context) if context.auth[:scheme_id] == 'smithy.api#httpBearerAuth'
            @handler.call(context)
          end

          private

          def sign(context)
            context.http_request.headers.delete('Authorization')
            # TODO: does not handle realm or other properties
            context.http_request.headers['Authorization'] = "Bearer #{context.auth[:identity].token}"
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
