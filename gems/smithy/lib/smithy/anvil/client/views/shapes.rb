# frozen_string_literal: true

module Smithy
  module Anvil
    module Client
      module Views
        # TODO: Work in Progress
        # @api private
        class Shapes < View
          def initialize(plan)
            @plan = plan
            @model = plan.model
            @shapes, @operation_shapes, @service_shape = assemble_shapes
            super()
          end

          attr_reader :shapes, :operation_shapes, :service_shape

          def namespace
            Tools::Namespace.namespace_from_gem_name(@plan.options[:gem_name])
          end

          def shapes_with_members
            @shapes.reject { |s| s.members.empty? }
          end

          private

          def assemble_shapes
            serializable_shapes = []
            operation_shapes = []
            service_shape = nil

            @model.shapes.each_value do |v|
              case v.type
              when 'service'
                service_shape = v
              when 'resource' then next
              when 'operation'
                operation_shapes << assemble_operation_shape(v)
              else
                serializable_shapes << assemble_shape(v)
              end
            end
            [serializable_shapes, operation_shapes, service_shape]
          end

          def assemble_shape(shape_data)
            SerializableShape.new(
              id: shape_data.id,
              name: shape_data.name,
              shape_type: shape_type(shape_data.type),
              traits: filter_traits(shape_data.traits),
              members: assemble_member_shapes(shape_data.shape['members'])
            )
          end

          def assemble_member_shapes(members)
            return [] if members.nil?

            members.each_with_object([]) do |(k, v), a|
              a << MemberShape.new(
                k.underscore,
                assemble_shape_name(v['target']),
                filter_member_traits(v['traits'])
              )
            end
          end

          def assemble_shape_name(shape_id)
            if PRELUDE_SHAPES.include?(shape_id)
              PRELUDE_SHAPES[shape_id]
            else
              shape_id.split('#').last
            end
          end

          def assemble_error_shapes(error_shapes)
            return [] if error_shapes.nil?

            error_shapes.each_with_object([]) do |err, a|
              a << assemble_shape_name(err['target'])
            end
          end

          def assemble_operation_shape(shape_data)
            SerializableOperation.new(
              id: shape_data.id,
              name: assemble_shape_name(shape_data.id),
              input: assemble_shape_name(shape_data.shape['input']['target']),
              output: assemble_shape_name(shape_data.shape['output']['target']),
              errors: assemble_error_shapes(shape_data.shape['errors']),
              traits: filter_traits(shape_data.traits)
            )
          end

          def shape_type(type)
            msg = "Unsupported shape type: `#{type}'"
            raise ArgumentError, msg unless SHAPE_CLASSES.include?(type)

            SHAPE_CLASSES[type]
          end

          def filter_traits(shape_traits)
            return {} if shape_traits.empty?

            shape_traits.each_with_object({}) do |(trait_name, trait), h|
              next if OMITTED_TRAITS.include?(trait_name)

              h[trait_name] = trait.data
            end
          end

          def filter_member_traits(shape_traits)
            return {} unless shape_traits

            shape_traits.except(*OMITTED_TRAITS)
          end

          # Shape that contains relevant data that affects (de)serialization
          class SerializableShape
            TYPED_SHAPES = %w[StructureShape EnumShape UnionShape].freeze

            def initialize(options = {})
              @id = options[:id]
              @name = options[:name]
              @shape_type = options[:shape_type]
              @traits = options[:traits]
              @members = options[:members]
              @typed = TYPED_SHAPES.include?(@shape_type)
            end

            attr_reader :name, :id, :shape_type, :typed, :traits, :members
          end

          # Operation Shape that contains relevant data that affects (de)serialization
          class SerializableOperation
            def initialize(options = {})
              @id = options[:id]
              @name = options[:name]
              @input = options[:input]
              @output = options[:output]
              @errors = options[:errors]
              @traits = options[:traits]
            end

            attr_reader :id, :name, :input, :output, :errors, :traits
          end

          # Member Shape that contains relevant data that affects (de)serialization
          class MemberShape
            def initialize(name, shape, traits)
              @name = name
              @shape = shape
              @traits = traits
            end

            attr_reader :name, :shape, :traits
          end

          OMITTED_TRAITS = %w[
            smithy.api#documentation
            smithy.api#paginated
            smithy.api#readonly
          ].freeze

          SHAPE_CLASSES = {
            'blob' => 'BlobShape',
            'boolean' => 'BooleanShape',
            'bigDecimal' => 'BigDecimalShape',
            'string' => 'StringShape',
            'bigInteger' => 'IntegerShape',
            'byte' => 'IntegerShape',
            'double' => 'FloatShape',
            'enum' => 'EnumShape',
            'float' => 'FloatShape',
            'intEnum' => 'IntEnumShape',
            'integer' => 'IntegerShape',
            'list' => 'ListShape',
            'long' => 'IntegerShape',
            'map' => 'MapShape',
            'operation' => 'OperationShape',
            'service' => 'ServiceShape',
            'short' => 'NumberShape',
            'structure' => 'StructureShape',
            'timestamp' => 'TimestampShape',
            'union' => 'StructureShape'
          }.freeze

          PRELUDE_SHAPES = {
            'smithy.api#Blob' => 'PreludeShapes::Blob',
            'smithy.api#Boolean' => 'PreludeShapes::Boolean',
            'smithy.api#String' => 'PreludeShapes::String',
            'smithy.api#Timestamp' => 'PreludeShapes::Timestamp',
            'smithy.api#Byte' => 'PreludeShapes::Byte',
            'smithy.api#Short' => 'PreludeShapes::Short',
            'smithy.api#Integer' => 'PreludeShapes::Integer',
            'smithy.api#Long' => 'PreludeShapes::Long',
            'smithy.api#Float' => 'PreludeShapes::Float',
            'smithy.api#Double' => 'PreludeShapes::Double',
            'smithy.api#BigInteger' => 'PreludeShapes::BigInteger',
            'smithy.api#BigDecimal' => 'PreludeShapes::BigDecimal',
            'smithy.api#Document' => 'PreludeShapes::Document',
            'smithy.api#PrimitiveBoolean' => 'PreludeShapes::PrimitiveBoolean',
            'smithy.api#PrimitiveByte' => 'PreludeShapes::PrimitiveByte',
            'smithy.api#PrimitiveShort' => 'PreludeShapes::PrimitiveShort',
            'smithy.api#PrimitiveInteger' => 'PreludeShapes::PrimitiveInteger',
            'smithy.api#PrimitiveLong' => 'PreludeShapes::PrimitiveLong',
            'smithy.api#PrimitiveFloat' => 'PreludeShapes::PrimitiveFloat',
            'smithy.api#PrimitiveDouble' => 'PreludeShapes::PrimitiveDouble',
            'smithy.api#Unit' => 'PreludeShapes::Unit'
          }.freeze
        end
      end
    end
  end
end
