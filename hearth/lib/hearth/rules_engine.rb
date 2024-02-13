# frozen_string_literal: true

require 'cgi'
require 'ipaddr'
require 'uri'

require_relative 'structure'

module Hearth
  # Functions in the Smithy rules engine are named routines that
  # operate on a finite set of specified inputs, returning an output.
  # The rules engine has a set of included functions that can be
  # invoked without additional dependencies, called the standard library.
  # @api private
  module RulesEngine
    class AuthScheme
      def initialize(name: , properties: {})
        @name = name
        @properties = properties
      end

      attr_reader :name
      attr_reader :properties
    end

    class Endpoint
      def initialize(uri:, auth_schemes: [], headers: {})
        @uri = uri
        @auth_schemes = auth_schemes
        @headers = headers
      end

      attr_reader :uri
      attr_reader :auth_schemes
      attr_reader :headers
    end

    # Evaluates two boolean values for equality, returning true if they match.
    def self.boolean_equals?(value1, value2)
      value1 == value2
    end

    # Extracts a value at the given path from an object or array.
    # getAttr(value: Object | Array, path: string) Document
    def self.get_attr(value, path)
      parts = path.split('.')

      val = get_attr_index(parts, value)

      if parts.size == 1
        val
      else
        get_attr(val, parts.slice(1..-1).join('.'))
      end
    end

    # Evaluates whether a value, such as an endpoint parameter, is not null.
    # isSet(value: Option<T>) bool
    def self.set?(value)
      !value.nil?
    end

    # Evaluates whether the input string is a compliant RFC 1123 host segment.
    # When allowSubDomains is true, evaluates whether the input string is
    # composed of values that are each compliant RFC 1123 host segments
    # joined by dot (.) characters.
    def self.valid_host_label?(value, allow_sub_domains: false)
      return false if value.empty?

      if allow_sub_domains
        labels = value.split('.', -1)
        return labels.all? { |l| valid_host_label?(l) }
      end

      !!(value =~ /\A(?!-)[a-zA-Z0-9-]{1,63}(?<!-)\z/)
    end

    # Performs logical negation on the provided boolean value,
    # returning the negated value.
    def self.not(value)
      !value
    end

    # Computes a URL structure given an input string.
    def self.parse_url(value)
      URL.new(value).as_json
    rescue ArgumentError, URI::InvalidURIError
      nil
    end

    # Evaluates two string values for equality, returning true if they match.
    def self.string_equals?(value1, value2)
      value1 == value2
    end

    # Computes a portion of a given string based on
    # the provided start and end indices.
    def self.substring(input, start, stop, reverse)
      return nil if start >= stop || input.size < stop

      return nil if input.chars.any? { |c| c.ord > 127 }

      return input[start...stop] unless reverse

      r_start = input.size - stop
      r_stop = input.size - start
      input[r_start...r_stop]
    end

    # Performs RFC 3986#section-2.1 defined percent-encoding on the input value.
    def self.uri_encode(value)
      CGI.escape(value.encode('UTF-8')).gsub('+', '%20').gsub('%7E', '~')
    end

    # Regex that extracts anything in square brackets
    BRACKET_REGEX = /\[(.*?)\]/

    def self.get_attr_index(parts, value)
      if (index = parts.first[BRACKET_REGEX, 1])
        # remove brackets and index from part before indexing
        part_index = parts.first.gsub(BRACKET_REGEX, '')
        if part_index.empty?
          value[index.to_i]
        else
          value[part_index][index.to_i]
        end
      else
        value[parts.first]
      end
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
