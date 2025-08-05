# frozen_string_literal: true

require 'json'

module Smithy
  module Json
    # @api private
    module JsonEngine
      class << self
        def load(json)
          ::JSON.parse(json)
        rescue ::JSON::ParserError => e
          raise ParseError, e.message
        end

        def dump(value)
          ::JSON.dump(value)
        end
      end
    end
  end
end
