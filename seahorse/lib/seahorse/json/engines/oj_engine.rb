# frozen_string_literal: true

require 'oj'

module Seahorse
  module JSON
    # @api private
    module Engines
      # @api private
      class OjEngine

        DEFAULT_LOAD_OPTS = { mode: :compat, symbol_keys: false, empty_string: false }.freeze

        DEFAULT_DUMP_OPTS = { mode: :compat }.freeze

        def initialize(load_opts: {}, dump_opts: {})
          @load_opts = DEFAULT_LOAD_OPTS.merge(load_opts)
          @dump_opts = DEFAULT_DUMP_OPTS.merge(dump_opts)
        end

        def load(json)
          ::Oj.load(json, @load_opts)
        rescue ::Oj::ParseError, EncodingError, JSON::ParserError => e
          raise ParseError, e
        end

        def dump(value)
          ::Oj.dump(value, @dump_opts)
        end
      end
    end
  end
end
