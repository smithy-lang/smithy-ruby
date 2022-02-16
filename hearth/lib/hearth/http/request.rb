# frozen_string_literal: true

require 'stringio'
require 'uri'

module Hearth
  module HTTP
    # Represents an HTTP request.
    # @api private
    class Request
      # @param [String] http_method
      # @param [String] url
      # @param [Headers] headers
      # @param [IO] body
      def initialize(http_method: nil, url: nil, headers: Headers.new,
                     body: StringIO.new)
        @http_method = http_method
        @url = url
        @headers = headers
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
      #     http_req.url = "https://example.com"
      #     http_req.append_path('/')
      #     http_req.url
      #     #=> "https://example.com/"
      #
      # Paths will be joined by a single '/':
      #
      #     http_req.url = "https://example.com/path-prefix/"
      #     http_req.append_path('/path-suffix')
      #     http_req.url
      #     #=> "https://example.com/path-prefix/path-suffix"
      #
      # Resultant URL preserves the querystring:
      #
      #     http_req.url = "https://example.com/path-prefix?querystring
      #     http_req.append_path('/path-suffix')
      #     http_req.url
      #     #=> "https://example.com/path-prefix/path-suffix?querystring"
      #
      # The provided path should be URI escaped before being passed.
      #
      #     http_req.url = "https://example.com
      #     http_req.append_path(
      #       Hearth::HTTP.uri_escape_path('/part 1/part 2')
      #     )
      #     http_req.url
      #     #=> "https://example.com/part%201/part%202"
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
      #     http_req.url = "https://example.com"
      #     http_req.append_query_param('query')
      #     http_req.append_query_param('key 1', 'value 1')
      #
      #     http_req.url
      #     #=> "https://example.com?query&key%201=value%201
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
                                    "(given #{args.size}, expected 1 or 2)"
          end
        uri = URI.parse(@url)
        uri.query = uri.query ? "#{uri.query}&#{param}" : param
        @url = uri.to_s
      end

      # Append a host prefix to the HTTP request URL.
      #
      #     http_req.url = "https://example.com"
      #     http_req.prefix_host('data.')
      #
      #     http_req.url
      #     #=> "https://data.foo.com
      #
      # @param [String] prefix A dot (.) terminated prefix for the host.
      #
      def prefix_host(prefix)
        uri = URI.parse(@url)
        uri.host = prefix + uri.host
        @url = uri.to_s
      end

      private

      def escape(value)
        Hearth::HTTP.uri_escape(value.to_s)
      end
    end
  end
end
