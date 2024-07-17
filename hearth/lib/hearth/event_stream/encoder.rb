# frozen_string_literal: true

module Hearth
  # Module for EventStreams.
  module EventStream
    class Encoder

      # TODO: Handle initial event:
      # Idea: take initial event as initialize option, define a read method that returns it

      def initialize(message_encoder:, initial_event_body:)
        @message_encoder = message_encoder
        @initial_event_body = initial_event_body

        @prior_signature = nil
        @sign_event = nil
      end

      attr_accessor :prior_signature
      attr_accessor :sign_event

      def encode(event_type, message)
        signed_message, signature = sign_event.call(
          @prior_signature, event_type, message, @message_encoder)
        @prior_signature = signature
        @message_encoder.encode(signed_message)
      end
    end
  end
end
