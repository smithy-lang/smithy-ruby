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

      # @return [IdentityProvider, nil]
      def identity_provider(_identity_providers = {})
        Hearth::IdentityProvider.new(proc { Identities::Anonymous.new })
      end
    end
  end
end
