# frozen_string_literal: true

module Smithy
  class Polish
    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    def post_process
      raise NotImplementedError
    end
  end
end

class TestPolish < Smithy::Polish
  def post_process
    puts "I'm doing something with polishing!"
  end
end
