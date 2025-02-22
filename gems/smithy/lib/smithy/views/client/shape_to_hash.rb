# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      module ShapeToHash
        class << self
          def transform_value(model, value, shape)
            return value if value.nil?

            case shape['type']
            when 'structure', 'union' then structure(model, shape, value)
            when 'list' then list(model, shape, value)
            when 'map' then map(model, shape, value)
            when 'float', 'double' then float(value, shape)
            when 'timestamp' then timestamp(value)
            else
              value
            end
          end

          private

          def map(model, shape, value)
            member_shape = Model.shape(model, shape['value']['target'])
            value.transform_values do |v|
              transform_value(model, v, member_shape)
            end
          end

          def list(model, shape, value)
            member_shape = Model.shape(model, shape['member']['target'])
            value.map { |v| transform_value(model, v, member_shape) }
          end

          def structure(model, shape, value)
            value.each_with_object({}) do |(k, v), o|
              member_shape = Model.shape(model, shape['members'][k]['target'])
              o[k.underscore.to_sym] = transform_value(model, v, member_shape)
            end
          end

          def timestamp(value)
            return value if nil?

            CodegenValue.new(value, :timestamp)
          end

          def float(value, _shape)
            case value
            when 'Infinity' then CodegenValue.new(Float::INFINITY, :float)
            when '-Infinity' then CodegenValue.new(-Float::INFINITY, :float)
            when 'NaN' then CodegenValue.new(Float::NAN, :float)
            else
              value
            end
          end
        end

        # @api private
        class CodegenValue
          def initialize(value, shape)
            @value = value
            @shape = shape
          end

          def inspect
            case @shape
            when :float then float
            when :timestamp then timestamp
            else @value.inspect
            end
          end

          private

          def timestamp
            if @value.is_a?(String)
              "Time.parse(#{@value})"
            else
              "Time.at(#{@value})"
            end
          end

          def float
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
