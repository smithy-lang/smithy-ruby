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

      # rubocop:disable Metrics/AbcSize
      def source_files
        Enumerator.new do |e|
          e.yield "#{@gem_name}.gemspec", Anvil::Client::Views::Gemspec.new(@plan).hammer
          e.yield "lib/#{@gem_name}.rb", Anvil::Client::Views::Module.new(@plan).hammer
          e.yield "lib/#{@gem_name}/types.rb", Anvil::Client::Views::Types.new(@plan).hammer
          e.yield "lib/#{@gem_name}/errors.rb", Anvil::Client::Views::Errors.new(@plan).hammer
          e.yield "lib/#{@gem_name}/client.rb", Anvil::Client::Views::ClientClass.new(@plan).hammer
          e.yield "lib/#{@gem_name}/endpoint_parameters.rb", Anvil::Client::Views::EndpointParameters.new(@plan).hammer
          e.yield "lib/#{@gem_name}/endpoint_provider.rb", Anvil::Client::Views::EndpointProvider.new(@plan).hammer
          e.yield "lib/#{@gem_name}/plugins/endpoint.rb", Anvil::Client::Views::Plugins::Endpoint.new(@plan).hammer
        end
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
