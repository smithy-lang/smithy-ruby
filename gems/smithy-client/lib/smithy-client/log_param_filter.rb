# frozen_string_literal: true

module Smithy
  module Client
    # @api private
    class LogParamFilter
      include Schema::Shapes

      def initialize(options = {})
        @filter_sensitive_params = options.fetch(:filter_sensitive_params, true)
      end

      def filter(ref, values)
        case ref.shape
        when ListShape then list(ref, values)
        when MapShape then map(ref, values)
        when StructureShape then structure(ref, values)
        when UnionShape then union(ref, values)
        else scalar(ref, values)
        end
      end

      private

      def list(ref, values)
        shape = ref.shape
        return '[FILTERED]' if sensitive?(shape)

        member_ref = shape.member
        values.collect { |value| filter(member_ref, value) }
      end

      def map(ref, values)
        shape = ref.shape
        return '[FILTERED]' if sensitive?(shape)

        filtered = {}
        value_ref = shape.value
        values.each_pair do |key, value|
          filtered[key] = filter(value_ref, value)
        end
        filtered
      end

      def scalar(ref, value)
        return '[FILTERED]' if sensitive?(ref.shape)

        value
      end

      def structure(ref, values)
        shape = ref.shape
        return '[FILTERED]' if sensitive?(shape)

        filtered = {}
        values.each_pair do |key, value|
          next unless shape.member?(key)

          member_ref = shape.member(key)
          filtered[key] = filter(member_ref, value)
        end
        filtered
      end

      def union(ref, values) # rubocop:disable Metrics/AbcSize
        shape = ref.shape
        return '[FILTERED]' if sensitive?(shape)

        filtered = {}
        if values.is_a?(Schema::Union)
          name, member_ref = ref.shape.member_by_type(values.class)
          filtered[name] = filter(member_ref, values.value)
        else
          key, value = values.first
          if ref.shape.member?(key)
            member_ref = ref.shape.member(key)
            filtered[key] = filter(member_ref, value)
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
