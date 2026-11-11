# frozen_string_literal: true

require 'smithy-schema'

require_relative 'smithy-cbor/builder'
require_relative 'smithy-cbor/codec'
require_relative 'smithy-cbor/decoder'
require_relative 'smithy-cbor/encoder'
require_relative 'smithy-cbor/parser'

module Smithy
  # Smithy::Cbor is a purpose-built set of utilities for working with CBOR.
  # It does not support all features of generic CBOR parsing and serialization.
  module Cbor
    VERSION = File.read(File.expand_path('../VERSION', __dir__.to_s)).strip

    # CBOR Tagged data (Major type 6).
    # A Tag consists of a tag number and a value.
    # In the extended generic data model, a tag number's definition
    # describes the additional semantics conveyed with the tag number.
    class Tagged
      # @param [Integer] tag The tag number.
      # @param [Object] value The tag's content.
      def initialize(tag, value)
        @tag = tag
        @value = value
      end

      # The tag number.
      # @return [Integer]
      attr_accessor :tag

      # The tag's content.
      # @return [Object]
      attr_accessor :value
    end

    # Raised when a CBOR build error occurs.
    class BuildError < StandardError; end

    # Raised when a CBOR parsing error occurs.
    class ParseError < StandardError; end

    class << self
      # Encodes generic Ruby data, such as Hashes, Arrays, Strings, Integers, Floats and Times, without a shape.
      # Modeled requests are built with a {Codec} instead.
      #
      # @param [Object] data
      # @return [String] the CBOR bytes
      def encode(data)
        Encoder.new.add(data).bytes
      end

      # Decodes CBOR into generic Ruby data without a shape. Modeled responses are parsed with a {Codec} instead.
      # The bytes are marked as binary in place.
      #
      # @param [String] bytes
      # @return [Object]
      def decode(bytes)
        Decoder.new(bytes.force_encoding(Encoding::BINARY)).decode
      end
    end
  end
end
