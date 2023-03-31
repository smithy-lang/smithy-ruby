# frozen_string_literal: true

require 'base64'

module Hearth
  module Checksums
    # Utility class for computing digests on IO like objects
    # Applies only to digest functions that produce 32 bit integer checksums
    # (eg CRC32)
    # @api private
    class Digest32
      # @param [Object] digest_fn
      def initialize(digest_fn)
        @digest_fn = digest_fn
        @value = 0
      end

      def digest_length
        32
      end

      def update(chunk)
        @value = @digest_fn.call(chunk, @value)
      end

      def base64digest
        Base64.encode64([@value].pack('N')).chomp
      end

      def reset
        @value = 0
      end
    end
  end
end
