# frozen_string_literal: true

module Hearth
  module EventStream
    module Binary
      # The order of this is specific to the protocol
      # @api private
      TYPES = %w[
        bool_true
        bool_false
        byte
        short
        integer
        long
        bytes
        string
        timestamp
        uuid
      ].freeze

      # Message Header Value Types
      # @api private
      module Types
        # pack/unpack pattern, byte size, type idx
        PATTERN = {
          'bool_true' => [true, 0, 0],
          'bool_false' => [false, 0, 1],
          'byte' => ['c', 1, 2],
          'short' => ['s>', 2, 3],
          'integer' => ['l>', 4, 4],
          'long' => ['q>', 8, 5],
          'bytes' => [nil, nil, 6],
          'string' => [nil, nil, 7],
          'timestamp' => ['q>', 8, 8],
          'uuid' => [nil, 16, 9]
        }.freeze
      end
    end
  end
end
