# frozen_string_literal: true

require_relative '../http/request'

module Hearth
  module HTTP2
    # Represents an HTTP2 request.
    class Request < Hearth::HTTP::Request
      # @param [Boolean] keep_open
      # @param (see Hearth::HTTP::Request#initialize)
      def initialize(keep_open: false, **kwargs)
        super(**kwargs)
        @keep_open = keep_open
      end

      attr_accessor :keep_open

    end
  end
end
