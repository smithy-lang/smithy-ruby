# frozen_string_literal: true

module Smithy
  module Client
    # @api private
    module Shapes
      class ServiceShape < Shape
        include Enumerable

        def initialize(options = {})
          @operations = {}
          @version = options[:version]
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

        # @return [Enumerable<Hash<String, OperationShape>>]
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

      class BlobShape < Shape; end

      class BooleanShape < Shape; end

      class DocumentShape < Shape; end

      class EnumShape < Shape
        def initialize(options = {})
          @enum_type = options[:enum_type]
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

      class ListShape < Shape
        def initialize(options = {})
          @member = nil
        end

        # @return [MemberShape, nil]
        attr_accessor :member

        # @return [MemberShape]
        def set_member(name, shape, traits: {})
          @member = MemberShape.new(name, shape, traits: traits)
        end
      end

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
        def set_member_key(name, shape, traits: {})
          @member_key = MemberShape.new(name, shape, traits: traits)
        end

        # @return [MemberShape]
        def set_member_value(name, shape, traits: {})
          @member_value = MemberShape.new(name, shape, traits: traits)
        end
      end

      class NumberShape < Shape; end

      class StringShape < Shape; end

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

      class TimeStampShape < Shape; end

      class UnionShape < StructureShape; end

      private

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

      class MemberShape < Shape
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
