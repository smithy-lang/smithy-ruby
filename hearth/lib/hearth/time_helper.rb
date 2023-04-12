# frozen_string_literal: true

require 'time'

module Hearth
  # A module that provides helper methods to convert from Time objects to
  # protocol specific serializable formats.
  # @api private
  module TimeHelper
    class << self
      # @param [Time] time
      # @return [String<Date Time>] The time as an ISO8601 string.
      def to_date_time(time)
        if time.subsec.zero?
          time.utc.strftime('%Y-%m-%dT%H:%M:%SZ')
        else
          time.utc.strftime('%Y-%m-%dT%H:%M:%S.%LZ')
        end
      end

      # @param [Time] time
      # @return [Float<Epoch Seconds>] Returns the float value of
      #   epoch seconds with millisecond precision.
      def to_epoch_seconds(time)
        time = time.utc
        epoch_seconds = time.to_i
        epoch_seconds += (time.nsec / 1_000_000) / 1000.0
        epoch_seconds
      end

      # @param [Time] time
      # @return [String<Http Date>] Returns the time formatted
      #   as an HTTP header date.
      def to_http_date(time)
        if time.subsec.zero?
          time.utc.httpdate
        else
          t = time.utc
          format('%s, %02d %s %0*d %02d:%02d:%02d.%03d GMT',
                 Time::RFC2822_DAY_NAME[t.wday],
                 t.day, Time::RFC2822_MONTH_NAME[t.mon - 1],
                 t.year.negative? ? 5 : 4, t.year,
                 t.hour, t.min, t.sec, (t.subsec * 1000).round)
        end
      end
    end
  end
end
