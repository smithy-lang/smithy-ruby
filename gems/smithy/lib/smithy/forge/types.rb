# frozen_string_literal: true

module Smithy
  module Forge
    class Types
      def initialize(plan)
        @plan = plan
        @model = plan.model
      end

      def forge
        Smithy::Weld.descendants.each { |w| w.weld }
        Enumerator.new do |e|
          e.yield 'types.rb', Smithy::Anvil::Views::Types.new(@model).render
        end
      end
    end
  end
end
