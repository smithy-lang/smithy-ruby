# frozen_string_literal: true

require 'thor'

module Smithy
  module Anvil
    module Views
      class Test < Thor::Group
        include Thor::Actions
        argument :model

        def self.source_root
          File.dirname(__FILE__)
        end

        def create_test_file
          template('../templates/test.erb', 'test.rb')
        end
      end
    end
  end
end
