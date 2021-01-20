# frozen_string_literal: true

require 'cgi'
require 'set'
require 'stringio'
require 'uri'

module Seahorse
  module HTTP
    class RequestBuilder

      HTTP_METHODS = Set.new(%i[DELETE GET HEAD POST PUT PATCH])

      def initialize(params:)
        @params = params
        @endpoint = nil
        @http_method = :POST
        @path = '/'
        @query = []
        @headers = {}
        @body = StringIO.new('')
      end

      # @param [NawsHttp::Request]
      # @return [NawsHttp::Request]
      def apply(http_req)
        http_req.http_method = @http_method
        http_req.url = build_url
        @headers.each_pair do |key, value|
          http_req.headers[key] = value
        end
        http_req.body = @body
        http_req
      end

      def endpoint(endpoint)
        @endpoint = endpoint
      end

      # @param [Symbol] http_method
      def http_method(http_method)
        if HTTP_METHODS.include?(http_method)
          @http_method = http_method
        else
          msg = 'unsupported HTTP method, expected one of: '
          msg += HTTP_METHODS.map(&:inspect).sort.join(', ')
          raise ArgumentError, msg
        end
      end

      # @param [String] path
      def path(pattern, params = {})
        params = params.inject({}) do |hash, (param, escape_method)|
          value = @params[param].non_empty!.to_str
          hash[param] = send(escape_method, value)
          hash
        end
        @path = format(pattern, params)
      end

      def query_string(name, value = nil)
        if value.nil?
          @query << escape(name)
        else
          @query << "#{escape(name)}=#{escape(value)}"
        end
      end

      def query_param(name:, param:, format: :to_str, required: false)
        value = @params[param]
        return if value.nil? && !required
        @query << "#{escape(name)}=#{escape(value.send(format))}"
      end

      # @params [String] name
      # @params [String] value
      def header_string(name:, value:)
        @req.headers[name] = value.to_str
      end

      def header_param(name:, param:, format: :to_str, required: false)
        value = @params[param]
        return if value.nil? && !required
        @req.headers[name] = value.send(format)
      end

      def header_map(param:, prefix: '', required: false)
        value = @params[param]
        return if value.nil? && !required
        value.each_pair do |key, value|
          @req.headers["#{prefix}#{key}"] = value.to_str
        end
        req.headers
      end

      def body_stream(param:, required: false)
        value = @params[param]
        return if value.nil? && !required
        @body = value.io
      end

      def body_builder(builder:, param:, required: false)
        value = @params[param]
        return if value.nil? && !required
        @body = StringIO.new(builder.new.build(value).to_str)
      end

      # @param [Class#build] builder
      # @param [Array<Symbol>] params
      # @param [Boolean] required
      def body_builder_params(builder:, params:)
        params = @params.slice(params)
        return if params.empty?
        @body = StringIO.new(builder.new.build(params).to_str)
      end

      private

      # Escape a value to make it suitable for inclusion in the uri.
      def escape(value)
        CGI.escape(value.encode('UTF-8')).gsub('+', '%20').gsub('%7E', '~')
      end

      # Preserves forward-slashes, uri escaping each path part.
      def escape_path(path)
        path.gsub(%r{[^/]+}) { |part| escape(part) }
      end

      def build_url
        url = URI.parse(@endpoint)
        append_path(url)
        append_query_params(url)
        url.to_s
      end

      def append_path(url)
        base_path = url.path.sub(%r{/$}, '') # remove trailing slash
        url.path = "#{base_path}#{@path}"
      end

      def append_query_params(url)
        params = url.query ? url.query.split('&') : []
        params.concat(@query)
        url.query = params.empty? ? nil : params.join('&')
      end
    end
  end
end
