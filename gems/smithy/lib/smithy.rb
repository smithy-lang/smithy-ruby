# frozen_string_literal: true

require 'rails/railtie'
require 'thor'

require_relative 'smithy/tools'
require_relative 'smithy/anvil'
require_relative 'smithy/command'
require_relative 'smithy/forge'
require_relative 'smithy/vise'
require_relative 'smithy/plan'
require_relative 'smithy/polish'
require_relative 'smithy/polishes'
require_relative 'smithy/weld'
require_relative 'smithy/welds'

# Smithy is a modeling language created by AWS. This gem provides a Ruby
# implementation of the Smithy language and generates clients, servers, and types.
module Smithy
  VERSION = File.read(File.expand_path('../VERSION', __dir__)).strip

  class << self
    # Generates a Ruby artifact from a Smithy model.
    # @param [Hash] model The Smithy model to generate the artifact from.
    # @param [Plan] plan The plan to generate the artifact from.
    def smith(model, plan)
      Welds.load!(plan)
      Polishes.load!(plan)

      artifact = Smithy::Forge.forge(model, plan)
      Polishes.for(model).each { |polish| polish.polish(artifact) }
      artifact
    end
  end
end
