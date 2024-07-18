# frozen_string_literal: true

module Hearth
  # Module for EventStreams.
  module EventStream
    class Encoder

      def initialize(message_encoder:, initial_event_body:)
        @message_encoder = message_encoder
        @initial_event_body = initial_event_body

        @prior_signature = nil
        @sign_event = nil

        if @initial_event_body && @initial_event_body.is_a?(Message)
          puts "SETUP INITIAL BODY: `#{@initial_event_body}"
          self.define_singleton_method(:read) do
            # encode the initial-request message (including signature)
            encode(:event, @initial_event_body)
          end
        end
      end

      # required to support retries of initial request
      def rewind
        if @initial_event_body
          @initial_event_body.rewind
        end
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
