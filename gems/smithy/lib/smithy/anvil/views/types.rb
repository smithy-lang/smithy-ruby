# frozen_string_literal: true

module Smithy
  module Anvil
    module Views
      class Types < View
        def initialize(model)
          @model = model
        end

        def structures
          @model['shapes']
            .select { |_key, shape| shape['type'] == 'structure' }
            .map { |k, _v| k.split('#').last }
        end
      end
    end
  end
end