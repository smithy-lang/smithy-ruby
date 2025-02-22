# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      module ShapeToHash
        class << self
          def transform_value(model, value, shape)
            return value unless shape && value

            case shape['type']
            when 'structure', 'union'
              transform_structure(model, shape, value)
            when 'list'
              transform_list(model, shape, value)
            when 'map'
              transform_map(model, shape, value)
            when 'float', 'double'
              transform_float(value, shape)
            when 'timestamp'
              transform_timestamp(value)
            else
              value
            end
          end

          private

          def transform_map(model, shape, value)
            member_shape = Model.shape(model, shape['value']['target'])
            value.transform_values do |v|
              transform_value(model, v, member_shape)
            end
          end

          def transform_list(model, shape, value)
            member_shape = Model.shape(model, shape['member']['target'])
            value.map { |v| transform_value(model, v, member_shape) }
          end

          def transform_structure(model, shape, value)
            value.each_with_object({}) do |(k, v), o|
              member_shape = Model.shape(model, shape['members'][k]['target'])
              o[k.underscore.to_sym] = transform_value(model, v, member_shape)
            end
          end

          def transform_timestamp(value)
            return value if nil?

            CodegenValue.new(value, :timestamp)
          end

          def transform_float(value, _shape)
            case value
            when 'Infinity' then CodegenValue.new(Float::INFINITY, :float)
            when '-Infinity' then CodegenValue.new(-Float::INFINITY, :float)
            when 'NaN' then CodegenValue.new(Float::NAN, :float)
            else
              value
            end
          end
        end

        class CodegenValue
          def initialize(value, shape)
            @value = value
            @shape = shape
          end

          def inspect
            case @shape
            when :float then inspect_float
            when :timestamp then inspect_timestamp
            else @value.inspect
            end
          end

          private

          def inspect_timestamp
            if @value.is_a?(String)
              "Time.parse(#{@value})"
            else
              "Time.at(#{@value})"
            end
          end

          def inspect_float
            if @value.nan?
              'Float::NAN'
            elsif @value.infinite?
              "#{'-' if @value.negative?}Float::INFINITY"
            else
              @value.inspect
            end
          end
        end
      end
    end
  end
end
