# frozen_string_literal: true

module Smithy
  module Forge
    class Base < Thor
      include Thor::Actions

      def initialize
        super([], { force: true }, { destination_root: @plan.smithy_plugin_dir })
      end

      no_commands do
        def source
          raise 'Not yet implemented'
        end

        def forge
          source.each do |file, content|
            create_file file, content
          end
        end
      end
    end
  end
end
