# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Plugins
    # Test plugin used for testing plugins and middleware -
    # modifies config to add a read_before_execution interceptor
    # and overrides the test_config
    class TestPlugin
      TEST_CLASS_INTERCEPTOR = Hearth::Interceptor.new(
        read_before_execution: proc { |_context| }
      )

      def initialize(override_value: 'client_override')
        @override_value = override_value
      end

      def call(config)
        config.test_config = @override_value
        config.interceptors << TEST_CLASS_INTERCEPTOR
      end
    end
  end

end
