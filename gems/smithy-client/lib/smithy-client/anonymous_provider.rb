# frozen_string_literal: true

module Smithy
  module Client
    # @api private
    class AnonymousProvider
      def identity(_properties)
        Identities::Anonymous.new
      end
    end
  end
end
