# frozen_string_literal: true

module Smithy
  module Forge
    # Forges a gem for the client.
    class Client < Base
      # @param plan [Smithy::Plan] The plan to forge.
      # @return [void]
      def initialize(plan)
        @plan = plan
        @gem_name = plan.options[:gem_name]
        super
      end

      private

      def source_files
        Enumerator.new do |e|
          e.yield "#{@gem_name}.gemspec", Anvil::Views::Client::Gemspec.new(@plan).hammer
          e.yield "lib/#{@gem_name}.rb", Anvil::Views::Client::Module.new(@plan).hammer
          e.yield "lib/#{@gem_name}/types.rb", Anvil::Views::Client::Types.new(@plan).hammer
          e.yield "lib/#{@gem_name}/client.rb", Anvil::Views::Client::ClientClass.new(@plan).hammer
        end
      end
    end
  end
end
