# frozen_string_literal: true

module Smithy
  module Util
    # @api private
    module Underscore
      class << self
        # @param [String<JMESPath>]
        # @return [String]
        def underscore_jmespath(expression)
          expression
            .gsub(' or ', '||')
            .gsub(/(?<![`'])\b\w+\b(?![`'])/, &:underscore)
        end

        def underscore(string)
          string.gsub(/::/, '/')
                .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
                .gsub(/([a-z\d])([A-Z])/,'\1_\2')
                .tr("-", "_")
                .downcase
        end
      end
    end
  end
end
