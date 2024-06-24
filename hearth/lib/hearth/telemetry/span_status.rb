# frozen_string_literal: true

module Hearth
  module Telemetry
    # TODO
    class SpanStatus
      class << self
        private :new

        def unset(description = '')
          new(UNSET, description: description)
        end

        def ok(description = '')
          new(OK, description: description)
        end

        def error(description = '')
          new(ERROR, description: description)
        end
      end

      def initialize(code, description: '')
        @code = code
        @description = description
      end

      attr_reader :code, :description

      OK = 0
      UNSET = 1
      ERROR = 2
    end
  end
end
