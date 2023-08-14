# frozen_string_literal: true

module Hearth
  module AuthSchemes
    # HTTP Basic authentication scheme.
    class HTTPBasic < AuthSchemes::Base
      def initialize
        super(scheme_id: 'smithy.api#httpBasicAuth')
        @identity_type = Identities::HTTPBasic
        @signer = Signers::HTTPBasic.new
      end
    end
  end
end
