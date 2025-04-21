# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class Schema < View
        SHAPE_TYPES_MAP = {
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
          'operation' => 'OperationShape',
          'service' => 'ServiceShape',
          'short' => 'IntegerShape',
          'string' => 'StringShape',
          'structure' => 'StructureShape',
          'timestamp' => 'TimestampShape',
          'union' => 'UnionShape'
        }.freeze

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

        def schema_type?
          @plan.type == :schema
        end

        def shapes
          @shapes ||=
            @service_index
            .shapes_for(@plan.service)
            .map { |k, v| build_shape(k, v) }
        end

        def shapes_with_members
          complex = %w[EnumShape IntEnumShape ListShape MapShape StructureShape UnionShape]
          @shapes.select { |s| complex.include?(s.type) }
        end

        def typed_shapes
          @shapes.select(&:typed).map { |s| "'#{s.id}' => #{s.name}" }
        end

        def operation_shapes
          @service_index
            .operations_for(@plan.service)
            .map { |k, v| build_operation_shape(k, v) }
        end

        def service_shape
          @service_shape ||=
            ServiceShape.new(
              id: @service_id,
              name: Model::Shape.name(@service_id),
              version: @service['version'],
              traits: @service['traits'] || {}
            )
        end

        private

        def build_operation_shape(id, shape)
          OperationShape.new(
            id: id,
            name: Model::Shape.name(id),
            input: shape_name_from_id(shape['input']['target']),
            output: shape_name_from_id(shape['output']['target']),
            errors: build_error_shapes(shape['errors']),
            traits: shape['traits'] || {}
          )
        end

        def build_error_shapes(errors)
          return [] if errors.nil?

          errors.map { |err| Model::Shape.relative_id(err['target']) }
        end

        def build_shape(id, shape)
          Shape.new(
            id: id,
            name: shape_name_from_id(id),
            type: shape_name_from_type(shape['type']),
            members: build_member_shapes(id, shape),
            traits: shape['traits'] || {}
          )
        end

        def build_member_shapes(id, shape)
          case shape['type']
          when 'enum', 'intEnum', 'structure', 'union'
            build_members(id, shape)
          when 'list'
            build_list_member(id, shape)
          when 'map'
            build_map_members(id, shape)
          else
            []
          end
        end

        def build_members(id, shape)
          shape['members'].map { |k, v| build_member_shape(id, k, v['target'], v['traits']) }
        end

        def build_list_member(id, shape)
          m_shape = shape['member']
          [] << build_member_shape(id, 'member', m_shape['target'], m_shape['traits'])
        end

        def build_map_members(id, shape)
          %w[key value].map do |m_name|
            m_shape = shape[m_name]
            build_member_shape(id, m_name, m_shape['target'], m_shape['traits'])
          end
        end

        def build_member_shape(parent_id, name, id, traits)
          MemberShape.new(
            parent_id: parent_id,
            name: name,
            shape: shape_name_from_id(id),
            traits: traits || {}
          )
        end

        def shape_name_from_type(type)
          msg = "Unsupported shape type: `#{type}'"
          raise ArgumentError, msg unless SHAPE_TYPES_MAP.include?(type)

          SHAPE_TYPES_MAP[type]
        end

        def shape_name_from_id(id)
          return PRELUDE_SHAPES_MAP[id] if PRELUDE_SHAPES_MAP.key?(id)

          Model::Shape.name(id).camelize
        end

        # @api private
        class Shape
          # Handled in code generation
          OMITTED_TRAITS = %w[
            smithy.api#documentation
          ].freeze

          TYPED_SHAPES = %w[StructureShape UnionShape].freeze

          def initialize(options = {})
            @id = options[:id]
            @name = options[:name]
            @type = options[:type]
            @members = options[:members]
            @traits = options[:traits].except(*OMITTED_TRAITS)
            @typed = TYPED_SHAPES.include?(@type)
          end

          attr_reader :name, :id, :type, :typed, :members, :traits

          def new_method
            traits_str = ", traits: #{@traits}" unless @traits.empty?
            "new(id: '#{@id}'#{traits_str})"
          end
        end

        # @api private
        class MemberShape
          # Handled in code generation
          OMITTED_TRAITS = %w[
            smithy.api#documentation
          ].freeze

          def initialize(options = {})
            @parent_id = options[:parent_id]
            @name = options[:name]
            @shape = options[:shape]
            @traits = options[:traits].except(*OMITTED_TRAITS)
          end

          def union_type
            "Types::#{Model::Shape.name(@parent_id).camelize}::#{@name.camelize}"
          end

          def add_member_method(shape)
            traits_str = ", traits: #{@traits}" unless @traits.empty?
            case shape
            when 'ListShape'
              "set_member(#{@shape}#{traits_str})"
            when 'MapShape'
              "set_#{@name}(#{@shape}#{traits_str})"
            when 'UnionShape'
              "add_member(:#{@name.underscore}, '#{@name}', #{@shape}, #{union_type}#{traits_str})"
            else
              "add_member(:#{@name.underscore}, '#{@name}', #{@shape}#{traits_str})"
            end
          end
        end

        # @api private
        class OperationShape
          # Handled in code generation
          OMITTED_TRAITS = %w[
            smithy.api#documentation
            smithy.api#examples
            smithy.api#paginated
            smithy.test#httpRequestTests
            smithy.test#httpResponseTests
            smithy.ruby#skipTests
          ].freeze

          def initialize(options = {})
            @id = options[:id]
            @name = options[:name]
            @input = options[:input]
            @output = options[:output]
            @errors = options[:errors]
            @traits = options[:traits].except(*OMITTED_TRAITS)
            @is_paginated = options[:traits].key?('smithy.api#paginated')
          end

          attr_reader :id, :name, :input, :output, :errors, :traits

          def symbol_name
            @name.underscore
          end

          def paginated?
            @is_paginated
          end

          def paginator
            "Paginators::#{@name}.new"
          end
        end

        # @api private
        class ServiceShape
          # Handled in code generation
          OMITTED_TRAITS = %w[
            smithy.api#documentation
            smithy.api#paginated
            smithy.rules#endpointRuleSet
            smithy.rules#endpointTests
          ].freeze

          def initialize(options = {})
            @id = options[:id]
            @name = options[:name]
            @version = options[:version]
            @traits = options[:traits].except(*OMITTED_TRAITS)
          end

          attr_reader :id, :name, :version, :traits

          def version?
            !!@version
          end
        end
      end
    end
  end
end
