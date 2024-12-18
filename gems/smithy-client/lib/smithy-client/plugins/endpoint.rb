# frozen_string_literal: true

require 'uri'

module Smithy
  module Client
    module Plugins
      # @api private
      class Endpoint < Plugin
        option(
          :endpoint,
          doc_type: 'String, URI::HTTPS, URI::HTTP',
          docstring: <<~DOCS)
            Configures the endpoint for the client. The endpoint should
            be a URI formatted like:

                'https://example.com'
                'https://example.com'
                'https://example.com:123'
          DOCS

        def add_handlers(handlers, _config)
          handlers.add(Handler, priority: 90)
        end

        def after_initialize(client)
          endpoint = client.config.endpoint
          raise ArgumentError, 'missing required option `:endpoint`' if endpoint.nil?

          endpoint = URI.parse(endpoint.to_s)
          if !endpoint.is_a?(URI::HTTPS) && !endpoint.is_a?(URI::HTTP)
            raise ArgumentError, 'expected `:endpoint` to be a HTTP or HTTPS endpoint'
          end

          client.config.endpoint = endpoint
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            context.request.endpoint = URI.parse(context.config.endpoint.to_s)
            @handler.call(context)
          end
        end
      end
    end
  end
end
