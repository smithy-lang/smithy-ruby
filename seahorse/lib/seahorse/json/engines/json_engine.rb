# frozen_string_literal: true

require 'json'

module Seahorse
  module JSON
    # @api private
    module Engines
      # @api private
      class JsonEngine

        def self.load(json)
          ::JSON.load(json)
        rescue ::JSON::ParserError => e
          raise ParseError, e
        end

        def self.dump(value)
          ::JSON.dump(value)
        end

      end
    end
  end
end
