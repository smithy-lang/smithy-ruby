# frozen_string_literal: true

require 'cgi'
require 'ipaddr'
require 'uri'

module Hearth
  # Functions in the Smithy rules engine are named routines that
  # operate on a finite set of specified inputs, returning an output.
  # The rules engine has a set of included functions that can be
  # invoked without additional dependencies, called the standard library.
  module EndpointRules
    # An Authentication Scheme supported by an Endpoint
    # @!attribute scheme_id
    #   The identifier of the authentication scheme.
    #   @return [String]
    # @!attribute properties
    #   Additional properties of the authentication scheme.
    #   @return [Hash]
    AuthScheme = Struct.new(
      :scheme_id,
      :properties,
      keyword_init: true
    ) do
      # @option args [String] :scheme_id
      # @option args [Hash] :properties ({})
      def initialize(*args)
        super
        self.properties ||= {}
      end
    end

    # An Endpoint resolved by an EndpointProvider
    # @!attribute uri
    #   The URI of the endpoint.
    #   @return [String]
    # @!attribute auth_schemes
    #   The authentication schemes supported by the endpoint.
    #   @return [Array<AuthScheme>]
    # @!attribute headers
    #   The headers to include in requests to the endpoint.
    #   @return [Hash]
    Endpoint = Struct.new(
      :uri,
      :auth_schemes,
      :headers,
      keyword_init: true
    ) do
      # @option args [String] :uri
      # @option args [Array<AuthScheme>] :auth_schemes ([])
      # @option args [Hash] :headers ({})
      def initialize(*args)
        super
        self.auth_schemes ||= []
        self.headers ||= {}
      end
    end

    # Evaluates whether the input string is a compliant RFC 1123 host segment.
    # When allowSubDomains is true, evaluates whether the input string is
    # composed of values that are each compliant RFC 1123 host segments
    # joined by dot (.) characters.
    # @api private
    # rubocop:disable Style/OptionalBooleanParameter
    def self.valid_host_label?(value, allow_sub_domains = false)
      return false if value.empty?

      if allow_sub_domains
        labels = value.split('.', -1)
        return labels.all? { |l| valid_host_label?(l, false) }
      end

      !!(value =~ /\A(?!-)[a-zA-Z0-9-]{1,63}(?<!-)\z/)
    end
    # rubocop:enable Style/OptionalBooleanParameter

    # Computes a URL structure given an input string.
    # @api private
    def self.parse_url(value)
      URL.new(value).as_json
    rescue ArgumentError, URI::InvalidURIError
      nil
    end

    # Computes a portion of a given string based on
    # the provided start and end indices.
    # @api private
    def self.substring(input, start, stop, reverse)
      return nil if start >= stop || input.size < stop

      return nil if input.chars.any? { |c| c.ord > 127 }

      return input[start...stop] unless reverse

      r_start = input.size - stop
      r_stop = input.size - start
      input[r_start...r_stop]
    end

    # Performs RFC 3986#section-2.1 defined percent-encoding on the input value.
    # @api private
    def self.uri_encode(value)
      CGI.escape(value.encode('UTF-8')).gsub('+', '%20').gsub('%7E', '~')
    end

    # @api private
    class URL
      def initialize(url)
        uri = URI(url)
        @scheme = uri.scheme
        # only support http and https schemes
        raise ArgumentError unless %w[https http].include?(@scheme)

        # do not support query
        raise ArgumentError if uri.query

        @authority = _authority(url, uri)
        @path = uri.path
        @normalized_path = uri.path + (uri.path[-1] == '/' ? '' : '/')
        @is_ip = _is_ip(uri.host)
      end

      attr_reader :scheme, :authority, :path, :normalized_path, :is_ip

      def as_json(_options = {})
        {
          'scheme' => scheme,
          'authority' => authority,
          'path' => path,
          'normalizedPath' => normalized_path,
          'isIp' => is_ip
        }
      end

      private

      def _authority(url, uri)
        # don't include port if it's default and not parsed originally
        if uri.default_port == uri.port && !url.include?(":#{uri.port}")
          uri.host
        else
          "#{uri.host}:#{uri.port}"
        end
      end

      def _is_ip(authority)
        IPAddr.new(authority)
        true
      rescue IPAddr::InvalidAddressError
        false
      end
    end
  end
end
