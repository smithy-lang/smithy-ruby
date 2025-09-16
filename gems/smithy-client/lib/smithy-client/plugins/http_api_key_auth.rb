# frozen_string_literal: true

require_relative '../api_key'
require_relative '../api_key_provider'

module Smithy
  module Client
    module Plugins
      # @api private
      class HttpApiKeyAuth < Plugin
        option(
          :api_key,
          doc_type: String,
          docstring: 'The API key to use for authentication.'
        ) do |config|
          'stubbed-api-key' if config.stub_responses
        end

        option(
          :api_key_provider,
          doc_type: ApiKeyProvider,
          docstring: <<~DOCS) do |config|
            An API key identity provider. This can be an instance of a {Smithy::Client::ApiKeyProvider} or any
            class that responds to #identity and returns a {Smithy::Client::ApiKey}.
          DOCS
          provider = ApiKeyProvider.new(key: config.api_key)
          provider if provider.set?
        end

        def after_initialize(client)
          client.config.auth_schemes['smithy.api#httpApiKeyAuth'] = client.config.api_key_provider
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            sign(context) if context.auth[:scheme_id] == 'smithy.api#httpApiKeyAuth'
            @handler.call(context)
          end

          private

          def sign(context)
            properties = context.config.service.traits['smithy.api#httpApiKeyAuth']
            case properties['in']
            when 'header' then sign_in_header(properties, context.http_request, context.auth[:identity])
            when 'query' then sign_in_query_param(properties, context.http_request, context.auth[:identity])
            end
          end

          def sign_in_header(properties, http_request, identity)
            http_request.headers.delete(properties['name'])
            value = "#{properties['scheme']} #{identity.key}".strip
            http_request.headers[properties['name']] = value
          end

          def sign_in_query_param(properties, http_request, identity)
            name = properties['name']
            remove_query_param(http_request, name)
            append_query_param(http_request, name, identity.key)
          end

          def append_query_param(request, name, value)
            if request.endpoint.query
              request.endpoint.query += "&#{name}=#{value}"
            else
              request.endpoint.query = "#{name}=#{value}"
            end
          end

          def remove_query_param(request, name)
            return unless request.endpoint.query

            parsed = CGI.parse(request.endpoint.query)
            parsed.delete(name)
            # encode_www_form ignores query params without values
            # (CGI parses these as empty lists)
            parsed.each do |key, values|
              parsed[key] = values.empty? ? nil : values
            end
            request.endpoint.query = URI.encode_www_form(parsed)
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
