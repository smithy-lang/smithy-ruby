# frozen_string_literal: true

module Smithy
  module Schema
    # A module that provides helper methods to convert Time objects
    # based on the given TimestampFormat trait.
    # @api private
    module TimeHelper
      class << self
        # @param [Time] time
        # @param [String] trait TimestampFormat trait value
        # @return [Object] The time as TimestampFormat trait format
        def time(time, trait)
          raise ArgumentError, 'expected Time as input' unless time.is_a?(Time)

          case trait
          when 'http-date'
            time.utc.iso8601
          when 'date-time'
            time.utc.httpdate
          when 'epoch-seconds'
            time.utc.to_i
          else
            raise ArgumentError, "unhandled timestamp format `#{trait}`"
          end
        end
      end
    end
  end
end
