# frozen_string_literal: true

module Smithy
  class Forge
    def initialize(plan)
      @plan = plan
    end

    def forge!
      # TODO: switch case for client, server, and types
      forge_client
    end

    def forge_client
      puts "Load integrations from: #{Smithy::Weld.descendants}"
      Smithy::Weld.descendants.each { |w| w.new.add_thing }
      Smithy::Anvil.hammer(@plan)
    end
  end
end