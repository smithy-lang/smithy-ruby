# frozen_string_literal: true

module Hearth
  module AuthSchemes
    # Anonymous authentication scheme.
    class Anonymous < AuthSchemes::Base
      def initialize
        super(scheme_id: 'smithy.api#noAuth')
        @identity_type = Identities::Anonymous
        @signer = Signers::Anonymous.new
      end
    end
  end
end
