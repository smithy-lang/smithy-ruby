# frozen_string_literal: true

module Hearth
  # Module for EventStreams.
  module EventStream
    class Encoder

      # TODO: Handle initial event:
      # Idea: take initial event as initialize option, define a read method that returns it

      # TODO: Need a mechanism to get regular signature from initial headers!
      # maybe something in auth or sign middleware needs to understand if we are an event stream?
      # Idea: replace the sign middleware for eventstream operations! Use a sign_eventStream middleware
      # This will set the prior signature on the encoder!

      def initialize(message_encoder:)
        @prior_signature = nil
        @sign_event = nil
        @message_encoder = message_encoder
        @stream = nil
      end

      attr_accessor :stream
      attr_accessor :prior_signature
      attr_accessor :sign_event

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
        signed_message, signature = sign_event.call(
          @prior_signature, event_type, message, @message_encoder)
        @prior_signature = signature
        @message_encoder.encode(signed_message)
      end
    end
  end
end
