# frozen_string_literal: true

require 'zlib'

module Hearth
  module EventStream
    module Binary
      # This class provides method for decoding binary inputs into
      # messages.
      # @api private
      class MessageDecoder
        ONE_MEGABYTE = 1024 * 1024

        # bytes of prelude part, including 4 bytes of
        # total message length, headers length and crc checksum of prelude
        PRELUDE_LENGTH = 12

        # 4 bytes message crc checksum
        CRC32_LENGTH = 4

        # @param [Hash] options The initialization options.
        def initialize
          @message_buffer = ''
        end

        # Decodes a single message from a chunk of string
        #
        # @param [String] chunk A chunk of string to be decoded,
        #   chunk can contain partial event message to multiple event messages
        #   When not provided, decode data from #message_buffer
        #
        # @return [Array<Message|nil, Boolean>] Returns single decoded message
        #   and boolean pair, the boolean flag indicates whether this chunk
        #   has been fully consumed, unused data is tracked at #message_buffer
        def decode(chunk = nil)
          @message_buffer = [@message_buffer, chunk].pack('a*a*') if chunk
          decode_message(@message_buffer)
        end

        private

        # exposed via object.send for testing
        attr_reader :message_buffer

        def decode_message(raw_message)
          # incomplete message prelude received
          return [nil, true] if raw_message.bytesize < PRELUDE_LENGTH

          prelude, content = raw_message.unpack("a#{PRELUDE_LENGTH}a*")

          # decode prelude
          total_length, header_length = decode_prelude(prelude)

          # incomplete message received, leave it in the buffer
          return [nil, true] if raw_message.bytesize < total_length

          content, checksum, remaining = content.unpack(
            "a#{total_length - PRELUDE_LENGTH - CRC32_LENGTH}Na*"
          )

          validate_checksum!(prelude, content, checksum)

          # decode headers and payload
          headers, payload = decode_context(content, header_length)

          @message_buffer = remaining

          [Message.new(headers: headers, payload: payload), remaining.empty?]
        end

        def validate_checksum!(prelude, content, checksum)
          return if Zlib.crc32([prelude, content].pack('a*a*'), 0) == checksum

          raise MessageDecodeError, 'Message checksum mismatch'
        end

        def decode_prelude(prelude)
          # prelude contains length of message and headers,
          # followed with CRC checksum of itself
          content, checksum = prelude.unpack(
            "a#{PRELUDE_LENGTH - CRC32_LENGTH}N"
          )
          unless Zlib.crc32(content, 0) == checksum
            raise MessageDecodeError, 'Prelude checksum mismatch'
          end

          content.unpack('N*')
        end

        def decode_context(content, header_length)
          encoded_header, encoded_payload = content.unpack(
            "a#{header_length}a*"
          )
          [
            extract_headers(encoded_header),
            extract_payload(encoded_payload)
          ]
        end

        # rubocop:disable Metrics
        def extract_headers(buffer)
          scanner = buffer
          headers = {}
          until scanner.bytesize.zero?
            # header key
            key_length, scanner = scanner.unpack('Ca*')
            key, scanner = scanner.unpack("a#{key_length}a*")

            # header value
            type_index, scanner = scanner.unpack('Ca*')
            value_type = Types.type_from_index(type_index)
            unpack_pattern, value_length, = Types.encode_info(value_type)
            value, scanner = extract_header_value(scanner, unpack_pattern,
                                                  value_length)

            headers[key] = HeaderValue.new(
              value: value,
              type: value_type
            )
          end
          headers
        end

        def extract_header_value(scanner, unpack_pattern, value_length)
          value =
            if [true, false].include?(unpack_pattern)
              # boolean types won't have value specified
              unpack_pattern
            else
              value_length, scanner = scanner.unpack('S>a*') unless value_length
              unpacked_value, scanner = scanner.unpack(
                "#{unpack_pattern || "a#{value_length}"}a*"
              )
              unpacked_value
            end
          [value, scanner]
        end

        # rubocop:enable Metrics

        def extract_payload(encoded)
          StringIO.new(encoded)
        end
      end
    end
  end
end
