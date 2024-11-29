# frozen_string_literal: true

require 'thor'

require_relative 'smithy/tools'
require_relative 'smithy/anvil'
require_relative 'smithy/command'
require_relative 'smithy/forge'
require_relative 'smithy/vise'
require_relative 'smithy/plan'
require_relative 'smithy/polish'
require_relative 'smithy/weld'

module Smithy
  VERSION = File.read(File.expand_path('../VERSION', __dir__)).strip

  class << self
    def smith(plan)
      artifact = Smithy::Forge.forge(plan)
      Smithy::Polish.descendants.each { |p| p.polish(artifact) }
      artifact
    end
  end
end
