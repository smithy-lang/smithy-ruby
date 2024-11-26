# frozen_string_literal: true

module Smithy
  module Anvil
    module Views
      class Types < View
        def initialize(model)
          @model = model
        end

        def types
          @model
            .shapes
            .select { |_key, shape| shape.type == 'structure' }
            .reject { |_key, shape| shape.traits.any? { |_id, trait| trait.name == 'error' } }
            .map { |_key, structure| structure.name }
        end
      end
    end
  end
end
