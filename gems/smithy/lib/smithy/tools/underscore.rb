# frozen_string_literal: true

module Smithy
  module Tools
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
          new_string.gsub!(/([A-Z0-9]+)([A-Z][a-z])/, '\1_\2'.freeze)
          new_string = new_string.scan(/[a-z0-9]+|\d+|[A-Z0-9]+[a-z]*/).join('_'.freeze)
          new_string.downcase!
          new_string
        end
      end

      @acronyms = {}
      acronyms({})
    end
  end
end
