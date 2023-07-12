module WhiteLabel
  module Plugins
    class TestPlugin

      TEST_CLASS_INTERCEPTOR = Class.new do
        def read_before_execution(_context); end
      end.new

      def initialize(override_value: "client_override")
        @override_value = override_value
      end

      def call(config)
        config.test_config = @override_value
        config.interceptors << TEST_CLASS_INTERCEPTOR
      end
    end
  end

end