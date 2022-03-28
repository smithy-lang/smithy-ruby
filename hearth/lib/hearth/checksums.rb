# frozen_string_literal: true

require 'tempfile'

module Hearth
  # A utility module for calculating checksums.
  module Checksums
    CHUNK_SIZE = 1 * 1024 * 1024 # one MB

    # @param [File, Tempfile, StringIO#read, String] value
    # @return [String<MD5>]
    def self.md5(value)
      if value.is_a?(File) || value.is_a?(Tempfile)
        OpenSSL::Digest::MD5.file(value).base64digest
      elsif value.respond_to?(:read)
        md5 = OpenSSL::Digest::MD5.new
        update_in_chunks(md5, value)
        md5.base64digest
      else
        OpenSSL::Digest::MD5.base64digest(value)
      end
    end

    private

    def self.update_in_chunks(digest, io)
      loop do
        chunk = io.read(CHUNK_SIZE)
        break unless chunk

        digest.update(chunk)
      end
      io.rewind unless io.is_a?(IO)
    end
  end
end
