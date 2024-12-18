# frozen_string_literal: true

require_relative 'forge/base'
require_relative 'forge/client'
require_relative 'forge/types'

module Smithy
  # Facilitates forging of Smithy plans.
  module Forge
    # (see Smithy::Forge::Base#forge)
    def self.forge(plan)
      case plan.type
      when :types then Types.new(plan).forge
      when :client then Client.new(plan).forge
      else
        raise 'Not yet implemented'
      end
    end
  end
end
