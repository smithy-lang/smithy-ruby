# frozen_string_literal: true

module Smithy
  module Forge
    class Types
      def initialize(plan)
        @model = plan.model
      end

      def forge
        Enumerator.new do |e|
          e.yield 'types.rb', Smithy::Anvil::Views::Types.new(@model).hammer
        end
      end
    end
  end
end
