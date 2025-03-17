# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class AuthParameter
        def initialize(options = {})
          @name = options[:name]
          @documentation = options[:documentation]
        end

        attr_reader :name

        def docstrings
          @documentation.split("\n")
        end

        def documentation_type
          'Symbol'
        end

        def rbs_type
          'Symbol'
        end
      end
    end
  end
end
