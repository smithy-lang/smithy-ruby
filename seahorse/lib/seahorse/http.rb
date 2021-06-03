# frozen_string_literal: true

require 'cgi'
require_relative 'http/api_error'
require_relative 'http/client'
require_relative 'http/error_parser'
require_relative 'http/headers'
require_relative 'http/middleware/content_length'
require_relative 'http/networking_error'
require_relative 'http/request'
require_relative 'http/response'

module Seahorse
  # HTTP namespace for HTTP specific functionality. Also includes utility
  # methods for URI escaping.
  module HTTP
    # TODO - do these belong here?
    class << self
      # URI escapes the given value.
      #
      #   Seahorse::_escape("a b/c")
      #   #=> "a%20b%2Fc"
      #
      # @param [String] value
      # @return [String] URI encoded value except for '+' and '~'.
      def uri_escape(value)
        CGI.escape(value.encode('UTF-8')).gsub('+', '%20').gsub('%7E', '~')
      end

      def uri_escape_path(path)
        path.gsub(%r{[^/]+}) { |part| uri_escape(part) }
      end
    end
  end
end
