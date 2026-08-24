# frozen_string_literal: true

require 'base64'
require 'time'

module Smithy
  module Schema
    module DocumentUtils
      # Serializes data into a document data.
      # @api private
      class Serializer
        include Shapes

        def initialize(options = {})
          @type_registry = options[:type_registry]
          @json = options[:json] || false
          @json_name = options[:json_name] || false
          @timestamp_format = options[:timestamp_format] || false
        end

        def format_document_data(shape, data)
          document_data = serialize_shape(shape, data)
          document_data['__type'] = shape.id
          document_data
        end

        def serialize_untyped(values)
          return if values.nil?

          case values
          when Time then values.utc.to_i # timestamp format is "epoch-seconds" by default
          when Hash
            values.each_with_object({}) do |(k, v), h|
              h[k.to_s] = serialize_untyped(v)
            end
          when Array then values.map { |d| serialize_untyped(d) }
          else values
          end
        end

        private

        def serialize_shape(shape, values) # rubocop:disable Metrics/CyclomaticComplexity
          case shape.target
          when BlobShape then blob(values)
          when DocumentShape then document(values)
          when FloatShape then float(values)
          when ListShape then list(shape, values)
          when MapShape then map(shape, values)
          when StructureShape then structure(shape, values)
          when TimestampShape then timestamp(shape, values)
          when UnionShape then union(shape, values)
          else values
          end
        end

        def blob(value)
          return value if @json # blob is already encoded

          Base64.strict_encode64(value.respond_to?(:read) ? value.read : value)
        end

        def document(values)
          shape = document_shape(values)
          return values unless shape

          format_document_data(shape, values)
        end

        def document_shape(values)
          case values
          when Structure
            @type_registry.shape_by_type(values.class)
          when Hash
            @type_registry[values['__type']]
          end
        end

        def float(value)
          if value == ::Float::INFINITY
            'Infinity'
          elsif value == -::Float::INFINITY
            '-Infinity'
          elsif value.to_f.nan?
            'NaN'
          else
            value.to_f
          end
        end

        def list(shape, values)
          return if values.nil?

          member = shape.target.member
          values.collect do |value|
            serialize_shape(member, value)
          end
        end

        def map(shape, values)
          return if values.nil?

          value_shape = shape.target.value
          values.each.with_object({}) do |(key, value), data|
            data[key.to_s] = serialize_shape(value_shape, value)
          end
        end

        def structure(shape, values)
          return if values.nil?

          shape.target.members.each_with_object({}) do |(member_name, member_shape), data|
            value = resolve_value(member_name, member_shape, values.to_h)
            data[wire_name(member_shape)] = serialize_shape(member_shape, value) unless value.nil?
          end
        end

        def timestamp(shape, value)
          value = normalize_timestamp_value(value)
          return value.to_i unless @timestamp_format

          trait = 'smithy.api#timestampFormat'
          case shape.traits[trait] || shape.target.traits[trait]
          when 'date-time' then value.utc.iso8601
          when 'http-date' then value.utc.httpdate
          else
            # default to epoch-seconds
            value.to_i
          end
        end

        def union(shape, values)
          return if values.nil?

          data = {}
          if values.is_a?(Union)
            _name, member_shape = shape.target.member_by_type(values.class)
            data[wire_name(member_shape)] = serialize_shape(member_shape, values)
          else
            key, value = values.first
            if (member_shape = resolve_member_shape(shape, key))
              data[wire_name(member_shape)] = serialize_shape(member_shape, value)
            end
          end
          data
        end

        def wire_name(member_shape)
          return member_shape.name unless @json_name

          member_shape.traits['smithy.api#jsonName'] || member_shape.name
        end

        def normalize_timestamp_value(value)
          case value
          when Time then value
          when Numeric then Time.at(value)
          else Time.parse(value)
          end
        end

        def resolve_member_shape(shape, name)
          return shape.target.member(name) if shape.target.member?(name)

          shape.target.members.values.find do |member_shape|
            member_shape.traits['smithy.api#jsonName'] == name || member_shape.name == name
          end
        end

        def resolve_value(member_name, member_shape, values)
          if (json_name = member_shape.traits['smithy.api#jsonName'])
            value = values[json_name]
            return value unless value.nil?
          end
          values[member_name] || values[member_shape.name]
        end
      end
    end
  end
end
