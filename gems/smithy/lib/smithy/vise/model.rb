# frozen_string_literal: true

module Smithy
  module Vise
    class Model
      def initialize(model)
        Smithy::Weld.descendants.each { |w| w.preprocess(model) }
        puts "TestWeld.preprocess has preprocess key: #{model['preprocess']}"
        @model = parse_model(model)
      end

      # @return [String]
      attr_reader :version

      # @return [Hash<String, Shape>]
      attr_reader :shapes

      private

      def parse_model(model)
        @version = model['smithy']
        @shapes = model['shapes'].each_with_object({}) { |(id, shape), h| h[id] = Shape.new(id, shape) }
      end
    end
  end
end
