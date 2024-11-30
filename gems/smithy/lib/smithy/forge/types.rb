# frozen_string_literal: true

module Smithy
  module Forge
    class Types < Base
      def initialize(plan)
        @plan = plan
        @gem_name = "#{@plan.options[:gem_name]}-types"
        super()
      end

      no_commands do
        def source_files
          Enumerator.new do |e|
            e.yield "lib/#{@gem_name}/types.rb", Smithy::Anvil::Views::Types::Types.new(@plan).hammer
          end
        end

        def gem_files
          Enumerator.new do |e|
            e.yield "#{@gem_name}.gemspec", Smithy::Anvil::Views::Types::Gemspec.new(@plan).hammer
            e.yield "lib/#{@gem_name}.rb", Smithy::Anvil::Views::Types::Module.new(@plan).hammer

            source_files.each do |file, content|
              e.yield file, content
            end
          end
        end
      end
    end
  end
end
