# frozen_string_literal: true

module Smithy
  module Client
    # Streams response chunks to the caller's block.
    # Owns no resources; delivered chunks cannot be retracted on failure.
    class BlockIO
      # @param [Hash] headers (nil)
      # @param [Proc] block
      def initialize(headers = nil, &block)
        @headers = headers
        @block = block
        @size = 0
      end

      # @return [Integer]
      attr_reader :size

      # @param [String] chunk
      # @return [Integer]
      def write(chunk)
        @block.call(chunk, @headers)
        chunk.bytesize
      ensure
        chunk.bytesize.tap { |chunk_size| @size += chunk_size }
      end

      # @param [Integer, nil] bytes (nil)
      # @param [String, nil] output_buffer (nil)
      # @return [String, nil]
      def read(bytes = nil, output_buffer = nil)
        data = bytes ? nil : ''
        output_buffer ? output_buffer.replace(data || '') : data
      end
    end
  end
end
