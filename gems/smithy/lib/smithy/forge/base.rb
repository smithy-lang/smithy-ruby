# frozen_string_literal: true

require 'thor'

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

      # @return [Enumerable<String, String>] The file paths and their contents to generate.
      def forge
        files = gem_files
        files.each do |file, content|
          create_file file, content
        end
        files
      end
    end
  end
end
