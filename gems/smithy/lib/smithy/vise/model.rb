# frozen_string_literal: true

require 'json'

module Smithy
  module Vise
    class Model
      def initialize(json)
        @model = JSON.parse(json)
        Smithy::Weld.descendants.each { |w| w.preprocess(@model) }
      end

      def version
        @model['smithy']
      end

      def shapes
        @shapes ||= begin
          @model['shapes'].each_with_object({}) do |(id, shape), hash|
            hash[id] = Shape.new(id, shape)
          end
        end
      end

      def structures
        shapes.select { |_key, shape| shape.type == 'structure' }
          .map { |k, _v| k.split('#').last }
      end
    end
  end
end
