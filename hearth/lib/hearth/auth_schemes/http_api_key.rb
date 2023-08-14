# frozen_string_literal: true

module Hearth
  module AuthSchemes
    # HTTP API Key authentication scheme.
    class HTTPApiKey < AuthSchemes::Base
      def initialize
        super(scheme_id: 'smithy.api#httpApiKeyAuth')
        @identity_type = Identities::HTTPApiKey
        @signer = Signers::HTTPApiKey.new
      end
    end
  end
end
