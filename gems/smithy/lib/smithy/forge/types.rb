# frozen_string_literal: true

module Smithy
  module Forge
    class Types
      def initialize(plan)
        @plan = plan
      end

      def forge
        gem_name = @plan.options[:gem_name]
        Enumerator.new do |e|
          # Option 1 - use ERB with views ourselves. Pros are that it's simple and we
          # control all the logic.
          e.yield "#{gem_name}.gemspec", Smithy::Anvil::Views::Gemspec.new(@plan).hammer
          e.yield "lib/#{gem_name}/types.rb", Smithy::Anvil::Views::Types.new(@plan).hammer
          e.yield "lib/#{gem_name}.rb", Smithy::Anvil::Views::Module.new(@plan).hammer
          # Option 2 - Use thor generator (groups/actions) and pass ONE instance
          # of something, either the model or a view. Forge would probably inherit
          # from Thor::Group and include Thor::Actions instead of this view.
          # The pro is that we will need to use thor generators for server
          # generation anyway, so we can reuse the same code.
          view = Smithy::Anvil::Views::Types.new(@plan)
          Smithy::Anvil::Views::Test.new([view], {force: true}).invoke_all
        end
      end
    end
  end
end
