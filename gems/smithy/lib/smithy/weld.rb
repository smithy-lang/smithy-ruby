# frozen_string_literal: true

module Smithy
  # Base class that all welds must inherit from. Includes hooks for the forging process.
  class Weld
    # @param [Plan] plan The plan to weld with.
    def initialize(plan)
      @plan = plan
    end

    # Called to determine if the weld should be applied for this model.
    # @param [Hash] model
    # @return [Boolean] (true) True if the weld should be applied, false otherwise.
    def for?(model)
      true
    end

    # Preprocess the model. Called before the model is loaded.
    # @param [Hash] model
    def preprocess(model)
      # no-op
    end
  end
end
