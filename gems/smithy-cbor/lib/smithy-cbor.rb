# frozen_string_literal: true

require 'smithy-schema'

require_relative 'smithy-cbor/builder'
require_relative 'smithy-cbor/codec'
require_relative 'smithy-cbor/parser'

module Smithy
  # Smithy::Cbor is a purpose-built set of utilities for working with CBOR.
  # It does not support all features of generic CBOR parsing and serialization.
  module Cbor
    VERSION = File.read(File.expand_path('../VERSION', __dir__.to_s)).strip

    def initialize(options = {})
      @engine = options[:engine] || self.class.engine
    end

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
      # @param [Symbol, Class] engine
      #   Must be one of the following values:
      #
      #   * :smithy
      #
      def engine=(engine)
        @engine = engine.is_a?(Class) ? engine : load_engine(engine)
      end

      # @return [Class] Returns the default engine.
      #   One of:
      #
      #   * {SmithyEngine}
      #
      def engine
        set_default_engine unless @engine
        @engine
      end

      def encode(data)
        @engine.encode(data)
      end

      def decode(bytes)
        @engine.decode(bytes)
      end

      def set_default_engine
        %i[smithy].each do |name|
          @engine ||= try_load_engine(name)
        end
        return if @engine

        raise 'Unable to find a compatible cbor library. ' \
              'Ensure that you have installed or added to your Gemfile one of: smithy-cbor'
      end

      private

      def try_load_engine(name)
        load_engine(name)
      rescue LoadError
        nil
      end

      def load_engine(name)
        require "smithy-cbor/#{name}_engine"
        const_name = "#{name[0].upcase}#{name[1..]}Engine"
        const_get(const_name)
      end
    end

    set_default_engine
  end
end
