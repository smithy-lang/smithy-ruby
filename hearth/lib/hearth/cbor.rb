# frozen_string_literal: true

require_relative 'cbor/encoder'
require_relative 'cbor/decoder'

module Hearth
  # Hearth::Cbor is a purpose-built set of utilities for working with
  # Cbor. It does not support all features of generic Cbor
  # parsing and serialization.
  # @api private
  module CBOR
    # CBOR Tagged data (Major type 6).
    # A Tag consists of a tag number and a value.
    # In the extended generic data model, a tag number's definition
    # describes the additional semantics conveyed with the tag number.
    # # @!method initialize(*args)
    #   @option args [Integer] :tag The tag number.
    #   @option args [Object] :value The tag's content.
    # @!attribute tag
    #   The tag number.
    #   @return [Integer]
    # @!attribute value
    #   The tag's content.
    #   @return [Object]
    Tagged = Struct.new(:tag, :value)

    # Generic Cbor error, super class for specific encode/decode related errors.
    class Error < StandardError; end

    # Malformed buffer, expected more bytes
    class OutOfBytesError < Error
      def initialize(requested_bytes, left)
        super("Out of bytes. Trying to read #{requested_bytes} " \
              "bytes but buffer contains only #{left}")
      end
    end

    # unknown or unsupported typed
    class UnknownTypeError < Error
      def initialize(type)
        super("Unable to encode #{type}")
      end
    end

    # Malformed buffer, more bytes than expected
    class ExtraBytesError < Error
      def initialize(pos, size)
        super('Extra bytes follow after decoding item. ' \
              "Read #{pos} / #{size} bytes")
      end
    end

    # Malformed buffer, unexpected break code
    class UnexpectedBreakCodeError < Error; end

    # malformed buffer, unexpected additional information
    class UnexpectedAdditionalInformationError < Error
      def initialize(add_info)
        super("Unexpected additional information: #{add_info}")
      end
    end

    class << self
      # @param [Hash] data
      # @return [String] cbor
      def encode(data)
        Encoder.new.add(data).bytes
      end

      # @param [String] bytes
      # @return [Hash]
      def decode(bytes)
        Decoder.new(bytes).decode
      end
    end
  end
end
