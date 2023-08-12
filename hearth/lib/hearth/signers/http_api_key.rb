# frozen_string_literal: true

module Hearth
  module Signers
    # A signer that signs requests using the HTTP API Key scheme.
    class HTTPApiKey < Signers::Base
      def sign(request:, identity:, properties: {})
        # TODO
      end
    end
  end
end
