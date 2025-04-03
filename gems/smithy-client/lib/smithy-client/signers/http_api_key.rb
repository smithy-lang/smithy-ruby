# frozen_string_literal: true

module Smithy
  module Client
    module Signers
      # A signer that signs requests using the HTTP API Key Auth scheme.
      class HttpApiKey < Signer
        def sign(request:, identity:, properties:)
          case properties['in']
          when 'header'
            value = "#{properties['scheme']} #{identity.key}".strip
            request.headers[properties['name']] = value
          when 'query'
            name = properties['name']
            append_query_param(request, name, identity.key)
          end
        end

        def reset(request:, properties:)
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
    end
  end
end
