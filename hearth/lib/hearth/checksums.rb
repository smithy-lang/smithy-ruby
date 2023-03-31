# frozen_string_literal: true

require 'tempfile'
require 'digest'
require_relative 'checksums/digest'
require_relative 'checksums/digest32'
require_relative 'checksums/md5'
require_relative 'checksums/sha1'
require_relative 'checksums/sha256'
require_relative 'checksums/crc32'
require_relative 'checksums/crc32c'

module Hearth
  # A utility module for calculating checksums.
  # @api private
  module Checksums
    CHUNK_SIZE = 1 * 1024 * 1024 # one MB

    # @param [File, Tempfile, StringIO#read, String] value
    # @return [String<MD5>]
    def self.md5(value)
      digest = algorithm_for('MD5')
      if value.respond_to?(:read)
        loop do
          chunk = value.read(CHUNK_SIZE)
          break unless chunk

          digest.update(chunk)
        end
        value.rewind
        digest.base64digest
      else
        digest.tap { |d| d.update(value) }.base64digest
      end
    end

    # @param [String] checksum_algorithm - the name of the algorithm
    # @return [Digest|Digest32] a Digest object for the  checksum_algorithm
    def self.algorithm_for(checksum_algorithm)
      case checksum_algorithm.upcase
      when 'MD5'
        MD5.new
      when 'SHA1'
        SHA1.new
      when 'SHA256'
        SHA256.new
      when 'CRC32'
        CRC32.new
      when 'CRC32C'
        CRC32C.new
      else
        raise ArgumentError,
              "Unsupported checksum algorithm: #{checksum_algorithm}"
      end
    end
  end
end
