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

        def before_initialize(_client_class, options)
          return if options[:auth_schemes]

          options[:default_auth_schemes] ||= {}
          options[:default_auth_schemes]['smithy.api#httpBearerAuth'] = :http_bearer_provider
        end

        class Handler < Client::Handler
          def call(context)
            if context.auth[:scheme_id] == 'smithy.api#httpBearerAuth'
              sign(context)
            end
            @handler.call(context)
          end

          def sign(context)
            reset(context)
            # TODO: does not handle realm or other properties
            context.http_request.headers['Authorization'] = "Bearer #{context.auth[:identity].token}"
          end

          def reset(context)
            context.http_request.headers.delete('Authorization')
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
