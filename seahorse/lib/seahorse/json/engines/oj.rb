# frozen_string_literal: true

module Seahorse
  module JSON
    module Engines
      class Oj
        def self.available?
          require 'oj'
          true
        rescue LoadError
          false
        end

        def self.load(json)
          ::Oj.load(json, mode: :compat, symbol_keys: false, empty_string: false)
        rescue ::Oj::ParseError, EncodingError, JSON::ParserError => e
          raise ParseError, e
        end

        def self.dump(value)
          ::Oj.dump(value, mode: :compat)
        end
      end
    end
  end
end
