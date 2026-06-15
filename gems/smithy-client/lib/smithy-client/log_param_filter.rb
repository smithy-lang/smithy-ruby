# frozen_string_literal: true

module Smithy
  module Client
    # @api private
    class LogParamFilter
      include Schema::Shapes

      def initialize(options = {})
        @filter_sensitive_params = options.fetch(:filter_sensitive_params, true)
      end

      def filter(shape, values)
        case shape.target
        when ListShape then list(shape, values)
        when MapShape then map(shape, values)
        when StructureShape then structure(shape, values)
        when UnionShape then union(shape, values)
        else scalar(shape, values)
        end
      end

      private

      def list(shape, values)
        target = shape.target
        return '[FILTERED]' if sensitive?(target)

        member = target.member
        values.collect { |value| filter(member, value) }
      end

      def map(shape, values)
        target = shape.target
        return '[FILTERED]' if sensitive?(target)

        filtered = {}
        value_shape = target.value
        values.each_pair do |key, value|
          filtered[key] = filter(value_shape, value)
        end
        filtered
      end

      def scalar(shape, value)
        return '[FILTERED]' if sensitive?(shape.target)

        value
      end

      def structure(shape, values)
        target = shape.target
        return '[FILTERED]' if sensitive?(target)

        filtered = {}
        values.each_pair do |key, value|
          next unless target.member?(key)

          member_shape = target.member(key)
          filtered[key] = filter(member_shape, value)
        end
        filtered
      end

      def union(shape, values)
        target = shape.target
        return '[FILTERED]' if sensitive?(target)

        filtered = {}
        if values.is_a?(Schema::Union)
          name, member_shape = target.member_by_type(values.class)
          filtered[name] = filter(member_shape, values.value)
        else
          key, value = values.first
          if target.member?(key)
            member_shape = target.member(key)
            filtered[key] = filter(member_shape, value)
          end
        end
        filtered
      end

      def sensitive?(shape)
        @filter_sensitive_params && shape.traits.key?('smithy.api#sensitive')
      end
    end
  end
end
