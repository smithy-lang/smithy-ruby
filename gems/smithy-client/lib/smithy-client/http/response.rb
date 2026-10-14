# frozen_string_literal: true

require 'stringio'

module Smithy
  module Client
    module Http
      # Represents an HTTP Response.
      class Response
        # @option options [Integer] :status_code (0)
        # @option options [Headers] :headers (Headers.new)
        # @option options [IO] :body (StringIO.new)
        def initialize(options = {})
          @status_code = options[:status_code] || 0
          @headers = Headers.new(options[:headers] || {})
          self.body = options[:body]

          @listeners = Hash.new { |h, k| h[k] = [] }
          @done = nil
          @error = nil
          @error_notified = false
        end

        # @return [Integer]
        attr_accessor :status_code

        # @return [Headers]
        attr_reader :headers

        # @return [IO, StringIO]
        attr_reader :body

        # @return [StandardError, nil]
        attr_reader :error

        # @param [#read, #size, #rewind] io
        def body=(io)
          @body =
            case io
            when nil then StringIO.new
            when String then StringIO.new(io)
            else io
            end
        end

        # @param [Integer] status_code
        # @param [Hash<String, String>] headers
        def signal_headers(status_code, headers)
          return if @done

          @status_code = status_code
          @headers = Headers.new(headers)
          emit(:headers, @status_code, @headers)
        end

        # @param [String] chunk
        def signal_data(chunk)
          return if @done || chunk == ''

          @body.write(chunk)
          emit(:data, chunk)
        rescue StandardError => e
          record_error(e)
          signal_done
        end

        # Completes the HTTP response.
        #
        # @example Completing the response in a single call
        #
        #     http_response.signal_done(
        #       status_code: 200,
        #       headers: {},
        #       body: ''
        #     )
        #
        # @example Complete the response in parts
        #
        #     # signal headers straight-way
        #     http_response.signal_headers(200, {})
        #
        #     # signal data as it is received from the socket
        #     http_response.signal_data("...")
        #     http_response.signal_data("...")
        #     http_response.signal_data("...")
        #
        #     # signal done once the body data is all written
        #     http_response.signal_done
        #
        # @overload signal_done()
        #
        # @overload signal_done(options = {})
        #   @option options [required, Integer] :status_code
        #   @option options [required, Hash] :headers
        #   @option options [required, String] :body
        #
        def signal_done(options = {})
          return if @done

          if options.keys.sort == %i[body headers status_code]
            signal_headers(options[:status_code], options[:headers])
            signal_data(options[:body])
            signal_done
          elsif options.empty?
            # Mark completion before cleanup and callbacks to prevent re-entry.
            @done = true
            rewind_body
            emit(:done)
            notify_error
          else
            raise ArgumentError, 'options must be empty or must contain :status_code, :headers, and :body'
          end
        end

        # @param [StandardError] error
        # Records the first failure, including one discovered after completion.
        # Recording a late error does not repeat completion or body cleanup.
        def signal_error(error)
          @error ||= error
          @done ? notify_error : signal_done
        end

        # @param [Integer, Range<Integer>] status_code_range
        # @yield A block to be called when headers are received.
        def on_headers(status_code_range = nil, &block)
          @listeners[:headers] << listener(status_code_range, block)
        end

        # @yield A block to be called when data is received.
        def on_data(&block)
          @listeners[:data] << block
        end

        # @param [Integer, Range<Integer>] status_code_range
        # @yield A block to be called when the response is complete.
        # If already complete, invokes the block immediately; its exceptions propagate.
        def on_done(status_code_range = nil, &block)
          listener = listener(status_code_range, block)
          if @done
            listener.call
          else
            @listeners[:done] << listener
          end
        end

        # @param [Integer, Range<Integer>] status_code_range
        # @yield A block to be called at completion when no error has been recorded.
        def on_success(status_code_range = 200..599)
          on_done(status_code_range) do
            yield unless @error
          end
        end

        # @yieldparam [StandardError] error
        # @yield A block to be called when an error occurs.
        # If already complete with an error, invokes the block immediately; its exceptions propagate.
        def on_error(&block)
          callback = listener(0..599, block)
          if @done && @error
            callback.call(@error)
          else
            @listeners[:error] << callback
          end
        end

        # Resets the HTTP response.
        def reset
          @status_code = 0
          @headers.clear
          @body.truncate(0)
          @body.rewind
          @error = nil
          @done = nil
          @error_notified = false
        end

        private

        def rewind_body
          @body.rewind if @body.respond_to?(:rewind)
        rescue StandardError => e
          record_error(e)
        end

        # @param [StandardError] error
        def record_error(error)
          return if @error

          @error = NetworkingError.wrap(error)
        end

        # Error listeners run after completion listeners so they observe failures
        # raised during completion, regardless of registration order.
        def notify_error
          return unless @error
          return if @error_notified

          @error_notified = true
          emit(:error, @error)
        end

        def listener(range, block)
          range = range..range if range.is_a?(Integer)
          if range
            lambda do |*args|
              block.call(*args) if range.include?(@status_code)
            end
          else
            block
          end
        end

        def emit(event_name, *args)
          @listeners[event_name].each do |listener|
            listener.call(*args)
          rescue StandardError => e
            record_error(e)
            # Complete a failed headers/data delivery. Completion and error
            # listeners continue so one failure cannot skip remaining cleanup.
            unless @done
              signal_done
              break
            end
          end
        end
      end
    end
  end
end
