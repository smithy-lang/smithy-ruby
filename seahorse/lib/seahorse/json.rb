# frozen_string_literal: true

require_relative 'json/parse_error'

module Seahorse

  # Seahorse::JSON is a purpose-built set of utilities for working with
  # JSON. It does not support many/most features of generic JSON
  # parsing and serialization.
  # @api private
  module JSON
    extend self

    def engine
      @engine ||= default_engine
    end

    def engine=(engine)
      @engine = engine
    end

    def load(json, engine: self.engine)
      engine.load(json)
    end

    def dump(value, engine: self.engine)
      engine.dump(value)
    end

    private

    def default_engine
      oj_engine.new
    rescue LoadError
      json_engine.new
    end

    def oj_engine
      require_relative 'json/engines/oj_engine'
      Engines::OjEngine
    end

    def json_engine
      require_relative 'json/engines/json_engine'
      Engines::JsonEngine
    end
  end
end
