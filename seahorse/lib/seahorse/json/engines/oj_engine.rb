# frozen_string_literal: true

require 'oj'

module Seahorse
  module JSON
    # @api private
    module Engines
      # @api private
      class OjEngine

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
