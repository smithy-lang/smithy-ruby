module Weather
  module Plugins
    class TestPlugin
      def initialize(override_value: "client_override")
        @override_value = override_value
      end

      def call(config)
        config.test_config = @override_value
      end
    end
  end

end
