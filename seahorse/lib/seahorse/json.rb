# frozen_string_literal: true

require_relative 'json/engine'
require_relative 'json/parse_error'

# Seahorse::JSON is a purpose-built set of utilities for working with
# JSON. It does not support many/most features of generic JSON
# parsing and serialization.
# @api private
module Seahorse
  module JSON
    class << self

      # @param [String] json
      # @return [Hash]
      def load(json, engine: Engine.default_engine)
        Engine.new(engine: engine).load(json)
      end

      # @param [Hash]
      # @return [String] json
      def dump(value, engine: Engine.default_engine)
        Engine.new(engine: engine).dump(value)
      end

    end
  end
end
