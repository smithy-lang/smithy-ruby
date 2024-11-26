# frozen_string_literal: true

require 'thor'

module Smithy
  module Anvil
    module Views
      class Test < Thor::Group
        include Thor::Actions
        argument :view

        def self.source_root
          File.dirname(__FILE__)
        end

        def types
          view.types
        end

        def namespace
          view.namespace
        end

        def create_test_file
          dir = "#{view.plan.smithy_plugin_dir}/lib/#{view.plan.options[:gem_name]}"
          template('../templates/test.erb', "#{dir}/test.rb")
        end
      end
    end
  end
end
