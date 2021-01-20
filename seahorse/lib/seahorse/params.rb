# frozen_string_literal: true

require 'base64'
require 'json'
require 'set'
require 'stringio'

module Seahorse
  # Utility classes for working with request parameters. This module
  # provides abstractions for Hash, Array, and some scalar types.
  # Its primary uses are:
  #
  # * Validate structure of parameters against expect types.
  # * Cast parameter values to expected types.
  # * Raise errors with context when validation or cast fails.
  #
  module Params

    # @param [Hash, HashValue, Value] value
    # @param [Set] permit
    # @return [HashValue]
    # @raise [ArgumentError] Raises when the given value can not
    #   be coerced into a {HashValue}.
    def self.hash_value(value, permit: nil, context: 'params')
      hash =
        case value
        when HashValue then value
        when Value then value.hash_value
        else HashValue.new(value, context: context)
        end
      hash.permit!(permit) if permit
      hash
    end

    # @param [Array, ArrayValue, Value] value
    # @return [ArrayValue]
    # @raise [ArgumentError] Raises when the given value can not
    #   be coerced into a {ArrayValue}.
    def self.array_value(value, context: 'params')
      case value
      when ArrayValue then value
      when Value then value.array_value
      else ArrayValue.new(value, context: context)
      end
    end

    class Value

      # @api private
      BYTES = 'expected %<context>s to be a String or to respond to ' \
        '#read, got %<class>s'

      # @api private
      BOOLEANS = Set.new([true, false])

      # @param [Object] value
      # @param [String] context
      def initialize(value, context: 'params')
        @value = value
        @context = context
      end

      # Expects the value to be a hash and then returns the value
      # for the given key.
      # @param [String, Symbol] key
      # @return [Value]
      # @raise ArgumentError when the value is not a hash.
      def [](key)
        hash_value[key]
      end

      # Expects the value to be a hash and then returns a
      # {HashValue}.
      # @return [HashValue]
      # @raise ArgumentError when the value is not a hash.
      def hash_value
        HashValue.new(@value, context: @context)
      end

      # Expects the value to be an array and then returns an
      # {ArrayValue}.
      # @return [ArrayValue]
      # @raise ArgumentError when the value is not an Array.
      def array_value(&block)
        ArrayValue.new(@value, context: @context)
      end

      # Expects the value to be a String and then returns that
      # value.
      # @return [String]
      # @raise [ArgumentError] when the value is not a String.
      def to_str
        unless @value.is_a?(String)
          msg = "expected #{@context} to be a String, got #{@value.class}"
          raise ArgumentError, msg
        end
        @value
      end
      alias to_s to_str

      # @return [String<JSON>]
      def to_json
        JSON.dump(@value)
      end

      # Expects the value to be an Integer and then returns that
      # value.
      # @return [Integer]
      # @raise [ArgumentError] when the value is not a Integer.
      def to_int
        unless @value.is_a?(Integer)
          msg = "expected #{@context} to be an Integer, got #{@value.class}"
          raise ArgumentError, msg
        end
        @value
      end
      alias to_i to_int

      # Expects the value to be Numeric and returns the value
      # as a Float.
      # @return [Float]
      # @raise [ArgumentError] when the value is not Numeric.
      def to_float
        unless @value.is_a?(Numeric)
          msg = "expected #{@context} to be Numeric, got #{@value.class}"
          raise ArgumentError, msg
        end
        Float(@value)
      end
      alias to_f to_float

      # Expects the value to be `true` or `false` and then returns
      # the boolean value.
      # @return [Boolean]
      # @raise [ArgumentError] when the value is not `true` or `false`.
      def bool
        unless BOOLEANS.include?(@value)
          msg = "expected #{@context} to be true or false, got #{@value.class}"
          raise ArgumentError, msg
        end
        @value
      end

      # Expects the value to be readable or to be a String and then
      # returns the value as a base-64 encoded string of bytes.
      # @return [String<Base64>]
      # @raise [ArgumentError] when the value is not a String or readable.
      #   and when the object does not respond to `#read`.
      def base64
        if @value.respond_to?(:read)
          Base64.strict_encode64(@value.read)
        elsif @value.is_a?(String)
          Base64.strict_encode64(@value)
        else
          msg = format(BYTES, context: @context, class: @value.class)
          raise ArgumentError, msg
        end
      end

      # Expects the value to be readable or to be a String and then
      # returns the value as an object that responds to `#read`.
      # @return [#read] Returns an object that responds to `#read`.
      # @raise [ArgumentError] when the value is not a String or
      #   when the object does not respond to `#read`.
      def io
        if @value.respond_to?(:read)
          @value
        elsif @value.is_a?(String)
          StringIO.new(@value)
        else
          msg = format(BYTES, context: @context, class: @value.class)
          raise ArgumentError, msg
        end
      end

      # Expects the value to respond to `#to_time` and then
      # returns an ISO8601 datetime, e.g. "YYYY-MM-DDTHH:MM:SSZ".
      # @return [String<ISO8601-date-time>]
      # @raise [ArgumentError] when the value does not respond to `#to_time`
      def iso8601
        TimeHelper.format_iso8601(to_time)
      end

      # Expects the value to respond to `#to_time` and then
      # returns an httpdate string.
      # @return [String<httpdate>]
      # @raise [ArgumentError] when the value does not respond to `#to_time`
      def httpdate
        TimeHelper.format_httpdate(to_time)
      end

      # Expects the value to respond to `#to_time` and then
      # returns an epoch seconds timestamp integer.
      # @return [Integer<epoch-seconds>]
      # @raise [ArgumentError] when the value does not respond to `#to_time`
      def timestamp
        TimeHelper.format_unixtimestamp(to_time)
      end

      # Expects the value to respond to `#empty?` and that the `#empty?`
      # method returns `false`.
      # @return [self]
      # @raise [ArgumentError] when the value does not respond to `#empty?`.
      # @raise [ArgumentError] when the value is empty.
      def non_empty!
        unless @value.respond_to?(:empty?)
          msg = "expected value at #{@context} to respond to #empty?"
          raise ArgumentError, msg
        end
        if @value.empty?
          msg = "expected value at #{@context} not to be empty"
          raise ArgumentError, msg
        end
        self
      end

      # @return [Boolean] Returns `true` if the value is nil.
      def nil?
        @value.nil?
      end

      private

      def to_time
        unless @value.respond_to?(:to_time)
          msg = "expected #{@context} to respond to #to_time, got #{@value.class}"
          raise ArgumentError, msg
        end
        @value.to_time.utc
      end

    end

    class HashValue

      include Enumerable

      # @param [Hash] value
      # @param [String] context
      # @raise [ArgumentError] when value is not a Hash.
      def initialize(value, context: 'params')
        unless value.is_a?(Hash)
          msg = "expected #{context} to be a Hash, got #{value.class}"
          raise ArgumentError, msg
        end
        @value = value
        @context = context
      end

      # @param [Set] permitted_keys
      # @raise [ArgumentError] when the wrapped hash value has keys
      #   outside of the permitted set.
      # @return [self]
      def permit!(permitted_keys)
        @value.each_pair do |key, _|
          unless permitted_keys.include?(key)
            valid = permitted_keys.map(&:inspect).sort.join(', ')
            raise ArgumentError, "Unexpected key #{key.inspect} found " \
              "at #{@context}[#{key.inspect}]; valid keys include: #{valid}"
          end
        end
        self
      end

      # Returns the value at the given key wrapped as a {Value}.
      # @param [Symbol] key
      # @return [Value] Returns the value at the given key.
      def [](key)
        Value.new(@value[key], context: "#{@context}[#{key.inspect}]")
      end

      def key?(key)
        @value.key?(key)
      end

      # Enumerates the value yielding the hash keys and values.
      # Hash values are wrapped as {Value} objects.
      def each_pair
        @value.keys.each do |key|
          yield(key, self[key])
        end
      end
      alias each each_pair

      # Returns a new {HashValue} object that only contains they
      # given keys.
      # @return [HashValue]
      def slice(keys)
        hash = {}
        keys.each do |key|
          hash[key] = @value[key] unless @value[key].nil?
        end
        HashValue.new(hash, context: @context)
      end

      # @return [Boolean] Returns `true` if the hash value has no keys.
      def empty?
        @value.empty?
      end

    end

    class ArrayValue

      include Enumerable

      # @param [Array] value
      # @param [String] context
      # @raise [ArgumentError] when value is not an Array.
      def initialize(value, context: 'params')
        unless value.respond_to?(:each)
          raise ArgumentError, "expected #{context} to respond to " \
            "#each, got #{value.class}"
        end
        @value = value
        @context = context
      end

      # Enumerates the value yielding each item wrapped in a {Value}.
      def each
        i = 0
        @value.each_with_index do |item, i|
          yield(Value.new(item, context: "#{@context}[#{i}]"))
          i += 1
        end
      end

      def map(&block)
        values = []
        each do |value|
          values << yield(value)
        end
        values
      end

    end
  end
end
