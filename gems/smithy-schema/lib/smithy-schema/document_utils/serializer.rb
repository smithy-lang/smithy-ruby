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
          @json = options[:json] || false
          @json_name = options[:json_name] || false
          @timestamp_format = options[:timestamp_format] || false
          @type_registry = options[:type_registry]
        end

        def format_document_data(shape, data)
          document_data = shape(ShapeRef.new(shape: shape), data)
          document_data['__type'] = shape.id
          document_data
        end

        def serialize_untyped(values)
          return if values.nil?

          case values
          when Time
            values.to_i # timestamp format is "epoch-seconds" by default
          when Hash
            values.each_with_object({}) do |(k, v), h|
              h[k.to_s] = serialize_untyped(v)
            end
          when Array
            values.map { |d| serialize_untyped(d) }
          else
            values
          end
        end

        private

        def shape(ref, values) # rubocop:disable Metrics/CyclomaticComplexity
          return if values.nil?

          case ref.shape
          when BlobShape      then blob(values)
          when DocumentShape  then document(values)
          when FloatShape     then float(values)
          when ListShape      then list(ref, values)
          when MapShape       then map(ref, values)
          when StructureShape then structure(ref, values)
          when TimestampShape then timestamp(ref, values)
          when UnionShape     then union(ref, values)
          else values
          end
        end

        def blob(value)
          return value if @json # blob is already encoded

          Base64.strict_encode64(value.is_a?(String) ? value : value.read)
        end

        def document(values)
          return values unless (shape = document_shape(values))

          format_document_data(shape, values)
        end

        def document_shape(values)
          case values
          when Smithy::Schema::Structure
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

        def list(ref, values)
          values.collect do |value|
            next if value.nil?

            shape(ref.shape.member, value)
          end
        end

        def map(ref, values)
          values.each.with_object({}) do |(key, value), data|
            next if value.nil?

            data[key.to_s] = shape(ref.shape.value, value)
          end
        end

        def structure(ref, values)
          ref.shape.members.each_with_object({}) do |(member_name, member_ref), data|
            value = resolve_value(member_name, member_ref, values.to_h)
            data[location_name(member_ref)] = shape(member_ref, value) unless value.nil?
          end
        end

        def timestamp(ref, value)
          value = normalize_timestamp_value(value)
          return value.to_i unless @timestamp_format

          trait = 'smithy.api#timestampFormat'
          case ref.traits[trait] || ref.shape.traits[trait]
          when 'date-time' then value.utc.iso8601
          when 'http-date' then value.utc.httpdate
          else
            # default to epoch-seconds
            value.to_i
          end
        end

        def union(ref, values)
          data = {}
          if values.is_a?(Smithy::Schema::Union)
            _name, member_ref = ref.shape.member_by_type(values.class)
            data[location_name(member_ref)] = shape(member_ref, values)
          else
            key, value = values.first
            if (member_ref = resolve_member_ref(ref, key))
              data[location_name(member_ref)] = shape(member_ref, value)
            end
          end
          data
        end

        def location_name(ref)
          return ref.member_name unless @json_name

          ref.traits['smithy.api#jsonName'] || ref.member_name
        end

        def normalize_timestamp_value(value)
          case value
          when Time then value
          when Numeric then Time.at(value)
          else Time.parse(value)
          end
        end

        def resolve_member_ref(ref, name)
          return ref.shape.member(name) if ref.shape.member?(name)

          ref.shape.members.values.find do |r|
            r.traits['smithy.api#jsonName'] == name || r.member_name == name
          end
        end

        def resolve_value(member_name, member_ref, values)
          if (json_name = member_ref.traits['smithy.api#jsonName'])
            value = values[json_name]
            return value unless value.nil?
          end
          values[member_name] || values[member_ref.member_name]
        end
      end
    end
  end
end
