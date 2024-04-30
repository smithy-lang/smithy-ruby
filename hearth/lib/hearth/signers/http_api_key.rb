# frozen_string_literal: true

module Hearth
  module Signers
    # A signer that signs requests using the HTTP API Key Auth scheme.
    class HTTPApiKey < Signers::Base
      def sign(request:, identity:, properties:)
        case properties[:in]
        when 'header'
          value = "#{properties[:scheme]} #{identity.key}".strip
          request.headers[properties[:name]] = value
        when 'query'
          name = properties[:name]
          request.append_query_param(name, identity.key)
        else nil
        end
      end

      def reset(request:, properties:)
        case properties[:in]
        when 'header'
          request.headers.delete(properties[:name])
        when 'query'
          name = properties[:name]
          request.remove_query_param(name)
        else nil
        end
      end
    end
  end
end
