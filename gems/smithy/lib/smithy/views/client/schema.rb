# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class Schema < View
        def initialize(plan)
          @plan = plan
          @model = plan.model
          @service_id, @service = plan.service.first
          @service_index = Model::ServiceIndex.new(@model)
          super()
        end

        def module_name
          @plan.module_name
        end

        def schema_gem?
          @plan.type == :schema
        end

        def service_shape
          @service_shape ||= ServiceShape.new(@plan.service)
        end

        def operation_shapes
          @operation_shapes ||=
            @service_index
            .operations_for(@plan.service)
            .map { |k, v| OperationShape.new(@plan.service, k, v) }
        end

        def shapes
          @shapes ||=
            @service_index
            .shapes_for(@plan.service)
            .map { |k, v| build_shape(k, v) }
        end

        private

        def build_shape(id, shape)
          args = [@plan.service, id, shape]
          case shape['type']
          when 'enum' then EnumShape.new(*args)
          when 'intEnum' then IntEnumShape.new(*args)
          when 'structure' then StructureShape.new(*args)
          when 'list' then ListShape.new(*args)
          when 'map' then MapShape.new(*args)
          when 'union' then UnionShape.new(*args)
          else Shape.new(*args)
          end
        end

        # @api private
        class ServiceShape
          OMITTED_TRAITS = %w[
            smithy.api#documentation
            smithy.api#paginated
            smithy.rules#endpointRuleSet
            smithy.rules#endpointTests
          ].freeze

          def initialize(service)
            @id, @service = service.first
            @version = @service['version']
            @traits = @service.fetch('traits', {}).except(*OMITTED_TRAITS)
          end

          attr_reader :id, :version, :traits

          def name
            Model::Shape.name(@id).camelize
          end
        end

        # @api private
        class OperationShape
          OMITTED_TRAITS = %w[
            smithy.api#documentation
            smithy.api#examples
            smithy.api#paginated
            smithy.test#httpRequestTests
            smithy.test#httpResponseTests
            smithy.ruby#skipTests
          ].freeze

          def initialize(service, id, shape)
            _, @service = service.first
            @id = id
            @input = ShapeRef.new(@service, nil, shape['input'])
            @output = ShapeRef.new(@service, nil, shape['output'])
            @errors = build_errors(@service['errors'] || []).concat(build_errors(shape['errors'] || []))
            @traits = shape.fetch('traits', {})
          end

          attr_reader :id, :input, :output, :errors

          def name
            Model::Shape.name(@id)
          end

          def traits
            @traits.except(*OMITTED_TRAITS)
          end

          def paginated?
            @traits.include?('smithy.api#paginated')
          end

          def paginator
            "Paginators::#{Model::Shape.name(@id)}.new"
          end

          private

          def build_errors(errors)
            errors.map { |shape_ref| ShapeRef.new(@service, nil, shape_ref) }
          end
        end

        # @api private
        class Shape
          OMITTED_TRAITS = %w[
            smithy.api#default
            smithy.api#documentation
          ].freeze

          SHAPE_CLASS_MAP = {
            'bigDecimal' => 'BigDecimalShape',
            'bigInteger' => 'IntegerShape',
            'blob' => 'BlobShape',
            'boolean' => 'BooleanShape',
            'byte' => 'IntegerShape',
            'document' => 'DocumentShape',
            'double' => 'FloatShape',
            'enum' => 'EnumShape',
            'float' => 'FloatShape',
            'integer' => 'IntegerShape',
            'intEnum' => 'IntEnumShape',
            'list' => 'ListShape',
            'long' => 'IntegerShape',
            'map' => 'MapShape',
            'short' => 'IntegerShape',
            'string' => 'StringShape',
            'structure' => 'StructureShape',
            'timestamp' => 'TimestampShape',
            'union' => 'UnionShape'
          }.freeze

          def initialize(service, id, shape)
            _, @service = service.first
            @id = id
            @shape = shape
            @type = shape['type']
            @traits = shape.fetch('traits', {}).except(*OMITTED_TRAITS)
          end

          attr_reader :type

          def name
            @service.dig('rename', @id) || Model::Shape.name(@id).camelize
          end

          def initializer
            traits_str = ", traits: #{@traits}" unless @traits.empty?
            "#{SHAPE_CLASS_MAP[@type]}.new(id: '#{@id}'#{traits_str})"
          end
        end

        # @api private
        class StructureShape < Shape
          def initialize(service, id, shape)
            super
            @members = build_shape_refs(shape['members'])
          end

          attr_reader :members

          def type_class
            "Types::#{Model::Shape.name(@id).camelize}"
          end

          def http_payload?
            @members.any?(&:http_payload?)
          end

          def http_payload
            @members.find(&:http_payload).http_payload
          end

          private

          def build_shape_refs(members)
            members.map { |name, shape_ref| ShapeRef.new(@service, name, shape_ref) }
          end
        end

        # @api private
        class EnumShape < Shape
          def initialize(service, id, shape)
            super
            @members = build_shape_refs(shape['members'])
          end

          attr_reader :members

          private

          def build_shape_refs(members)
            members.map { |name, shape_ref| ShapeRef.new(@service, name, shape_ref) }
          end
        end

        # @api private
        class IntEnumShape < Shape
          def initialize(service, id, shape)
            super
            @members = build_shape_refs(shape['members'])
          end

          attr_reader :members

          private

          def build_shape_refs(members)
            members.map { |name, shape_ref| ShapeRef.new(@service, name, shape_ref) }
          end
        end

        # @api private
        class ListShape < Shape
          def initialize(service, id, shape)
            super
            @member = ShapeRef.new(@service, nil, shape['member'])
          end

          attr_reader :member
        end

        # @api private
        class MapShape < Shape
          def initialize(service, id, shape)
            super
            @key = ShapeRef.new(@service, nil, shape['key'])
            @value = ShapeRef.new(@service, nil, shape['value'])
          end

          attr_reader :key, :value
        end

        # @api private
        class UnionShape < Shape
          def initialize(service, id, shape)
            super
            @members = build_shape_refs(shape['members'])
          end

          attr_reader :members

          def type_class
            "Types::#{Model::Shape.name(@id).camelize}"
          end

          def union_type(shape_ref)
            "#{type_class}::#{shape_ref.name.camelize}"
          end

          private

          def build_shape_refs(members)
            members.map { |name, shape_ref| ShapeRef.new(@service, name, shape_ref) }
          end
        end

        # @api private
        class ShapeRef
          OMITTED_TRAITS = %w[
            smithy.api#default
            smithy.api#documentation
          ].freeze

          PRELUDE_SHAPES_MAP = {
            'smithy.api#BigInteger' => 'Prelude::BigInteger',
            'smithy.api#BigDecimal' => 'Prelude::BigDecimal',
            'smithy.api#Blob' => 'Prelude::Blob',
            'smithy.api#Boolean' => 'Prelude::Boolean',
            'smithy.api#Byte' => 'Prelude::Byte',
            'smithy.api#Document' => 'Prelude::Document',
            'smithy.api#Double' => 'Prelude::Double',
            'smithy.api#Float' => 'Prelude::Float',
            'smithy.api#Integer' => 'Prelude::Integer',
            'smithy.api#Long' => 'Prelude::Long',
            'smithy.api#PrimitiveBoolean' => 'Prelude::PrimitiveBoolean',
            'smithy.api#PrimitiveByte' => 'Prelude::PrimitiveByte',
            'smithy.api#PrimitiveDouble' => 'Prelude::PrimitiveDouble',
            'smithy.api#PrimitiveFloat' => 'Prelude::PrimitiveFloat',
            'smithy.api#PrimitiveInteger' => 'Prelude::PrimitiveInteger',
            'smithy.api#PrimitiveLong' => 'Prelude::PrimitiveLong',
            'smithy.api#PrimitiveShort' => 'Prelude::PrimitiveShort',
            'smithy.api#Short' => 'Prelude::Short',
            'smithy.api#String' => 'Prelude::String',
            'smithy.api#Timestamp' => 'Prelude::Timestamp',
            'smithy.api#Unit' => 'Prelude::Unit'
          }.freeze

          def initialize(service, member_name, shape_ref)
            @service = service
            @name = member_name.underscore if member_name
            @member_name = member_name
            @target = target(shape_ref['target'])
            @traits = shape_ref.fetch('traits', {}).except(*OMITTED_TRAITS)
          end

          attr_reader :name

          def target(id)
            return PRELUDE_SHAPES_MAP[id] if PRELUDE_SHAPES_MAP.key?(id)

            @service.dig('rename', id) || Model::Shape.name(id).camelize
          end

          def initializer
            traits_str = ", traits: #{@traits}" unless @traits.empty?
            member_name_str = ", member_name: '#{@member_name}'" if @member_name
            "ShapeRef.new(shape: #{@target}#{member_name_str}#{traits_str})"
          end

          def http_payload?
            @traits.include?('smithy.api#httpPayload')
          end

          def http_payload
            return unless http_payload?

            @name
          end
        end
      end
    end
  end
end
