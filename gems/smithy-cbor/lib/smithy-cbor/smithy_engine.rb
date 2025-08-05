# frozen_string_literal: true

require_relative 'decoder'
require_relative 'encoder'

module Smithy
  module Cbor
    # @api private
    module SmithyEngine
      class << self
        def encode(data)
          e = Encoder.new
          e.add(data)
          e.bytes
        end

        def decode(bytes)
          d = Decoder.new(bytes.force_encoding(Encoding::BINARY))
          d.decode
        end
      end
    end
  end
end
