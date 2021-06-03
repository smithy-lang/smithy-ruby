# frozen_string_literal: true

module Seahorse
  class BlockIO
    # @param [Proc] block
    def initialize(block)
      @block = block
      @bytes_yielded = 0
    end

    # @return [Integer]
    attr_reader :bytes_yielded

    # @param [String] data
    # @return [Integer] Returns the number of bytes written.
    def write(data)
      @block.call(data)
      @bytes_yielded += data.bytesize
      data.bytesize
    end
  end
end
