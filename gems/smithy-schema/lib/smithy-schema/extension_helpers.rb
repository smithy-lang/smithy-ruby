# frozen_string_literal: true

module Smithy
  module Schema
    # Shared generic extension helpers used across protocol-specific extensions.
    # @api private
    module ExtensionHelpers
      def sparse?(shape)
        shape.traits.key?('smithy.api#sparse')
      end
    end
  end
end
