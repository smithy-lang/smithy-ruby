# frozen_string_literal: true

require 'zlib'

module Hearth
  module EventStream
    module Binary
      # class for Encoding EventStream::Message into the EventStream
      # binary format (application/vnd.amazon.eventstream)
      # @api private
      class MessageEncoder
        # bytes of total overhead in a message, including prelude
        # and 4 bytes total message crc checksum
        OVERHEAD_LENGTH = 16

        # Maximum header length allowed (after encode) 128kb
        MAX_HEADERS_LENGTH = 131_072

        # Maximum payload length allowed (after encode) 16mb
        MAX_PAYLOAD_LENGTH = 16_777_216

        # Encodes EventStream::Message to encoded binary string.
        #
        # @param [Hearth::EventStream::Message] message
        #
        # @return [String] encoded binary string
        def encode(message)
          # create context buffer with encode headers
          encoded_header = encode_headers(message.headers)

          # encode content (prelude, header, payload)
          encoded_content = encode_content(message, encoded_header)

          # append message checksum
          message_checksum = Zlib.crc32(encoded_content, 0)
          [encoded_content, message_checksum].pack('a*N')
        end

        # Encodes headers part of an Hearth::EventStream::Message
        #   into String
        #
        # @param [Hash] headers
        #
        # @return [String]
        def encode_headers(headers)
          header_entries = headers.map do |key, value|
            encode_header(key, value)
          end
          validate_and_join!(header_entries)
        end

        private

        def encode_content(message, encoded_header)
          if message.payload.length > MAX_PAYLOAD_LENGTH
            raise EventPayloadLengthExceedError
          end

          header_length = encoded_header.bytesize
          encoded_payload = message.payload.read
          total_length =
            header_length + encoded_payload.bytesize + OVERHEAD_LENGTH

          # create message buffer with prelude section
          encoded_prelude = encode_prelude(total_length, header_length)

          # append message context (headers, payload)
          [
            encoded_prelude,
            encoded_header,
            encoded_payload
          ].pack('a*a*a*')
        end

        def encode_header(key, value)
          encoded_key = [key.bytesize, key].pack('Ca*')

          # header value
          pattern, value_length, type_index = Types.encode_info(value.type)
          encoded_value = [type_index].pack('C')
          # boolean types doesn't need to specify value
          if [true, false].include?(pattern)
            return [encoded_key,
                    encoded_value].pack('a*a*')
          end

          unless value_length
            encoded_value = [encoded_value,
                             value.value.bytesize].pack('a*S>')
          end

          [
            encoded_key,
            encoded_value,
            pattern ? [value.value].pack(pattern) : value.value
          ].pack('a*a*a*')
        end

        def validate_and_join!(header_entries)
          header_entries.join.tap do |encoded_header|
            if encoded_header.bytesize <= MAX_HEADERS_LENGTH
              break encoded_header
            end

            raise EventHeadersLengthExceedError
          end
        end

        def encode_prelude(total_length, headers_length)
          prelude_body = [total_length, headers_length].pack('NN')
          checksum = Zlib.crc32(prelude_body, 0)
          [prelude_body, checksum].pack('a*N')
        end
      end
    end
  end
end
