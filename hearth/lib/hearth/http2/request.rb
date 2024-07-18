# frozen_string_literal: true

require_relative '../http/request'

module Hearth
  module HTTP2
    # Represents an HTTP2 request.
    class Request < Hearth::HTTP::Request
      # @param [Boolean] keep_open (false) When true the stream is left open
      #   (end_stream is set to false) after the data from the request body
      #   is sent.
      # @param (see Hearth::HTTP::Request#initialize)
      def initialize(keep_open: false, **kwargs)
        super(**kwargs)
        @keep_open = keep_open
      end

      # @return [Boolean]
      attr_accessor :keep_open
    end
  end
end
