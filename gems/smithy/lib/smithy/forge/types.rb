# frozen_string_literal: true

module Smithy
  module Forge
    class Types
      def initialize(plan)
        @model = plan.model
      end

      def forge
        Enumerator.new do |e|
          # Option 1 - use ERB with views ourselves.
          e.yield 'types.rb', Smithy::Anvil::Views::Types.new(@model).hammer
          # Option 2 - Use thor generator (groups/actions) and pass ONE instance
          # of something, either the model or a view.
          Smithy::Anvil::Views::Test.new([@model]).invoke_all
        end
      end
    end
  end
end
