# frozen_string_literal: true

require 'tempfile'
require 'digest'
require_relative 'checksums/md5'

module Hearth
  # A utility module for calculating checksums.
  # @api private
  module Checksums
    CHUNK_SIZE = 1 * 1024 * 1024 # one MB

    # @param [File, Tempfile, StringIO#read, String] value
    # @return [String<MD5>]
    def self.md5(value)
      if value.is_a?(File) || value.is_a?(Tempfile)
        OpenSSL::Digest.new('MD5').file(value).base64digest
      elsif value.respond_to?(:read)
        md5 = MD5.new
        loop do
          chunk = value.read(CHUNK_SIZE)
          break unless chunk

          md5.update(chunk)
        end
        value.rewind
        md5.base64digest
      else
        MD5.new.tap { |md5| md5.update(value) }.base64digest
      end
    end

  end
end
