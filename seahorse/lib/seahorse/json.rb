# frozen_string_literal: true

require_relative 'json/parse_error'
require 'json'

module Seahorse
  # Seahorse::JSON is a purpose-built set of utilities for working with
  # JSON. It does not support many/most features of generic JSON
  # parsing and serialization.
  # @api private
  module JSON

    class << self

      # @param [String] json
      # @return [Hash]
      def load(json)
        ::JSON.load(json)
      rescue ::JSON::ParserError => e
        raise ParseError, e
      end

      # @param [Hash]
      # @return [String] json
      def dump(value)
        ::JSON.dump(value)
      end

    end

  end
end
