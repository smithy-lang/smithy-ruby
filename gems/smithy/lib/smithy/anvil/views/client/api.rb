# frozen_string_literal: true

module Smithy
  module Anvil
    module Views
      module Client
        # TODO - Work in Progress
        # @api private
        class Api < View
          def initialize(plan)
            @plan = plan
            @model = plan.model
            @shapes, @operation_shapes, @service_shape = assemble_shapes
            super()
          end

          attr_reader :plan, :shapes, :operation_shapes, :service_shape

          def namespace
            Tools::Namespace.namespace_from_gem_name(@plan.options[:gem_name])
          end

          def shapes_with_members
            @shapes
              .collect { |s| s unless s.members.empty? }
              .compact
          end

          private

          def assemble_member_shapes(shape)
            return [] if shape.members.empty?

            shape.members.each_with_object([]) do |(_k,v), a|
              name = v.name_as_snake_case
              shape =
                if SMITHY_PRELUDE_SHAPES.include?(v.target)
                  SMITHY_PRELUDE_SHAPES[v.target]
                else
                  v.relative_target_id
                end

              traits = filter_traits(v)

              a << MemberShape.new(name, shape, traits)
            end
          end

          def assemble_shapes
            serializable_shapes = []
            operation_shapes = []
            service_shape = nil

            @model.shapes.each do |_id, shape|
              case shape.type
              when 'service'
                service_shape = shape
              when 'resource'
                next
              when 'operation'
                # TODO
              else
                serializable_shapes << serialize_shape(shape)
              end
            end
            [serializable_shapes, operation_shapes, service_shape]
          end

          def operation_shape(shape)
            # TODO
          end

          def serialize_shape(shape)
            SerializableShape.new(
              shape.id,
              shape.name,
              shape_class(shape.type),
              filter_traits(shape),
              assemble_member_shapes(shape)
            )
          end

          def shape_class(type)
            if SHAPE_CLASSES.include?(type)
              SHAPE_CLASSES[type]
            else
              raise ArgumentError, "Unsupported shape type: `#{type}'"
            end
          end

          def filter_traits(shape)
            shape.traits.each_with_object({}) do |(trait_name, trait), h|
              next if OMITTED_TRAITS.include?(trait_name)
              h[trait_name] = trait.data
            end
          end

          class SerializableShape
            TYPED_SHAPES = %w[StructureShape EnumShape UnionShape].freeze

            def initialize(id, name, type, traits, members)
              @id = id
              @name = name
              @type = type
              @traits = traits
              @members = members
              @typed = TYPED_SHAPES.include?(type)
            end

            attr_reader :name, :id, :type, :typed, :traits, :members
          end

          class SerializableOperation
            def initialize(id, name, input, output, errors, traits)
              @id = id
              @name = name
              @input = input
              @output = output
              @errors = errors
              @traits = traits
            end

            attr_reader :id, :name, :input, :output, :errors, :traits
          end

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
            smithy.api#references
          ]

          SHAPE_CLASSES = {
            'blob' => 'BlobShape',
            'boolean' => 'BooleanShape',
            'bigDecimal' => 'NumberShape',
            'string' => 'StringShape',
            'bigInteger' => 'NumberShape',
            'byte' => 'NumberShape',
            'double' => 'NumberShape',
            'enum' => 'EnumShape',
            'float' => 'NumberShape',
            'intEnum' => 'EnumShape',
            'integer' => 'NumberShape',
            'list' => 'ListShape',
            'long' => 'NumberShape',
            'map' => 'MapShape',
            'operation' => 'OperationShape',
            'service' => 'ServiceShape',
            'short' => 'NumberShape',
            'structure' => 'StructureShape',
            'timestamp' => 'TimestampShape',
            'union' => 'StructureShape'
          }

          SMITHY_PRELUDE_SHAPES = {
            'smithy.api#Blob' => nil,
            'smithy.api#Boolean' => nil,
            'smithy.api#String' => String,
            'smithy.api#Timestamp' => Time,
            'smithy.api#Byte' => Integer,
            'smithy.api#Short' => Integer,
            'smithy.api#Integer' => Integer,
            'smithy.api#Long' => Integer,
            'smithy.api#Float' => Integer,
            'smithy.api#Double' => Integer,
            'smithy.api#BigInteger' => Integer,
            'smithy.api#BigDecimal' => Integer,
            'smithy.api#Document' => nil,
            'smithy.api#PrimitiveBoolean' => nil,
            'smithy.api#PrimitiveByte' => nil,
            'smithy.api#PrimitiveShort' => nil,
            'smithy.api#PrimitiveInteger' => nil,
            'smithy.api#PrimitiveLong' => nil,
            'smithy.api#PrimitiveDouble' => nil,
          }
        end
      end
    end
  end
end
