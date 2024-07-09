# frozen_string_literal: true

module Hearth
  # Module for EventStreams.
  module EventStream
    class Encoder
      # TODO:
      # Set as the body on the request - input events written to body
      # which sends to stream.
      # Serialized Message from MessageBuilder classes is provided.
      # Must be configured with
      # a signer (and must maintain signer state).
      # This will be the body on the request.
      # It will handle initial request body (if required by protocol).
      # Also allows the H2 Client to set the open stream on it.

      # TODO: Handle initial event:
      # Idea: take initial event as initialize option, define a read method that returns it

      # TODO: Need a mechanism to get regular signature from initial headers!
      # maybe something in auth or sign middleware needs to understand if we are an event stream?
      # Idea: replace the sign middleware for eventstream operations! Use a sign_eventStream middleware
      # This will set the prior signature on the encoder!

      def initialize(signer:, message_encoder:)
        @signer = signer
        @prior_signature = nil
        @message_encoder = message_encoder
        @stream = nil
      end

      attr_accessor :stream
      attr_accessor :prior_signature

      def send_event(event_type, message)
        payload = encode(event_type, message)
        @stream.data(payload, end_stream: event_type == :end_stream)
      end

      private
      def encode(event_type, message)
        # TODO: Move this logic into v4 signer
        # if event_type == :end_stream
        #   payload = ''
        # else
        #   payload = @message_encoder.encode(message)
        # end
        signed_message, signature = @signer.sign_event(@prior_signature, event_type, message, @encoder)
        @prior_signature = signature
        @message_encoder.encode(signed_message)
      end
    end
  end
end
