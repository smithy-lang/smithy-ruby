# frozen_string_literal: true

require_relative 'engines/oj'
require_relative 'engines/json'

module Seahorse
  # @api private
  module JSON
    class ParseError < StandardError
      MSG = 'Encountered an error while parsing the response: %<message>s'

      def initialize(original_error)
        @original_error = original_error
        super(format(MSG, message: original_error.message))
      end

      # @return [StandardError]
      attr_reader :original_error
    end

    ENGINES = [
      Engines::Oj,
      Engines::JSON
    ].freeze

    class << self
      ENGINE = ENGINES.find(&:available?)

      def load(json)
        ENGINE.load(json)
      end

      def load_file(path)
        load(File.open(path, 'r', encoding: 'UTF-8', &:read))
      end

      def dump(value)
        ENGINE.dump(value)
      end
    end
  end
end
