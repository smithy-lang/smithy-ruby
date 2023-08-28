# frozen_string_literal: true

module Hearth
  # Namespace for all Identity classes.
  module Identities
    # Base class for all Identity classes.
    class Base
      def initialize(expiration: nil)
        @expiration = expiration
      end

      # @return [Time, nil]
      attr_reader :expiration
    end
  end
end

require_relative 'identities/anonymous'
require_relative 'identities/http_api_key'
require_relative 'identities/http_bearer'
require_relative 'identities/http_login'
