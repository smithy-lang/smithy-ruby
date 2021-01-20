# frozen_string_literal: true

require_relative 'http/headers'
require_relative 'http/networking_error'
require_relative 'http/request'
require_relative 'http/request_builder'
require_relative 'http/response'
require_relative 'http/xfer'

module Seahorse
  module HTTP
    class << self
      # URI escapes the given value.
      #
      #   NawsHttp.escape("a b/c")
      #   #=> "a%20b%2Fc"
      #
      # @param [String] value
      # @return [String<URI escaped>]
      def uri_escape(value)
        CGI.escape(value.encode('UTF-8')).gsub('+', '%20').gsub('%7E', '~')
      end

      def uri_escape_path(path)
        path.gsub(%r{[^/]+}) { |part| uri_escape(part) }
      end

    end
  end
end
