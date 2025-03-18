# frozen_string_literal: true

module Smithy
  module Client
    module Signers
      # A signer that does not sign requests.
      class Anonymous < Signer
        def sign(**); end

        def sign_event(message:, prior_signature:, **)
          [message, prior_signature]
        end

        def reset(**); end
      end
    end
  end
end
