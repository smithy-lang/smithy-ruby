# frozen_string_literal: true

require 'cgi'
require_relative 'http/api_error'
require_relative 'http/client'
require_relative 'http/error_inspector'
require_relative 'http/error_parser'
require_relative 'http/field'
require_relative 'http/fields'
require_relative 'http/header_list_parser'
require_relative 'http/middleware'
require_relative 'http/networking_error'
require_relative 'http/request'
require_relative 'http/response'

module Hearth
  # HTTP namespace for HTTP specific functionality. Also includes utility
  # methods for URI escaping.
  module HTTP
    class << self
      # URI escapes the given value.
      #
      #   Hearth.uri_escape("a b/c")
      #   #=> "a%20b%2Fc"
      #
      # @param [String] value
      # @return [String] URI encoded value except for '+' and '~'.
      # @api private
      def uri_escape(value)
        CGI.escape(value.encode('UTF-8')).gsub('+', '%20').gsub('%7E', '~')
      end

      # URI escapes the given path.
      #
      #   Hearth.uri_escape_path("a b/c")
      #   #=> "a%20b/c"
      #
      # @param [String] path
      # @return [String] URI encoded path except for '+' and '~'.
      # @api private
      def uri_escape_path(path)
        path.gsub(%r{[^/]+}) { |part| uri_escape(part) }
      end
    end
  end
end
