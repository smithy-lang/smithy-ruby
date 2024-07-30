# frozen_string_literal: true

module Hearth
  # Module for EventStreams.
  module EventStream
    # Event Stream encoder. Replaces the request body on operations with input
    # event streams and provides the ability to signal, encode,
    # sign (with state) and send event messages.
    class Encoder
      # @param [Object] message_encoder a protocol specific message encoder.
      def initialize(message_encoder:)
        @message_encoder = message_encoder

        @prior_signature = nil
        @sign_event = nil
      end

      # required to support retries of initial request
      def rewind; end

      # @param event_type [Symbol] the event type - :end_stream or :event
      # @param message [Message] the message to encode
      # @return [String] the signed and encoded message payload
      def encode(event_type, message)
        signed_message, signature = @sign_event.call(
          @prior_signature, event_type, message, @message_encoder
        )
        @prior_signature = signature
        @message_encoder.encode(signed_message)
      end

      # @param [Object] signature state from signing the initial request.
      attr_writer :prior_signature

      # @param [Callable] a callable/proc to sign events.
      attr_writer :sign_event
    end

    # An event stream Encoder with an initial message.  Defines a `read`
    # method that is used by the http2 client to send the initial message.
    class EncoderWithInitialMessage < Encoder
      # @param [Object] message_encoder a protocol specific message encoder.
      # @param [Message] initial_event the initial event.
      def initialize(message_encoder:, initial_event:)
        super(message_encoder: message_encoder)
        @initial_event = initial_event
      end

      def read
        # encode the initial-request message (including signature)
        encode(:event, @initial_event)
      end
    end
  end
end
