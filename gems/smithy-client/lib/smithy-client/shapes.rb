# frozen_string_literal: true

module Smithy
  module Client
    # Represents shape types from Smithy Model
    module Shapes
      # A base shape that all shapes inherits from
      class Shape
        def initialize(options = {})
          @shape_id = options[:shape_id]
          @traits = options[:traits] || {}
        end

        # @return [String, nil]
        attr_reader :shape_id

        # @return [Hash<String, [Boolean, Hash, Integer, String]>]
        attr_reader :traits
      end

      # Represents a slim variation of the Service shape
      class ServiceShape < Shape
        include Enumerable

        def initialize(options = {})
          @operations = {}
          @version = options[:version]
          super
          yield self if block_given?
        end

        # @return [Hash<String, OperationShape>]
        attr_accessor :operations

        # @return [String, nil]
        attr_reader :version

        # @return [OperationShape]
        def add_operation(name, operation)
          @operations[name] = operation
        end

        # @return [Hash<String, OperationShape>]
        def each(&block)
          @operations.each(&block)
        end

        # @return [String]
        def inspect
          "#<#{self.class.name}>"
        end

        # @return [Array<String>]
        def operation_names
          @operations.keys
        end
      end

      # Represents an Operation shape
      class OperationShape < Shape
        def initialize(options = {})
          @errors = options[:errors] || []
          @input = options[:input]
          @output = options[:output]
          super
        end

        # @return [Array<StructureShape>]
        attr_reader :errors

        # @return [StructureShape, nil]
        attr_reader :input

        # @return [StructureShape, nil]
        attr_reader :output
      end

      # Represents BigDecimal shape
      class BigDecimal < Shape; end

      # Represents both Blob and Data Stream shapes
      class BlobShape < Shape; end

      # Represents a Boolean shape
      class BooleanShape < Shape; end

      # Represents a Document shape
      class DocumentShape < Shape; end

      # Represents both Enum and IntEnum shapes
      class EnumShape < Shape
        ENUM_TYPES = %i[int str].freeze

        def initialize(options = {})
          @enum_type = ENUM_TYPES.include?(options[:enum_type]) ? options[:enum_type] : nil
          @members = {}
          super
        end

        # @return [Symbol, nil]
        attr_reader :enum_type

        # @return [Hash<String, MemberShape>]
        attr_accessor :members

        # @return [MemberShape, nil]
        def add_member(name, shape, traits: {})
          @members[name] = MemberShape.new(name, shape, traits: traits)
        end
      end

      # Represents both Float and double shapes
      class FloatShape < Shape; end

      # Represents a List shape
      class ListShape < Shape
        def initialize(options = {})
          @member = nil
          super
        end

        # @return [MemberShape, nil]
        attr_accessor :member

        # @return [MemberShape]
        def set_member(name, shape, traits: {})
          @member = MemberShape.new(name, shape, traits: traits)
        end
      end

      # Represents a Map shape
      class MapShape < Shape
        def initialize(options = {})
          @member_key = nil
          @member_value = nil
          super
        end

        # @return [MemberShape, nil]
        attr_accessor :member_key

        # @return [MemberShape, nil]
        attr_accessor :member_value

        # @return [MemberShape]
        def set_member_key(shape, traits: {})
          @member_key = MemberShape.new('key', shape, traits: traits)
        end

        # @return [MemberShape]
        def set_member_value(shape, traits: {})
          @member_value = MemberShape.new('value', shape, traits: traits)
        end
      end

      # Represents the following shapes:
      # Byte, Short, Integer, Long, BigInteger
      class IntegerShape < Shape; end

      # Represents the String shape
      class StringShape < Shape; end

      # Represents the Structure shape
      class StructureShape < Shape
        def initialize(options = {})
          @members = {}
          @type = options[:type]
          super
        end

        # @return [Hash<String, MemberShape>]
        attr_accessor :members

        # @return [Types]
        attr_accessor :type

        # @return [MemberShape]
        def add_member(name, shape, traits: {})
          @members[name] = MemberShape.new(name, shape, traits: traits)
        end
      end

      # Represents the Timestamp shape
      class TimestampShape < Shape; end

      # Represents both Union and Eventstream shapes
      class UnionShape < StructureShape; end

      # Represents a member shape
      class MemberShape
        def initialize(name, shape, traits: {})
          @name = name
          @shape = shape
          @traits = traits
        end

        # @return [String]
        attr_reader :name

        # @return [Shape]
        attr_reader :shape

        # @return [Hash<String, [Boolean, Hash, Integer, String]>]
        attr_reader :traits
      end
    end
  end
end
