# frozen_string_literal: true

module Smithy
  module Forge
    class Types
      def initialize(plan)
        @model = plan.model
      end

      def forge
        Enumerator.new do |e|
          # Option 1 - use ERB with views ourselves. Pros are that it's simple and we
          # control all the logic.
          e.yield 'types.rb', Smithy::Anvil::Views::Types.new(@model).hammer
          # Option 2 - Use thor generator (groups/actions) and pass ONE instance
          # of something, either the model or a view. Forge would probably inherit
          # from Thor::Group and include Thor::Actions instead of this view.
          # The pro is that we will need to use thor generators for server
          # generation anyway, so we can reuse the same code.
          types = Smithy::Anvil::Views::Types.new(@model).types
          Smithy::Anvil::Views::Test.new([types]).invoke_all
        end
      end
    end
  end
end
