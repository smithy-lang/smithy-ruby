# frozen_string_literal: true

module Smithy
  module Client
    # Signs requests with the ApiKey identity.
    class ApiKeySigner
      def initialize(options = {})
        @name = options[:name]
        @in = options[:in]
        @scheme = options[:scheme]
      end

      def sign_request(context)
        case @in
        when 'header' then sign_in_header(context.http_request, context.config.api_key_provider)
        when 'query' then sign_in_query_param(context.http_request, context.config.api_key_provider)
        end
      end

      def presign_url(_context)
        raise NotImplementedError
      end

      private

      def sign_in_header(http_request, provider)
        http_request.headers.delete(@name)
        value = "#{@scheme} #{provider.identity.key}".strip
        http_request.headers[@name] = value
      end

      def sign_in_query_param(http_request, provider)
        remove_query_param(http_request)
        append_query_param(http_request, provider)
      end

      def append_query_param(http_request, provider)
        value = provider.identity.key
        if http_request.endpoint.query
          http_request.endpoint.query += "&#{@name}=#{value}"
        else
          http_request.endpoint.query = "#{@name}=#{value}"
        end
      end

      def remove_query_param(http_request)
        return unless http_request.endpoint.query

        parsed = CGI.parse(http_request.endpoint.query)
        parsed.delete(@name)
        # encode_www_form ignores query params without values
        # (CGI parses these as empty lists)
        parsed.each do |key, values|
          parsed[key] = values.empty? ? nil : values
        end
        http_request.endpoint.query = URI.encode_www_form(parsed)
      end
    end
  end
end
