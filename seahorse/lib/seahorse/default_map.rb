# frozen_string_literal: true

module Seahorse
  # Utility class used by response parsers. This allows the parsers
  # to return hashes that will not be serialized if they are still
  # empty.
  # @api private
  class DefaultMap < Hash

    def nil?
      empty?
    end

  end
end
