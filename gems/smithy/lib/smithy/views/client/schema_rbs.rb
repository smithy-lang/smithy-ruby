# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class SchemaRbs < View
        def initialize(plan)
          @plan = plan
          @service_index = Model::ServiceIndex.new(plan.model)
          super()
        end

        def module_name
          @plan.module_name
        end

        def shapes
          @service_index
            .shapes_for(@plan.service)
            .map { |id, shape| Shape.new(@plan.service, id, shape) }
        end

        def service_shape
          @service_shape ||= ServiceShape.new(@plan.service)
        end

        # @api private
        class ServiceShape
          def initialize(service)
            @id, = service.first
          end

          def name
            Model::Shape.name(@id).camelize
          end

          def shape_class
            'ServiceShape'
          end
        end

        # @api private
        class Shape
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
          end

          def name
            (@service.dig('rename', @id) || Model::Shape.name(@id)).camelize
          end

          def shape_class
            SHAPE_TYPES_MAP[@shape['type']]
          end
        end
      end
    end
  end
end
