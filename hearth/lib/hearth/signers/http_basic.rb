# frozen_string_literal: true

module Hearth
  module Signers
    # A signer that signs requests using the HTTP Basic Auth scheme.
    class HTTPBasic < Signers::Base
      def sign(request:, identity:, properties: {})
        # TODO
      end
    end
  end
end
