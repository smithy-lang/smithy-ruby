# frozen_string_literal: true

module Hearth
  module AuthSchemes
    # HTTP Bearer authentication scheme.
    class HTTPBearer < AuthSchemes::Base
      def initialize
        super(scheme_id: 'smithy.api#httpBearerAuth')
        @identity_type = Identities::HTTPBearer
        @signer = Signers::HTTPBearer.new
      end
    end
  end
end
