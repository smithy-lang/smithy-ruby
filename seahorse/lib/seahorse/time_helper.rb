# frozen_string_literal: true

require 'time'

module Seahorse
  module TimeHelper
    class << self

      # Attempts to create an instance of Ruby Time from the given
      # value. Returns nil if the given value is nil.
      # @param [String, Time, DateTime, Date, Numeric, nil] value
      # @return [Time<UTC>, nil]
      def from(value)
        case value
        when nil then nil
        when Numeric then ::Time.at(value).utc
        when /^\d+(\.\d+)?$/ then ::Time.at(value.to_f).utc
        when String then ::Time.parse(value).utc
        when ::Time then value.utc
        when Date then value.to_time.utc
        when DateTime then value.to_time.utc
        else raise ArgumentError, "unsupported type `#{value.class}'"
        end
      end

      # @param [Time] time
      # @return [String<ISO8601>]
      def format_iso8601(time)
        time.utc.strftime('%Y-%m-%dT%H:%M:%S.%LZ')
      end

      # @param [Time] time
      # @return [Float<Epoch Seconds>] Returns float value of
      #   epoch seconds with millisecond precision.
      def format_unixtimestamp(time)
        time = time.utc
        epoch_seconds = time.to_i
        epoch_seconds += (time.nsec / 1_000_000) / 1000.0
        epoch_seconds
      end

      # @param [Time] time
      # @return [String<Httpdate>] Returns the time formatted
      #   as an HTTP header date.
      def format_httpdate(time)
        time.utc.httpdate
      end

    end
  end
end
