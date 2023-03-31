# frozen_string_literal: true

module Hearth
  module Checksums
    # CRC32C Checksum Digest class - requires aws-crt
    class CRC32C < Digest32
      def initialize
        if Hearth.use_crt?
          super(Aws::Crt::Checksums.method(:crc32c))
        else
          raise ArgumentError, 'Requires the `aws-crt` gem.'
        end
      end
    end
  end
end
