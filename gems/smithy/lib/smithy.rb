# frozen_string_literal: true

require_relative 'smithy/anvil'
require_relative 'smithy/forge'
require_relative 'smithy/plan'
require_relative 'smithy/polish'
require_relative 'smithy/weld'

module Smithy
  VERSION = File.read(File.expand_path('../VERSION', __dir__)).strip

  class << self
    def smith(plan)
      Smithy::Forge.new(plan).forge!
      polish
    end

    private

    def polish
      puts "Polishing with descendents #{Smithy::Polish.descendants}"
      Smithy::Polish.descendants.each { |p| p.new.post_process }
    end
  end
end