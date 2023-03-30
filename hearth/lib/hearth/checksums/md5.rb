# frozen_string_literal: true
require 'digest'
require 'forwardable'

module Hearth
  module Checksums
    # MD5 Checksum Digest class
    # @api private
    class MD5
      extend Forwardable
      def_delegators :@digest, :digest_length, :block_length,
                     :base64digest, :reset, :update
      def initialize
        @digest = Digest::MD5.new
      end
    end
  end
end
