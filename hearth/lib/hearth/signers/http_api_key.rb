# frozen_string_literal: true

module Hearth
  module Signers
    # A signer that signs requests using the HTTP API Key scheme.
    class HTTPApiKey < Signers::Base
      def sign(request:, identity:, properties:)
        case properties[:in]
        when 'header'
          value = "#{properties[:scheme]} #{identity.key}".strip
          request.headers[properties[:name]] = value
        when 'query'
          name = properties[:name]
          request.append_query_param(name, identity.key)
        end
      end
    end
  end
end
