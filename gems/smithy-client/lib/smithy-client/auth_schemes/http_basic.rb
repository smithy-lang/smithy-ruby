# frozen_string_literal: true

require_relative '../signers/http_basic'
require_relative '../identities/http_login'

module Smithy
  module Client
    module AuthSchemes
      # Auth scheme for HTTP Basic.
      class HttpBasic < AuthScheme
        def initialize(options = {})
          super(
            'smithy.api#HttpBasicAuth',
            signer: options.fetch(:signer, Signers::HttpBasic.new),
            identity_type: Identities::HttpLogin
          )
        end
      end
    end
  end
end
