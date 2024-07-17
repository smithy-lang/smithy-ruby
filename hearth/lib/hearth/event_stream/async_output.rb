# frozen_string_literal: true

require_relative '../output'

module Hearth
  module EventStream
    # Represents an EventStream Message.
    class AsyncOutput < Output
      def initialize(response:, encoder:, **kwargs)
        super(**kwargs)
        @response = response
        @encoder = encoder
      end

      def end_input_stream
        stream = @response&.stream
        if stream_open?(stream)
          payload = @encoder ? @encoder.encode(:end_stream, Message.new) : ''
          stream.data(payload, end_stream: true)
        end
      end

      def join
        stream = @response&.stream
        return if stream.nil? || stream.closed?

        case stream.state
        when :closed # nothing to do
        when :half_closed_remote
          end_input_stream
          @response.sync_queue.pop
        when :open
          end_input_stream
          @response.sync_queue.pop
        when :half_closed_local
          @response.sync_queue.pop
        end
      end

      def kill
        if (stream = @response&.stream)
          stream.close
          stream.closed?
        end
      end

      private

      def send_event(message)
        stream = @response&.stream
        if stream_open?(stream)
          payload = @encoder.encode(:event, message)
          stream.data(payload, end_stream: false)
        else
          raise ArgumentError, 'Unable to send event message, '\
            'stream is closed or not set.'
        end
      end

      def stream_open?(stream)
        stream &&
          !stream.closed? &&
          stream.state != :half_closed_local
      end
    end
  end
end
