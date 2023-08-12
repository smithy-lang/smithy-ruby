# frozen_string_literal: true

module Hearth
  module Identities
    # Identity class for bearer token authentication.
    class HTTPBearer < Identities::Base
      def initialize(token:, **kwargs)
        super(**kwargs)
        @token = token
      end

      # @return [String]
      attr_reader :token
    end
  end
end
