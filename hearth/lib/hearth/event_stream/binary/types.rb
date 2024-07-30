# frozen_string_literal: true

module Hearth
  module EventStream
    # @api private
    module Binary
      # Message Header Value Types
      # @api private
      module Types
        # This hash is ordered.  The order must match the type index
        # pack/unpack pattern, byte size, type_index
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

        def self.encode_info(type)
          pattern = PATTERN[type]
          raise EventStreamParserError unless pattern
          pattern
        end

        def self.type_from_index(type_index)
          PATTERN.keys[type_index]
        end
      end
    end
  end
end
