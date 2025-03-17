# frozen_string_literal: true

module Smithy
  module Client
    # Base class for all Signer classes.
    class Signer
      def sign(_options = {})
        raise NotImplementedError
      end

      def sign_event(_options = {})
        raise NotImplementedError
      end

      def reset(_options = {})
        raise NotImplementedError
      end
    end
  end
end
