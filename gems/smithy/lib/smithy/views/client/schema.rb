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

        # Shared resolution logic for the schema view classes. Mixed into the
        # shape views ({Shape} and its subclasses), {OperationShape}, and
        # {MemberShape} — every class that needs to turn an absolute shape ID
        # into the Ruby constant the generated schema references. Relies on the
        # including class exposing the unwrapped service hash as +@service+.
        # @api private
        module SchemaHelper
          # Maps Smithy prelude shape IDs to their generated +Prelude::*+
          # constant names. Prelude shapes are shared built-ins and are never
          # emitted per-service, so they resolve to a fixed constant rather than
          # a service-local one.
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

          # Resolves an absolute shape ID to the Ruby constant the generated
          # schema references for it.
          #
          # - Prelude shapes resolve to their fully-qualified
          #   +::Smithy::Schema::Shapes::Prelude::*+ constant.
          # - All other shapes resolve to a service-local constant name,
          #   honoring the service's +rename+ map when present.
          #
          # @param [String] id Absolute shape ID (e.g. +"example.weather#GetCityInput"+).
          # @return [String] The constant reference as a string (e.g. +"GetCityInput"+).
          def shape_name_from_id(id)
            return "::Smithy::Schema::Shapes::#{PRELUDE_SHAPES_MAP[id]}" if PRELUDE_SHAPES_MAP.key?(id)

            (@service.dig('rename', id) || Model::Shape.name(id)).camelize
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
          include SchemaHelper

          OMITTED_TRAITS = %w[
            smithy.api#documentation
            smithy.api#examples
            smithy.api#paginated
            smithy.ruby#skipTests
            smithy.test#httpRequestTests
            smithy.test#httpResponseTests
            smithy.waiters#waitable
          ].freeze

          def initialize(service, id, shape)
            _, @service = service.first
            @id = id
            @name = (@service.dig('rename', @id) || Model::Shape.name(@id)).camelize
            @input = shape_name_from_id(shape['input']['target'])
            @output = shape_name_from_id(shape['output']['target'])
            @errors = build_errors(shape.fetch('errors', []))
            @traits = shape.fetch('traits', {})
          end

          attr_reader :id, :name, :input, :output, :errors

          def traits
            @traits.except(*OMITTED_TRAITS)
          end

          def paginated?
            @traits.key?('smithy.api#paginated')
          end

          def paginator
            "Paginators::#{@name}.new"
          end

          private

          def build_errors(errors)
            errors = Set.new(@service.fetch('errors', [])).merge(errors)
            errors.map { |error| MemberShape.new(@service, nil, error) }
          end
        end

        # @api private
        class Shape
          include SchemaHelper

          OMITTED_TRAITS = %w[
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
            @name = (@service.dig('rename', @id) || Model::Shape.name(@id)).camelize
          end

          attr_reader :type, :id, :name

          def initializer
            options_str = "id: \"#{@id}\", name: \"#{@name}\""
            options_str += ", traits: #{@traits}" unless @traits.empty?
            "::Smithy::Schema::Shapes::#{SHAPE_CLASS_MAP[@type]}.new(#{options_str})"
          end

          private

          def build_members(members)
            members.map { |name, member| MemberShape.new(@service, name, member) }
          end
        end

        # @api private
        class StructureShape < Shape
          OMITTED_TRAITS = %w[
            smithy.api#documentation
            smithy.api#input
            smithy.api#output
          ].freeze

          def initialize(service, id, shape)
            super
            @members = build_members(shape['members'])
            @traits = shape.fetch('traits', {}).except(*OMITTED_TRAITS)
          end

          attr_reader :members

          def type_class
            "Types::#{(@service.dig('rename', @id) || Model::Shape.name(@id)).camelize}"
          end

          def http_payload?
            @members.any?(&:http_payload?)
          end

          def http_payload
            @members.find(&:http_payload).http_payload
          end
        end

        # @api private
        class EnumShape < Shape
          def initialize(service, id, shape)
            super
            @members = build_members(shape['members'])
          end

          attr_reader :members
        end

        # @api private
        class IntEnumShape < Shape
          def initialize(service, id, shape)
            super
            @members = build_members(shape['members'])
          end

          attr_reader :members
        end

        # @api private
        class ListShape < Shape
          def initialize(service, id, shape)
            super
            @member = MemberShape.new(@service, nil, shape['member'])
          end

          attr_reader :member
        end

        # @api private
        class MapShape < Shape
          def initialize(service, id, shape)
            super
            @key = MemberShape.new(@service, nil, shape['key'])
            @value = MemberShape.new(@service, nil, shape['value'])
          end

          attr_reader :key, :value
        end

        # @api private
        class UnionShape < Shape
          def initialize(service, id, shape)
            super
            @members = build_members(shape['members'])
          end

          attr_reader :members

          def type_class
            "Types::#{(@service.dig('rename', @id) || Model::Shape.name(@id)).camelize}"
          end

          def union_type(shape_ref)
            "#{type_class}::#{shape_ref.location_name.camelize}"
          end
        end

        # @api private
        class MemberShape
          include SchemaHelper

          OMITTED_TRAITS = %w[
            smithy.api#documentation
          ].freeze

          def initialize(service, location_name, shape_ref)
            @service = service
            @name = location_name.underscore if location_name
            @location_name = location_name
            @target = shape_name_from_id(shape_ref['target'])
            @traits = shape_ref.fetch('traits', {}).except(*OMITTED_TRAITS)
          end

          attr_reader :name, :location_name

          def initializer
            options_str = "target: #{@target}"
            options_str += ", location_name: \"#{@location_name}\"" if @location_name
            options_str += ", traits: #{@traits}" unless @traits.empty?
            "::Smithy::Schema::Shapes::MemberShape.new(#{options_str})"
          end

          def http_payload?
            @traits.key?('smithy.api#httpPayload')
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
