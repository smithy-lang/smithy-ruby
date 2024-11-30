# frozen_string_literal: true

module Smithy
  class Polish
    include Thor::Base
    include Thor::Actions

    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    def initialize(plan)
      @plan = plan
      # Necessary for Thor::Base and Thor::Actions
      self.options = {}
      self.destination_root = plan.options[:destination_root]
    end

    def polish(_artifact)
      # no-op
    end
  end
end
