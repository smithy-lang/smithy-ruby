# frozen_string_literal: true

module Smithy
  module Generators
    # Generates a gem for the types.
    class Schema < Base
      # @param [Plan] plan The plan to generate.
      def initialize(plan)
        @plan = plan
        @gem_name = plan.gem_name
        super
      end

      def generate
        gem_files.each_with_object([]) do |(file, content), files|
          if customization_file?(file) || version_file?(file)
            say_status :skip, "Skipping #{file} because it already exists", :yellow unless @plan.quiet
            next
          end

          create_file file, content
          files << file
        end
      end

      def source
        source_files.map { |_file, content| content }.join("\n")
      end

      private

      def gem_files
        Enumerator.new do |e|
          e.yield 'VERSION', Views::Client::Version.new(@plan).render
          e.yield "#{@gem_name}.gemspec", Views::Client::Gemspec.new(@plan).render
          e.yield '.rubocop.yml', Views::Client::RubocopYml.new(@plan).render

          source_files.each { |file, content| e.yield file, content }
          e.yield "lib/#{@gem_name}/customizations.rb", Views::Client::Customizations.new.render
          rbs_files.each { |file, content| e.yield file, content }
        end
      end

      def source_files
        Enumerator.new do |e|
          e.yield "lib/#{@gem_name}.rb", Views::Client::Module.new(@plan).render
          e.yield "lib/#{@gem_name}/types.rb", Views::Client::Types.new(@plan).render
          e.yield "lib/#{@gem_name}/schema.rb", Views::Client::Schema.new(@plan).render
        end
      end

      def rbs_files
        Enumerator.new do |e|
          e.yield "sig/#{@gem_name}.rbs", Views::Client::ModuleRbs.new(@plan).render
          e.yield "sig/#{@gem_name}/types.rbs", Views::Client::TypesRbs.new(@plan).render
          e.yield "sig/#{@gem_name}/schema.rbs", Views::Client::SchemaRbs.new(@plan).render
        end
      end

      def customization_file?(path)
        return false unless path == "lib/#{@gem_name}/customizations.rb"

        File.exist?(File.join(destination_root, path))
      end

      def version_file?(path)
        return false unless path == 'VERSION'

        File.exist?(File.join(destination_root, path))
      end
    end
  end
end
