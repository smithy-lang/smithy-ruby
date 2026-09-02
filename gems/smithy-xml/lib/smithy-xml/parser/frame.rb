# frozen_string_literal: true

require 'base64'
require 'time'

module Smithy
  module Xml
    # @api private
    class Parser
      # @api private
      class Frame
        include Smithy::Schema::Shapes

        class << self
          def new(path, parent, shape, result = nil)
            if self == Frame
              frame = frame_class(shape).allocate
              frame.send(:initialize, path, parent, shape, result)
              frame
            else
              super
            end
          end

          private

          def frame_class(shape)
            Extension.frame_class(shape)
          end
        end

        def initialize(path, parent, shape, result)
          @path = path
          @parent = parent
          @shape = shape
          @result = result
          @text = nil
        end

        attr_reader :parent, :shape, :result

        def append_text(value)
          case @text
          when nil
            @text = value
          when String
            @text = [@text, value]
          else
            @text << value
          end
        end

        def child_frame(xml_name)
          NullFrame.new(xml_name, self)
        end

        def consume_child_frame(child); end

        # @api private
        def path
          if parent.is_a?(Stack)
            [@path]
          else
            parent.path + [@path]
          end
        end

        # @api private
        def yield_unhandled_value(path, value)
          parent.yield_unhandled_value(path, value)
        end

        def text_value
          @text.is_a?(Array) ? @text.join : @text
        end
      end

      # @api private
      class BigDecimalFrame < Frame
        def result
          @text.nil? ? nil : BigDecimal(text_value)
        end
      end

      # @api private
      class BlobFrame < Frame
        def result
          @text.nil? ? '' : Base64.decode64(text_value)
        end
      end

      # @api private
      class BooleanFrame < Frame
        def result
          @text.nil? ? nil : (text_value == 'true')
        end
      end

      # @api private
      class IntegerFrame < Frame
        def result
          @text.nil? ? nil : text_value.to_i
        end
      end

      # @api private
      class FlatListFrame < Frame
        def initialize(xml_name, *args)
          super
          @member = Frame.new(xml_name, self, @shape.target.member)
        end

        def result
          @member.result
        end

        def append_text(value)
          @member.append_text(value)
        end

        def child_frame(xml_name)
          @member.child_frame(xml_name)
        end

        def consume_child_frame(_child)
          @result = @member.result
        end
      end

      # @api private
      class FloatFrame < Frame
        def result
          @text.nil? ? nil : deserialize_number(text_value)
        end

        # @param [String] str
        # @return [Number] The input as a number
        def deserialize_number(str)
          case str
          when 'Infinity' then ::Float::INFINITY
          when '-Infinity' then -::Float::INFINITY
          when 'NaN' then ::Float::NAN
          when nil then nil
          else str.to_f
          end
        end
      end

      # @api private
      class ListFrame < Frame
        def initialize(*args)
          super
          @result = []
          @member_shape = @shape.target.member
          @member_xml_name = Smithy::Xml::Extension.wire_name(@member_shape)
        end

        def child_frame(xml_name)
          unless xml_name == @member_xml_name
            raise NotImplementedError, "Expected XML name '#{@member_xml_name}' for ListFrame, got '#{xml_name}'"
          end

          Frame.new(xml_name, self, @member_shape)
        end

        def consume_child_frame(child)
          @result << child.result unless child.is_a?(NullFrame)
        end
      end

      # @api private
      class MapEntryFrame < Frame
        def initialize(xml_name, *args)
          super
          @key_name, key_member, @value_name, value_member = Smithy::Xml::Extension.map_parts(@shape)
          @key = Frame.new(xml_name, self, key_member)
          @value = Frame.new(xml_name, self, value_member)
        end

        # @return [StringFrame]
        attr_reader :key

        # @return [Frame]
        attr_reader :value

        def child_frame(xml_name)
          if @key_name == xml_name
            @key
          elsif @value_name == xml_name
            @value
          else
            NullFrame.new(xml_name, self)
          end
        end
      end

      # @api private
      class MapFrame < Frame
        def initialize(*args)
          super
          @result = {}
        end

        def child_frame(xml_name)
          unless xml_name == 'entry'
            raise NotImplementedError, "Expected XML name 'entry' for MapFrame, got '#{xml_name}'"
          end

          MapEntryFrame.new(xml_name, self, @shape)
        end

        def consume_child_frame(child)
          @result[child.key.result] = child.value.result
        end
      end

      # @api private
      class NullFrame < Frame
        def self.new(xml_name, parent)
          super(xml_name, parent, nil, nil)
        end

        def append_text(value)
          yield_unhandled_value(path, value)
          super
        end
      end

      # @api private
      class StringFrame < Frame
        def result
          text_value || ''
        end
      end

      # @api private
      class StructureFrame < Frame
        def initialize(xml_name, parent, shape, result = nil)
          super
          @members = Smithy::Xml::Extension.member_index(shape.target)
          @result ||= shape.target.type.new
        end

        def child_frame(xml_name)
          if (@member = @members[xml_name])
            _member_name, member_shape = @member
            Frame.new(xml_name, self, member_shape)
          elsif @shape.target.is_a?(UnionShape)
            UnknownMemberFrame.new(xml_name, self, nil, @result)
          else
            NullFrame.new(xml_name, self)
          end
        end

        def consume_child_frame(child) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
          member_name = @member&.first
          case child
          when MapEntryFrame
            @result[member_name] ||= {}
            @result[member_name][child.key.result] = child.value.result
          when FlatListFrame
            @result[member_name] ||= []
            @result[member_name] << child.result
          when UnknownMemberFrame
            @result[:unknown] = { child.path.last => child.result }
          when NullFrame # do nothing
          else @result[member_name] = child.result
          end
        end
      end

      # @api private
      class TimestampFrame < Frame
        def result
          @text.nil? ? nil : deserialize_time(text_value)
        end

        # @param [String] value
        # @return [Time]
        def deserialize_time(value)
          case value
          when nil then nil
          when /^[\d.]+$/ then Time.at(value.to_f).utc
          else
            begin
              fractional_time = Time.parse(value).to_f
              Time.at(fractional_time).utc
            rescue ArgumentError
              raise "unhandled timestamp format `#{value}'"
            end
          end
        end
      end

      # @api private
      class UnknownMemberFrame < Frame
        def result
          text_value || ''
        end
      end

      include Smithy::Schema::Shapes
    end
  end
end
