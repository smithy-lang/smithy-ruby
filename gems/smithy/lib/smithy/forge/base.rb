# frozen_string_literal: true

module Smithy
  module Forge
    class Base
      include Thor::Base
      include Thor::Actions

      def initialize(plan)
        @plan = plan
        # Necessary for Thor::Base and Thor::Actions
        self.options = {}
        self.destination_root = plan.options[:destination_root]
      end

      # @return [String, Enumerable<String, String>]
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
          files = gem_files
          files.each do |file, content|
            create_file file, content
          end
          files
        end
      end
    end
  end
end
