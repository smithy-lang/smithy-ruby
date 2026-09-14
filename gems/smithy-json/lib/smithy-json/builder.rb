# frozen_string_literal: true

require 'base64'

module Smithy
  module Json
    # @api private
    class Builder
      def initialize(options = {})
        @json_name = options[:json_name] || false
        @default_timestamp = options.fetch(:default_timestamp, 'epoch-seconds')
      end

      def build(shape, data)
        Smithy::Json.dump(build_shape(shape, data))
      end

      private

      def build_shape(shape, value) # rubocop:disable Metrics/CyclomaticComplexity
        case Schema::Extension.target_shape(shape)
        when Schema::Extension::SHAPE_BLOB then blob(value)
        when Schema::Extension::SHAPE_FLOAT then float(value)
        when Schema::Extension::SHAPE_LIST then list(shape, value)
        when Schema::Extension::SHAPE_MAP then map(shape, value)
        when Schema::Extension::SHAPE_STRUCTURE then structure(shape, value)
        when Schema::Extension::SHAPE_TIMESTAMP then timestamp(shape, value)
        when Schema::Extension::SHAPE_UNION then union(shape, value)
        else value
        end
      end

      def blob(value)
        Base64.strict_encode64(value.respond_to?(:read) ? value.read : value)
      end

      def float(value)
        if value == ::Float::INFINITY
          'Infinity'
        elsif value == -::Float::INFINITY
          '-Infinity'
        elsif value.nan?
          'NaN'
        else
          value
        end
      end

      def list(shape, values)
        return if values.nil?

        member, _target_shape, _sparse = Schema::Extension.list_member(shape.target)
        values.collect do |value|
          build_shape(member, value)
        end
      end

      def map(shape, values)
        return if values.nil?

        value_member, _target_shape, _sparse = Schema::Extension.map_value_member(shape.target)
        values.each.with_object({}) do |(key, value), data|
          data[key] = build_shape(value_member, value)
        end
      end

      def structure(shape, values)
        return if values.nil?

        index = member_index(shape.target)
        values.each_pair.with_object({}) do |(member_name, value), data|
          next if value.nil?
          next unless (entry = index[member_name])

          wire_name, member_shape, _target_shape = entry
          data[wire_name] = build_shape(member_shape, value)
        end
      end

      def timestamp(shape, value)
        format = Extension.timestamp_format(shape)
        format = @default_timestamp if format == :default

        case format
        when 'date-time' then value.utc.iso8601
        when 'http-date' then value.utc.httpdate
        when 'epoch-seconds' then value.to_i
        else
          raise ArgumentError, "unsupported JSON timestamp format: #{format.inspect}"
        end
      end

      def union(shape, values)
        return if values.nil?

        key, value =
          if values.is_a?(Schema::Union)
            [values.member, values.value]
          else
            values.first
          end
        entry = member_index(shape.target)[key]
        return {} unless entry

        wire_name, member_shape, _target_shape = entry
        { wire_name => build_shape(member_shape, value) }
      end

      def member_index(shape)
        if @json_name
          Extension.member_index(shape)
        else
          Schema::Extension.member_index(shape)
        end
      end
    end
  end
end
