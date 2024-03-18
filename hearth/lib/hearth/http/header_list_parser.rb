# frozen_string_literal: true

require 'strscan'

module Hearth
  module Http
    # @api private
    module HeaderListParser
      # parse a list of possibly quoted and escaped string values
      # Follows:
      # # [RFC-7230's specification of header values](https://datatracker.ietf.org/doc/html/rfc7230#section-3.2.6).
      def self.parse_string_list(value)
        buffer = StringScanner.new(value)
        parsed = []

        parsed << read_value(buffer) until buffer.eos?

        parsed
      end

      def self.read_value(buffer)
        until buffer.eos?
          case buffer.peek(1)
          when ' ', "\t"
            # drop leading whitespace
            buffer.getch
            next
          when '"'
            buffer.getch # drop the quote and advance
            return read_quoted_value(buffer)
          else
            return read_unquoted_value(buffer)
          end
        end
        # buffer is only whitespace
        nil
      end

      def self.read_unquoted_value(buffer)
        # there cannot be any escaped values
        value = buffer.scan_until(/,|$/)
        # drop the comma if we matched it
        buffer.matched == ',' ? value.chop : value
      end

      def self.read_quoted_value(buffer)
        # scan until we have an unescaped double quote
        value = buffer.scan_until(/[^\\]"/)
        unless value
          raise ArgumentError,
                'Invalid String list: No closing quote found'
        end

        # drop any remaining whitespapce/commas
        buffer.scan_until(/[\s,]*/)
        # the last character will always be the closing quote.
        # Add a starting quote  and then unescape (undump)
        "\"#{value}".undump
      end
    end
  end
end
