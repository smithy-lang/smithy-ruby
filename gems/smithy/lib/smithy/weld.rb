# frozen_string_literal: true

module Smithy
  # Base class that all welds must inherit from. Includes hooks for the forging process.
  class Weld
    # @api private
    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    # Called before the model is loaded.
    def self.preprocess
      # no-op
    end
  end
end