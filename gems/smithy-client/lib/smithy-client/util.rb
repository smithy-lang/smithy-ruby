# frozen_string_literal: true

require 'cgi/escape'
require 'cgi/util' if RUBY_VERSION < '3.5'

module Smithy
  module Client
    # @api private
    module Util
      def self.str_to_bool(str)
        case str.to_s
        when 'true' then true
        when 'false' then false
        end
      end

      # CGI.escape handles UTF-8 encoding for us, then we normalize to the
      # RFC 3986 form expected by Smithy without paying for rewrite passes
      # when the escaped value does not contain the affected bytes.
      def self.escape(value)
        encoded = CGI.escape(value.encode('UTF-8'))
        encoded = encoded.gsub('+', '%20') if encoded.include?('+')
        encoded = encoded.gsub('%7E', '~') if encoded.include?('%7E')
        encoded
      end
    end
  end
end
