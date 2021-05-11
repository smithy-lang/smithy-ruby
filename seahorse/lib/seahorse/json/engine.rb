# frozen_string_literal: true

module Seahorse
  module JSON
    # @api private
    class Engine

      def initialize(engine: nil)
        @engine = engine || Engine.default_engine
      end

      def load(json)
        @engine.load(json)
      end

      def load_file(path)
        @engine.load_file(path)
      end

      def dump(value)
        @engine.dump(value)
      end

      class << self

        def load(json)
          new(engine: default_engine).load(json)
        end

        def load_file(path)
          load(File.open(path, 'r', encoding: 'UTF-8', &:read))
        end

        def dump(value)
          new(engine: default_engine).dump(value)
        end

        def set_default_engine(engine)
          @engine = engine
        end

        def default_engine
          @engine
        end

        def oj_engine
          require_relative 'engines/oj_engine'
          Engines::OjEngine
        end

        def json_engine
          require_relative 'engines/json_engine'
          Engines::JsonEngine
        end

      end

      begin
        set_default_engine(oj_engine)
      rescue LoadError
        set_default_engine(json_engine)
      end

    end
  end
end
