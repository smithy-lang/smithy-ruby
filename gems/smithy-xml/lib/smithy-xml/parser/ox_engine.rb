# frozen_string_literal: true

require 'ox'
require 'stringio'

module Smithy
  module Xml
    class Parser
      # @api private
      class OxEngine
        def initialize(stack)
          @stack = stack
        end

        def parse(xml)
          Ox.sax_parse(@stack, StringIO.new(xml), convert_special: true, skip: :skip_return)
        end
      end
    end
  end
end
