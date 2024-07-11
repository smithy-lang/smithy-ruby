# frozen_string_literal: true

module Hearth
  module Telemetry
    # Base for all ContextManager classes
    class ContextManager
      def current; end
      def current_span; end
      def attach(context); end
      def detach(token); end
    end
  end
end
