# frozen_string_literal: true

module Smithy
  module Tools
    # @api private
    module Underscore
      class << self
        def acronyms(hash)
          @acronyms.update(hash)
          @acronym_regex = @acronyms.empty? ? /(?=a)b/ : /#{@acronyms.keys.join('|')}/
        end

        # @param [String] string
        # @return [String] Returns the underscored version of the given string.
        def underscore(string)
          new_string = string.dup
          new_string.gsub!(@acronym_regex) { |word| "_#{@acronyms[word]}" }
          new_string.gsub!(/([A-Z0-9]+)([A-Z][a-z])/, '\1_\2')
          new_string = new_string.scan(/[a-z0-9]+|\d+|[A-Z0-9]+[a-z]*/).join('_')
          new_string.downcase!
          new_string
        end

        # @param [String<JMESPath>]
        # @return [String]
        def underscore_jmespath(expression)
          expression.
            gsub(' or ', '||').
            gsub(/(?<![`'])\b\w+\b(?![`'])/) { |str| underscore(str) }
        end
      end

      @acronyms = {}
      acronyms({})
    end
  end
end
