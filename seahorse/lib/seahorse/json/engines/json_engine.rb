# frozen_string_literal: true

require 'json'

module Seahorse
  module JSON
    # @api private
    module Engines
      # @api private
      class JsonEngine

        def load(json)
          ::JSON.load(json)
        rescue ::JSON::ParserError => e
          raise ParseError, e
        end

        def dump(value)
          ::JSON.dump(value)
        end

      end
    end
  end
end
