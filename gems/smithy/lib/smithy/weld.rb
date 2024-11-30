# frozen_string_literal: true

module Smithy
  class Weld
    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    def self.preprocess
      # no-op
    end
  end
end
