# frozen_string_literal: true

require_relative 'forge/base'
require_relative 'forge/client'
require_relative 'forge/types'

module Smithy
  # Facilitates forging of Smithy plans.
  module Forge
    # (see Smithy::Forge::Base#forge)
    def self.forge(model, plan)
      Welds.for(model).each { |weld| weld.preprocess(model) }
      model = Vise::Model.new(model)

      case plan.type
      when :types then Types.new(model, plan).forge
      when :client then Client.new(model, plan).forge
      else
        raise 'Not yet implemented'
      end
    end
  end
end
