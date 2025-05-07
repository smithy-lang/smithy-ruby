# frozen_string_literal: true

require 'oj'

module Smithy
  module JSON
    # @api private
    module OjEngine
      class << self
        def load(json)
          Oj.load(json, mode: :compat, symbol_keys: false)
        rescue Oj::ParseError, EncodingError => e
          raise ParseError, e
        end

        def dump(value)
          Oj.dump(value, mode: :compat)
        end
      end
    end
  end
end
