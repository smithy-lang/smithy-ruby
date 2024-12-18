# frozen_string_literal: true

module Smithy
  module Tools
    # @api private
    module Underscore
      class << self
        # @param [String<JMESPath>]
        # @return [String]
        def underscore_jmespath(expression)
          expression
            .gsub(' or ', '||')
            .gsub(/(?<![`'])\b\w+\b(?![`'])/) { |str| underscore(str) }
        end
      end

      @acronyms = {}
      acronyms({})
    end
  end
end
