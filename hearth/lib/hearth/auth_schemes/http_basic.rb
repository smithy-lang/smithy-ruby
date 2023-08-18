# frozen_string_literal: true

module Hearth
  module AuthSchemes
    # HTTP Basic authentication scheme.
    class HTTPBasic < AuthSchemes::Base
      def initialize
        super(
          scheme_id: 'smithy.api#httpBasicAuth',
          signer: Signers::HTTPBasic.new,
          identity_type: Identities::HTTPLogin
        )
      end
    end
  end
end
