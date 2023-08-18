# frozen_string_literal: true

module Hearth
  module Signers
    # Base class for all Signer classes.
    class Base
      def sign(request:, identity:, properties: {})
        # do nothing
      end
    end
  end
end

require_relative 'signers/anonymous'
require_relative 'signers/http_api_key'
require_relative 'signers/http_basic'
require_relative 'signers/http_bearer'
require_relative 'signers/http_digest'
