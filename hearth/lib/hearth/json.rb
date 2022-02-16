# frozen_string_literal: true

require_relative 'json/parse_error'
require 'json'

module Hearth
  # Hearth::JSON is a purpose-built set of utilities for working with
  # JSON. It does not support many/most features of generic JSON
  # parsing and serialization.
  # @api private
  module JSON
    class << self
      # @param [String] json
      # @return [Hash]
      def load(json)
        # rubocop:disable Security/JSONLoad
        ::JSON.load(json)
        # rubocop:enable Security/JSONLoad
      rescue ::JSON::ParserError => e
        raise ParseError, e
      end

      # @param [Hash] value
      # @return [String] json
      def dump(value)
        ::JSON.dump(value)
      end
    end
  end
end
