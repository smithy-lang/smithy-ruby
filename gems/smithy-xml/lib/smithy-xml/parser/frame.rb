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
          def new(path, parent, ref, result = nil)
            if self == Frame
              frame = frame_class(ref).allocate
              frame.send(:initialize, path, parent, ref, result)
              frame
            else
              super
            end
          end

          private

          def frame_class(ref)
            klass = FRAME_CLASSES[ref.shape.class]
            if klass == ListFrame && ref.traits.key?('smithy.api#xmlFlattened')
              FlatListFrame
            elsif klass == MapFrame && ref.traits.key?('smithy.api#xmlFlattened')
              MapEntryFrame
            else
              klass
            end
          end
        end

        def initialize(path, parent, ref, result)
          @path = path
          @parent = parent
          @ref = ref
          @result = result
          @text = []
        end

        attr_reader :parent, :ref, :result

        def append_text(value)
          @text << value
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
      end

      # @api private
      class BigDecimalFrame < Frame
        def result
          @text.empty? ? nil : BigDecimal(@text.join)
        end
      end

      # @api private
      class BlobFrame < Frame
        def result
          @text.empty? ? '' : Base64.decode64(@text.join)
        end
      end

      # @api private
      class BooleanFrame < Frame
        def result
          @text.empty? ? nil : (@text.join == 'true')
        end
      end

      # @api private
      class IntegerFrame < Frame
        def result
          @text.empty? ? nil : @text.join.to_i
        end
      end

      # @api private
      class FlatListFrame < Frame
        def initialize(xml_name, *args)
          super
          @member = Frame.new(xml_name, self, @ref.shape.member)
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
          @text.empty? ? nil : deserialize_number(@text.join)
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
          @member_xml_name = @ref.shape.member.traits['smithy.api#xmlName'] || 'member'
        end

        def child_frame(xml_name)
          unless xml_name == @member_xml_name
            raise NotImplementedError, "Expected XML name '#{@member_xml_name}' for ListFrame, got '#{xml_name}'"
          end

          Frame.new(xml_name, self, @ref.shape.member)
        end

        def consume_child_frame(child)
          @result << child.result unless child.is_a?(NullFrame)
        end
      end

      # @api private
      class MapEntryFrame < Frame
        def initialize(xml_name, *args)
          super
          @key_name = @ref.shape.key.traits['smithy.api#xmlName'] || 'key'
          @key = Frame.new(xml_name, self, @ref.shape.key)
          @value_name = @ref.shape.value.traits['smithy.api#xmlName'] || 'value'
          @value = Frame.new(xml_name, self, @ref.shape.value)
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

          MapEntryFrame.new(xml_name, self, @ref)
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
          @text.join
        end
      end

      # @api private
      class StructureFrame < Frame
        def initialize(xml_name, parent, ref, result = nil)
          super
          @members = {}
          ref.shape.members.each do |member_name, member_ref|
            @members[xml_name(member_ref)] = { name: member_name, ref: member_ref }
          end
          @result ||= ref.shape.type.new
        end

        def child_frame(xml_name)
          if (@member = @members[xml_name])
            Frame.new(xml_name, self, @member[:ref])
          elsif @ref.shape.is_a?(UnionShape)
            UnknownMemberFrame.new(xml_name, self, nil, @result)
          else
            NullFrame.new(xml_name, self)
          end
        end

        def consume_child_frame(child) # rubocop:disable Metrics/AbcSize
          case child
          when MapEntryFrame
            @result[@member[:name]] ||= {}
            @result[@member[:name]][child.key.result] = child.value.result
          when FlatListFrame
            @result[@member[:name]] ||= []
            @result[@member[:name]] << child.result
          when UnknownMemberFrame
            @result[:unknown] = { child.path.last => child.result }
          when NullFrame # do nothing
          else @result[@member[:name]] = child.result
          end
        end

        private

        def xml_name(ref)
          ref.traits['smithy.api#xmlName'] || ref.location_name
        end
      end

      # @api private
      class TimestampFrame < Frame
        def result
          @text.empty? ? nil : deserialize_time(@text.join)
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
          @text.join
        end
      end

      include Smithy::Schema::Shapes

      FRAME_CLASSES = {
        BigDecimalShape => BigDecimalFrame,
        BlobShape => BlobFrame,
        BooleanShape => BooleanFrame,
        EnumShape => StringFrame,
        FloatShape => FloatFrame,
        IntegerShape => IntegerFrame,
        IntEnumShape => IntegerFrame,
        ListShape => ListFrame,
        MapShape => MapFrame,
        StringShape => StringFrame,
        StructureShape => StructureFrame,
        TimestampShape => TimestampFrame,
        UnionShape => StructureFrame
      }.freeze
    end
  end
end
