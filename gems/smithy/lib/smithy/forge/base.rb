# frozen_string_literal: true

module Smithy
  module Forge
    class Base < Thor
      include Thor::Actions

      def initialize
        super([], { force: true }, { destination_root: @plan.options[:destination_root] })
      end

      no_commands do
        def forge
          if @plan.options[:source_only]
            # TODO: map dependencies
            code = ["require 'smithy-client'"]
            source_files.each do |file, content|
              next unless file.include? '/'

              code << content
            end
            code.join("\n")
          else
            gem_files.each do |file, content|
              create_file file, content
            end
          end
        end
      end
    end
  end
end
