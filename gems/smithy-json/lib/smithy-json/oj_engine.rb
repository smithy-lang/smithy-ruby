# frozen_string_literal: true

require 'oj'

module Smithy
  module Json
    # @api private
    module OjEngine
      class << self
        def load(json)
          Oj.load(json, mode: :compat, symbol_keys: false)
        rescue Oj::ParseError, EncodingError => e
          raise ParseError, e.message
        end

        def dump(value)
          # Avoid Oj's JSON mode calling Time#to_json with keywords rejected by
          # recent json gem versions while preserving the existing time format.
          Oj.dump(value, { mode: :custom, time_format: :ruby })
        end
      end
    end
  end
end
