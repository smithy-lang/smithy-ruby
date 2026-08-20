# frozen_string_literal: true

require 'smithy-schema'

require_relative 'smithy-json/builder'
require_relative 'smithy-json/codec'
require_relative 'smithy-json/extension'
require_relative 'smithy-json/parser'

module Smithy
  # Smithy::Json is a purpose-built set of utilities for working with JSON.
  module Json
    VERSION = File.read(File.expand_path('../VERSION', __dir__.to_s)).strip

    # Raised when a JSON parsing error occurs.
    class ParseError < StandardError; end

    class << self
      # @param [Symbol, Class] engine
      #   Must be one of the following values:
      #
      #   * :oj
      #   * :json
      #
      def engine=(engine)
        @engine = engine.is_a?(Class) ? engine : load_engine(engine)
      end

      # @return [Class] Returns the default engine.
      #   One of:
      #
      #   * {OjEngine}
      #   * {JsonEngine}
      #
      def engine
        set_default_engine unless @engine
        @engine
      end

      def load(json)
        @engine.load(json)
      end

      def dump(value)
        @engine.dump(value)
      end

      def set_default_engine
        %i[oj json].each do |name|
          @engine ||= try_load_engine(name)
        end
        return if @engine

        raise 'Unable to find a compatible json library. ' \
              'Ensure that you have installed or added to your Gemfile one of: oj or json'
      end

      private

      def try_load_engine(name)
        load_engine(name)
      rescue LoadError
        nil
      end

      def load_engine(name)
        require "smithy-json/#{name}_engine"
        const_name = "#{name[0].upcase}#{name[1..]}Engine"
        const_get(const_name)
      end
    end

    set_default_engine
  end
end
