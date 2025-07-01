# frozen_string_literal: true

require_relative '../http_api_key_provider'
require_relative '../identities/http_api_key'
require_relative 'resolve_auth'

module Smithy
  module Client
    module Plugins
      # @api private
      class HttpApiKeyAuth < Plugin
        option(
          :http_api_key,
          doc_type: String,
          docstring: 'The API key to use for authentication.'
        ) do |config|
          'stubbed-api-key' if config.stub_responses
        end

        option(
          :http_api_key_provider,
          doc_type: HttpApiKeyProvider,
          docstring: <<~DOCS) do |config|
            An API key identity provider. This can be an instance of a {Smithy::Client::HttpApiKeyProvider} or any
            class that responds to #identity and returns a {Smithy::Client::Identities::HttpApiKey}.
          DOCS
          HttpApiKeyProvider.new(config.http_api_key) if config.http_api_key
        end

        def after_initialize(client)
          client.config.auth_schemes['smithy.api#httpApiKeyAuth'] = :http_api_key_provider
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            sign(context) if context.auth[:scheme_id] == 'smithy.api#httpApiKeyAuth'
            @handler.call(context)
          end

          def sign(context) # rubocop:disable Metrics/AbcSize
            reset(context)
            request = context.http_request
            identity = context.auth[:identity]
            properties = context.config.service.traits['smithy.api#httpApiKeyAuth']
            case properties['in']
            when 'header'
              value = "#{properties['scheme']} #{identity.key}".strip
              request.headers[properties['name']] = value
            when 'query'
              name = properties['name']
              append_query_param(request, name, identity.key)
            end
          end

          def reset(context)
            request = context.http_request
            properties = context.config.service.traits['smithy.api#httpApiKeyAuth']
            case properties['in']
            when 'header'
              request.headers.delete(properties['name'])
            when 'query'
              name = properties['name']
              remove_query_param(request, name)
            end
          end

          private

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
