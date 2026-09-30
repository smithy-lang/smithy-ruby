# frozen_string_literal: true

require 'time'

module Smithy
  module Schema
    # Shared schema utilities.
    # @api private
    module Utils
      class << self
        def serialize_timestamp(value, format)
          case format
          when 'date-time' then serialize_date_time(value)
          when 'http-date' then serialize_http_date(value)
          when 'epoch-seconds' then serialize_epoch_seconds(value)
          else raise ArgumentError, "unsupported timestamp format: #{format.inspect}"
          end
        end

        def deserialize_timestamp(value, format)
          time =
            case format
            when 'date-time' then Time.iso8601(value)
            when 'http-date' then Time.httpdate(value)
            when 'epoch-seconds' then Time.at(Rational(value.to_s))
            else raise ArgumentError, "unsupported timestamp format: #{format.inspect}"
            end

          time = truncate_milliseconds(time.utc)
          raise ArgumentError, 'timestamp is outside the supported Smithy range' unless (1..9999).cover?(time.year)

          time
        rescue ArgumentError, TypeError
          raise ArgumentError, "unhandled #{format} timestamp: #{value.inspect}"
        end

        private

        def truncate_milliseconds(value)
          Time.at(value.to_i, value.nsec / 1_000_000, :millisecond).utc
        end

        def serialize_epoch_seconds(value)
          return value.to_i if value.nsec.zero?

          milliseconds = (value.to_i * 1000) + (value.nsec / 1_000_000)
          milliseconds / 1000.0
        end

        def serialize_date_time(value)
          value.nsec.zero? ? value.utc.iso8601 : value.utc.iso8601(3)
        end

        def serialize_http_date(value)
          value.utc.httpdate
        end
      end
    end
  end
end
