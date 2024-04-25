# frozen_string_literal: true

module Hearth
  module Http
    # @api private
    module HeaderListBuilder
      class << self
        # builds a string from a list of possibly quoted values
        # ensures that quoted values are escaped
        # could name the below to be join_string_list?
        def build_string_list(value)
          unless value.respond_to?(:compact)
            raise ArgumentError,
                  "Expected #{value} to be an Array, got #{value.class} instead"
          end

          value.compact
               .map { |s| escape_value(s) }
               .join(', ')
        end

        private

        # Escapes header field value
        # @return [String]
        def escape_value(str)
          s = str
          s.include?('"') || s.include?(',') ? "\"#{s.gsub('"', '\"')}\"" : s
        end
      end
    end
  end
end
