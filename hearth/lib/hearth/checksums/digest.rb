# frozen_string_literal: true
require 'digest'
require 'forwardable'

module Hearth
  module Checksums
    # Utility class to wrap StdLib digest classes
    # @api private
    class Digest
      extend Forwardable
      def_delegators :@digest, :digest_length,
                     :base64digest, :reset, :update

      def initialize(digest)
        @digest = digest
      end
    end
  end
end
