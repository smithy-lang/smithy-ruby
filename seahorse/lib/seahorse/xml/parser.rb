# frozen_string_literal: true

module Seahorse
  module XML
    # @api private
    class Parser

      def initialize(engine: nil)
        @engine = engine || Parser.default_engine
      end

      # @param [String<XML>] xml
      # @return [Node]
      def parse(xml)
        @engine.parse(xml)
      end

      class << self

        def parse(xml)
          new(engine: default_engine).parse(xml)
        end

        def set_default_engine(engine)
          @engine = engine
        end

        def default_engine
          @engine
        end

        def ox_engine
          require_relative 'engines/ox_engine'
          Engines::OxEngine.new
        end

        def rexml_engine
          require_relative 'engines/rexml_engine'
          Engines::RexmlEngine.new
        end

      end

      begin
        set_default_engine(ox_engine)
      rescue LoadError
        set_default_engine(rexml_engine)
      end
    end
  end
end
