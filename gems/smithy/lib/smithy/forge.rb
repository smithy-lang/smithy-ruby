# frozen_string_literal: true

require_relative 'forge/base'
require_relative 'forge/types'

module Smithy
  module Forge
    def self.forge(plan)
      case plan.type
      when :types then Types.new(plan).forge
      else
        raise 'Not yet implemented'
      end
    end
  end
end
