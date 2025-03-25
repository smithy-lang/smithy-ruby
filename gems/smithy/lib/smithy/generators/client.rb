# frozen_string_literal: true

module Smithy
  module Generators
    # Generates a gem for the client.
    class Client < Base
      # @param [Plan] plan The plan to generate.
      def initialize(plan)
        @plan = plan
        @gem_name = plan.gem_name
        super
      end

      def generate
        gem_files.each_with_object([]) do |(file, content), files|
          next if file == "lib/#{@gem_name}/customizations.rb" && should_skip_customizations?

          create_file file, content
          files << file
        end
      end

      def source
        source_files.map { |_file, content| content }.join("\n")
      end

      private

      # rubocop:disable Metrics/AbcSize
      def gem_files
        Enumerator.new do |e|
          e.yield "#{@gem_name}.gemspec", Views::Client::Gemspec.new(@plan).render
          e.yield '.rubocop.yml', Views::Client::RubocopYml.new(@plan).render

          source_files.each { |file, content| e.yield file, content }
          e.yield "lib/#{@gem_name}/customizations.rb", Views::Client::Customizations.new.render

          spec_files.each { |file, content| e.yield file, content }

          rbs_files.each { |file, content| e.yield file, content }
        end
      end

      def source_files
        Enumerator.new do |e|
          e.yield "lib/#{@gem_name}.rb", Views::Client::Module.new(@plan).render
          e.yield "lib/#{@gem_name}/auth_parameters.rb", Views::Client::AuthParameters.new(@plan).render
          e.yield "lib/#{@gem_name}/auth_resolver.rb", Views::Client::AuthResolver.new(@plan).render
          e.yield "lib/#{@gem_name}/errors.rb", Views::Client::Errors.new(@plan).render
          e.yield "lib/#{@gem_name}/endpoint_parameters.rb", Views::Client::EndpointParameters.new(@plan).render
          e.yield "lib/#{@gem_name}/endpoint_provider.rb", Views::Client::EndpointProvider.new(@plan).render
          code_generated_plugins.each { |path, plugin| e.yield path, plugin.source }
          e.yield "lib/#{@gem_name}/types.rb", Views::Client::Types.new(@plan).render
          e.yield "lib/#{@gem_name}/schema.rb", Views::Client::Schema.new(@plan).render
          e.yield "lib/#{@gem_name}/client.rb", Views::Client::Client.new(@plan, code_generated_plugins).render
        end
      end

      def spec_files
        Enumerator.new do |e|
          e.yield 'spec/spec_helper.rb', Views::Client::SpecHelper.new(@plan).render
          e.yield "spec/#{@gem_name}/endpoint_provider_spec.rb", Views::Client::EndpointProviderSpec.new(@plan).render
          e.yield "spec/#{@gem_name}/protocol_spec.rb", Views::Client::ProtocolSpec.new(@plan).render
        end
      end

      def rbs_files
        Enumerator.new do |e|
          e.yield "sig/#{@gem_name}.rbs", Views::Client::ModuleRbs.new(@plan).render
          e.yield "sig/#{@gem_name}/auth_parameters.rbs", Views::Client::AuthParametersRbs.new(@plan).render
          e.yield "sig/#{@gem_name}/auth_resolver.rbs", Views::Client::AuthResolverRbs.new(@plan).render
          e.yield "sig/#{@gem_name}/client.rbs", Views::Client::ClientRbs.new(@plan, code_generated_plugins).render
          e.yield "sig/#{@gem_name}/errors.rbs", Views::Client::ErrorsRbs.new(@plan).render
          e.yield "sig/#{@gem_name}/endpoint_parameters.rbs", Views::Client::EndpointParametersRbs.new(@plan).render
          e.yield "sig/#{@gem_name}/endpoint_provider.rbs", Views::Client::EndpointProviderRbs.new(@plan).render
          e.yield "sig/#{@gem_name}/schema.rbs", Views::Client::SchemaRbs.new(@plan).render
          e.yield "sig/#{@gem_name}/types.rbs", Views::Client::TypesRbs.new(@plan).render
        end
      end
      # rubocop:enable Metrics/AbcSize

      def code_generated_plugins
        Enumerator.new do |e|
          e.yield "lib/#{@gem_name}/plugins/auth.rb", Views::Client::Plugin.new(
            class_name: "#{@plan.module_name}::Plugins::Auth",
            require_path: 'plugins/auth',
            require_relative: true,
            source: Views::Client::AuthPlugin.new(@plan).render
          )
          e.yield "lib/#{@gem_name}/plugins/endpoint.rb", Views::Client::Plugin.new(
            class_name: "#{@plan.module_name}::Plugins::Endpoint",
            require_path: 'plugins/endpoint',
            require_relative: true,
            source: Views::Client::EndpointPlugin.new(@plan).render
          )
        end
      end

      def should_skip_customizations?
        Dir["#{destination_root}/**/*"].any? { |f| f.include?('/customizations.rb') }
      end
    end
  end
end
