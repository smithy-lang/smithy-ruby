# frozen_string_literal: true

module Smithy
  class Polish
    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    def polish(artifact)
      raise NotImplementedError
    end
  end
end

class TestPolish < Smithy::Polish
  def self.polish(artifact)
    puts "Polishing artifact: #{artifact.inspect}"
  end
end
