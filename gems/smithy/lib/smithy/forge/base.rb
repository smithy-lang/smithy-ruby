# frozen_string_literal: true

require 'thor'

module Smithy
  module Forge
    # Base class for generating files.
    class Base
      include Thor::Base
      include Thor::Actions

      # @param plan [Smithy::Plan] The plan to forge.
      def initialize(plan)
        @plan = plan
        # Necessary for Thor::Base and Thor::Actions
        self.options = { force: true }
        self.destination_root = plan.options[:destination_root]
      end

      # @return [Enumerable<String, String>] The file paths and their contents to generate.
      def forge
        files = source_files
        files.each do |file, content|
          create_file file, content
        end
        files
      end
    end
  end
end
