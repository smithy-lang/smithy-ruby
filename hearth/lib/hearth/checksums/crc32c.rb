# frozen_string_literal: true

module Hearth
  module Checksums
    # CRC32C Checksum Digest class - requires aws-crt
    class CRC32C < Digest32
      def initialize
        unless Hearth.use_crt?
          raise ArgumentError, 'Requires the `aws-crt` gem.'
        end

        super(Aws::Crt::Checksums.method(:crc32c))
      end
    end
  end
end
