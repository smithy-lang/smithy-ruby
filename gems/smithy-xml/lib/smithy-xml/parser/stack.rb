# frozen_string_literal: true

require_relative 'frame'

module Smithy
  module Xml
    class Parser
      # @api private
      class Stack
        def initialize(shape, result = nil, &unhandled_callback)
          @shape = shape
          @result = result
          @unhandled_callback = unhandled_callback
          @frame = self
        end

        attr_reader :frame, :result

        def start_element(name)
          @frame = @frame.child_frame(name.to_s)
        end

        def attr(name, value)
          if name.to_s == 'encoding' && value.to_s == 'base64'
            @frame = BlobFrame.new(name, @frame.parent, @frame.ref)
          else
            # don't try to parse shapes from xml namespace
            return if name.to_s == 'xmlns'

            start_element(name)
            text(value)
            end_element(name)
          end
        end

        def text(value)
          @frame.append_text(value)
        end

        def end_element(*_ignored)
          @frame.parent.consume_child_frame(@frame)
          if @frame.parent.is_a?(FlatListFrame)
            @frame = @frame.parent
            @frame.parent.consume_child_frame(@frame)
          end
          @frame = @frame.parent
        end

        def error(msg, line = nil, column = nil)
          raise ParseError.new(msg, line, column)
        end

        def child_frame(name)
          Frame.new(name, self, @shape, @result)
        end

        def consume_child_frame(frame)
          @result = frame.result
        end

        def yield_unhandled_value(path, value)
          @unhandled_callback&.call(path, value)
        end
      end
    end
  end
end
