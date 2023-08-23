# frozen_string_literal: true

module Hearth
  module HTTP
    # Represents an HTTP request.
    class Request < Hearth::Request
      # @param [String] http_method
      # @param [Fields] fields
      # @param (see Hearth::Request#initialize)
      def initialize(http_method: nil, fields: Fields.new, **kwargs)
        super(**kwargs)
        @http_method = http_method
        @fields = fields
        @headers = Fields::Proxy.new(@fields, :header)
        @trailers = Fields::Proxy.new(@fields, :trailer)
      end

      # @return [String]
      attr_accessor :http_method

      # @return [Fields]
      attr_reader :fields

      # @return [Fields::Proxy]
      attr_reader :headers

      # @return [Fields::Proxy]
      attr_reader :trailers

      # Append a path to the HTTP request URI.
      #
      #     http_req.uri = "https://example.com"
      #     http_req.append_path('/')
      #     http_req.uri.to_s
      #     #=> "https://example.com/"
      #
      # Paths will be joined by a single '/':
      #
      #     http_req.uri = "https://example.com/path-prefix/"
      #     http_req.append_path('/path-suffix')
      #     http_req.uri.to_s
      #     #=> "https://example.com/path-prefix/path-suffix"
      #
      # Resultant URI preserves the querystring:
      #
      #     http_req.uri = "https://example.com/path-prefix?querystring
      #     http_req.append_path('/path-suffix')
      #     http_req.uri.to_s
      #     #=> "https://example.com/path-prefix/path-suffix?querystring"
      #
      # The provided path should be URI escaped before being passed.
      #
      #     http_req.uri = "https://example.com
      #     http_req.append_path(
      #       Hearth::HTTP.uri_escape_path('/part 1/part 2')
      #     )
      #     http_req.uri.to_s
      #     #=> "https://example.com/part%201/part%202"
      #
      # @param [String] path A URI escaped path.
      def append_path(path)
        base_path = uri.path.sub(%r{/$}, '') # remove trailing slash
        path = path.sub(%r{^/}, '')          # remove prefix slash
        uri.path = "#{base_path}/#{path}"    # join on single slash
      end

      # Append querystring parameter to the HTTP request URI.
      #
      #     http_req.uri = "https://example.com"
      #     http_req.append_query_param('query')
      #     http_req.append_query_param('key 1', 'value 1')
      #
      #     http_req.uri.to_s
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
          when 1 then Hearth::Query::Param.new(args[0])
          when 2 then Hearth::Query::Param.new(args[0], args[1])
          else raise ArgumentError, 'wrong number of arguments ' \
                                    "(given #{args.size}, expected 1 or 2)"
          end
        uri.query = uri.query ? "#{uri.query}&#{param}" : param.to_s
      end

      # Append querystring parameter list to the HTTP request URI.
      #
      #     http_req.uri = "https://example.com"
      #     query_params = Hearth::Query::ParamList.new
      #     query_params['key 1'] = nil
      #     query_params['key 2'] = 'value 2'
      #     http_req.append_query_param_list(query_params)
      #
      #     http_req.uri.to_s
      #     #=> "https://example.com?key%201=&key%202=value%202"
      #
      # @param [ParamList] param_list
      #   An instance of Hearth::Query::ParamList containing the list of
      #   querystring parameters to add. The names and values are URI escaped.
      #
      def append_query_param_list(param_list)
        return if param_list.empty?

        uri.query = uri.query ? "#{uri.query}&#{param_list}" : param_list.to_s
      end

      # Append a host prefix to the HTTP request URI.
      #
      #     http_req.uri = "https://example.com"
      #     http_req.prefix_host('data.')
      #
      #     http_req.uri.to_s
      #     #=> "https://data.foo.com
      #
      # @param [String] prefix A dot (.) terminated prefix for the host.
      #
      def prefix_host(prefix)
        uri.host = prefix + uri.host
      end

      # @api private
      def initialize_copy(other)
        @http_method = other.http_method
        @fields = other.fields.dup
        @headers = Fields::Proxy.new(@fields, :header)
        @trailers = Fields::Proxy.new(@fields, :trailer)
        super
      end
    end
  end
end
