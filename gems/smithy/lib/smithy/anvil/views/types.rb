# frozen_string_literal: true

module Smithy
  module Anvil
    module Views
      class Types < View
        def initialize(model)
          @model = model
        end

        def structures
          @model.structures
        end
      end
    end
  end
end
