# frozen_string_literal: true

module Smithy
  class Weld
    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    def add_thing
      raise NotImplementedError
    end
  end
end

class TestWeld < Smithy::Weld
  def self.weld
    puts "I'm adding a thing in the weld!"
  end
end
