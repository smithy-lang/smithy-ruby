# frozen_string_literal: true

require_relative '../output'

module Hearth
  module EventStream
    # Represents an Asynchronous output from an Event Stream operation.
    class AsyncOutput < Output
      # @param [Hearth::HTTP2::Response] response the response object.
      # @param [Hearth::EventStream::Encoder] encoder (nil) optional
      #   encoder.  Set only when bi-directional streaming and additional
      #   input events can be signaled.
      # @param (see Hearth::Output#initialize)
      def initialize(response:, encoder: nil, **kwargs)
        super(**kwargs)
        @response = response
        @encoder = encoder
      end

      # Sends a message to end the stream if its open locally.  If the
      # stream is half closed locally, does nothing (does not wait for
      # remote close).  If an encoder is set, it is used to encode a
      # blank message that is sent as the payload with the end_stream flag.
      def end_input_stream
        stream = @response&.stream
        return unless open_local?(stream)

        payload = @encoder ? @encoder.encode(:end_stream, Message.new) : ''
        stream.data(payload, end_stream: true)
      end

      # Close the stream and wait for a clean remote close.
      #
      # @return [Boolean] true when the stream was open and
      #   required waiting to close.
      def join
        return false unless @response

        stream = @response.stream

        return false if stream.nil? || stream.closed?

        case stream.state
        when :open, :half_closed_remote
          end_input_stream
          @response.sync_queue.pop
        when :half_closed_local
          @response.sync_queue.pop
        end
        true
      end

      # Close the stream immediately without waiting.
      def kill
        return false unless @response

        stream = @response.stream

        return false unless stream

        stream.close
        stream.closed?
      end

      private

      def send_event(message)
        if @response && (stream = @response.stream) && open_local?(stream)
          payload = @encoder.encode(:event, message)
          stream.data(payload, end_stream: false)
        else
          raise ArgumentError, 'Unable to send event message, ' \
                               'stream is closed or not set.'
        end
      end

      def open_local?(stream)
        stream &&
          !stream.closed? &&
          stream.state != :half_closed_local
      end
    end
  end
end
