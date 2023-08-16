# frozen_string_literal: true

module Hearth
  module Signers
    # A signer that does not sign requests.
    class Anonymous < Signers::Base; end
  end
end