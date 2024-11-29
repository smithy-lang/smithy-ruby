# frozen_string_literal: true

require_relative 'forge/base'
require_relative 'forge/types'

module Smithy
  module Forge
    def self.forge(plan)
      case plan.type
      when :types then Types.new(plan).forge
      when :client then raise 'Not yet implemented'
      when :server then raise 'Not yet implemented'
      else
        raise 'Unknown plan type'
      end
    end
  end
end
