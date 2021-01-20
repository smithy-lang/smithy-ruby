# frozen_string_literal: true

require 'stringio'
require 'uri'

module Seahorse
  module HTTP
    # Represents an HTTP request.
    class Request

      # @param [String] http_method
      # @param [String] url
      # @param [Headers] headers
      # @param [IO] body
      def initialize(http_method: nil, url: nil, headers: {}, body: StringIO.new(''))
        @http_method = http_method
        @url = url
        @headers = Headers.new(headers: headers)
        @body = body
      end

      # @return [String]
      attr_accessor :http_method

      # @return [String]
      attr_accessor :url

      # @return [Headers]
      attr_accessor :headers

      # @return [IO]
      attr_accessor :body

      # Append a path to the HTTP request URL.
      #
      #     http_req.url = "https://foo.com"
      #     http_req.append_path('/')
      #     http_req.url
      #     #=> "https://foo.com/"
      #
      # Paths will be joined by a single '/':
      #
      #     http_req.url = "https://foo.com/path-prefix/"
      #     http_req.append_path('/path-suffix')
      #     http_req.url
      #     #=> "https://foo.com/path-prefix/path-suffix"
      #
      # Resultant URL preserves the querystring:
      #
      #     http_req.url = "https://foo.com/path-prefix?querystring
      #     http_req.append_path('/path-suffix')
      #     http_req.url
      #     #=> "https://foo.com/path-prefix/path-suffix?querystring"
      #
      # The provided path should be URI escaped before being passed.
      #
      #     http_req.url = "https://foo.com
      #     http_req.append_path(NawsHttp.uri_escape_path('/part 1/part 2'))
      #     http_req.url
      #     #=> "https://foo.com/part%201/part%202"
      #
      # @param [String] path A URI escaped path.
      def append_path(path)
        uri = URI.parse(@url)
        base_path = uri.path.sub(%r{/$}, '') # remove trailing slash
        path = path.sub(%r{^/}, '')          # remove prefix slash
        uri.path = "#{base_path}/#{path}"    # join on single slash
        @url = uri.to_s
      end

      # Append querystring parameter to the HTTP request URL.
      #
      #     http_req.url = "https://foo.com"
      #     http_req.append_query_param('query')
      #     http_req.append_query_param('key 1', 'value 1')
      #
      #     http_req.url
      #     #=> "https://foo.com?query&key%201=value%201
      #
      # @overload append_query_param(name)
      #   @param [String] name
      #     The name of the querystring parameter to add. This name
      #     will be URI escaped.
      #
      # @overload append_query_param(name, value)
      #   @param [String] name
      #     The name of the querystring parameter to add. This name
      #     will be URI escaped.
      #   @param [String] value
      #     The value of the querystring parameter to add. This value
      #     will be URI escaped.
      #
      def append_query_param(*args)
        param =
          case args.size
          when 1 then escape(args[0])
          when 2 then "#{escape(args[0])}=#{escape(args[1])}"
          else raise ArgumentError, 'wrong number of arguments ' \
            "(given #{values.size}, expected 1 or 2)"
          end
        uri = URI.parse(@url)
        uri.query = uri.query ? "#{uri.query}&#{param}" : param
        @url = uri.to_s
      end

      private

      def escape(value)
        Seahorse::HTTP.uri_escape(value.to_s)
      end

    end
  end
end
