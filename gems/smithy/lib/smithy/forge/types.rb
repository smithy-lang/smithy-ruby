# frozen_string_literal: true

module Smithy
  module Forge
    class Types < Base
      def initialize(plan)
        @plan = plan
        super()
      end

      no_commands do
        def source
          gem_name = "#{@plan.options[:gem_name]}-types"
          Enumerator.new do |e|
            e.yield "#{gem_name}.gemspec", Smithy::Anvil::Views::Types::Gemspec.new(@plan).hammer
            e.yield "lib/#{gem_name}/types.rb", Smithy::Anvil::Views::Types::Types.new(@plan).hammer
            e.yield "lib/#{gem_name}.rb", Smithy::Anvil::Views::Types::Module.new(@plan).hammer
          end
        end
      end
    end
  end
end
