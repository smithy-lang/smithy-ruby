# frozen_string_literal: true

module Smithy
  # Base class that all welds must inherit from. Includes hooks for the forging process.
  class Weld
    # @api private
    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    # Called before the model is loaded.
    def self.preprocess(_model)
      # no-op
    end

    # Called when constructing a plan
    # @return [BuiltInBinding] list of built in bindings for use in endpoint rules.
    def self.built_in_bindings
      []
    end

    # Called when constructing a plan
    # @return [FunctionBinding] list of function bindings for use in endpoint rules.
    def self.function_bindings
      []
    end
  end
end
