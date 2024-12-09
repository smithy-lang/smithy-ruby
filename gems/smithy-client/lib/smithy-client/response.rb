# frozen_string_literal: true

require 'stringio'

module Smithy
  module Client
    # Represents a base response.
    class Response
      # @option options [IO, StringIO, #read, #size, #rewind] :body (StringIO.new)
      def initialize(options = {})
        self.body = options[:body] || StringIO.new
      end

      # @return [IO, StringIO]
      attr_reader :body

      # @param [#read, #size, #rewind] io
      def body=(io)
        @body =
          case io
          when nil then StringIO.new('')
          when String then StringIO.new(io)
          else io
          end
      end

      # Resets the response.
      # @return [Response]
      def reset
        # IO does not respond to #truncate but it does respond to #rewind
        # however it returns an illegal seek error.
        @body.truncate(0) if @body.respond_to?(:truncate)
        @body.rewind if @body.respond_to?(:rewind) && !@body.instance_of?(IO)
        self
      end
    end
  end
end
