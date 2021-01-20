# frozen_string_literal: true

require 'stringio'
require 'tempfile'

module Seahorse
  class BufferedIO

    TEN_MB = 10 * 1024 * 1024

    TEMPFILE_PREFIX = 'buffered-io'

    # @api private
    Stat = Struct.new(:size)

    def initialize(bytes: nil, high_watermark: TEN_MB)
      @high_watermark = high_watermark
      @buffer = StringIO.new
      @buffered_bytes = 0
      if bytes
        write(bytes)
        rewind
      end
    end

    # @param [String] data
    # @return [Integer] Returns the number of bytes written
    def write(data)
      num_bytes = data.bytesize
      buffer.write(data)
      @buffered_bytes += num_bytes
      num_bytes
    end

    def read(bytes = nil, output_buffer = nil)
      @buffer.read(bytes, output_buffer)
    end

    def rewind
      @buffer.rewind
    end

    def size
      @buffer.size
    end

    def truncate(position)
      @buffer.truncate(position)
    end

    # @api private
    def stat
      if @buffer.is_a?(StringIO)
        Stat.new(size)
      else
        @buffer.stat
      end
    end

    private

    def buffer
      if @buffer.is_a?(StringIO) && @buffered_bytes > @high_watermark
        tempfile = Tempfile.new(TEMPFILE_PREFIX)
        tempfile.write(@buffer.string)
        @buffer = tempfile
        def self.buffer
          @buffer
        end
      end
      @buffer
    end

  end
end
