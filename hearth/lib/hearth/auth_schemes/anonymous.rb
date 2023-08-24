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

      # @return [IdentityResolver, nil]
      def identity_resolver(_identity_resolvers = {})
        Hearth::IdentityResolver.new(proc { Identities::Anonymous.new })
      end
    end
  end
end
