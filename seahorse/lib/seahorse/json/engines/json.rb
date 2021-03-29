# frozen_string_literal: true

module Seahorse
  module JSON
    module Engines
      class JSON
        def self.available?
          require 'json'
          true
        rescue LoadError
          false
        end

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
