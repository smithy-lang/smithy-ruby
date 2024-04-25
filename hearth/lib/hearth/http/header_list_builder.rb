# frozen_string_literal: true

module Hearth
  module Http
    # @api private
    module HeaderListBuilder
      class << self

        def build_list(value)
          value.compact.join(', ')
        end

        # builds a string from a list of possibly quoted values
        # ensures that quoted values are escaped
        def build_string_list(value)
          value.compact
               .map { |s| escape_value(s) }
               .join(', ')
        end

        def build_http_date_list(value)
          value.compact
                .map { |s| escape_value(s) }
                .join(', ')
        end

        private

        def escape_value(str)
          s = str
          s.include?('"') || s.include?(',') ? "\"#{s.gsub('"', '\"')}\"" : s
        end
      end
    end
  end
end
