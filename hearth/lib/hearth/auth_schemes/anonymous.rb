# frozen_string_literal: true

module Hearth
  module AuthSchemes
    # Anonymous authentication scheme.
    class Anonymous < AuthSchemes::Base
      def initialize
        super(
          scheme_id: 'smithy.api#noAuth',
          signer: Signers::Anonymous.new,
          identity_type: Identities::Anonymous
        )
      end
    end
  end
end
