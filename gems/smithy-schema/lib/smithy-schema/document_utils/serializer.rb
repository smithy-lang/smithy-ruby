# frozen_string_literal: true

require 'base64'
require 'time'

module Smithy
  module Schema
    module DocumentUtils
      # Serializes data into a document data.
      class Serializer
        include Shapes

        # @param options [Hash] Serializer options
        def initialize(options = {})
          @type_registry = options[:type_registry]
          @discriminator = options[:discriminator]
          @json_name = options[:json_name] || false
          @timestamp_format = options[:timestamp_format] || false
        end

        def format_document_data(shape, data)
          ref = ShapeRef.new(shape: shape)
          document_data = shape(ref, data)
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
          return value if @discriminator # blob is already encoded

          Base64.strict_encode64(value.is_a?(String) ? value : value.read)
        end

        def document(values)
          return values unless (shape = registered_document(values))

          format_document_data(shape, values)
        end

        def registered_document(values)
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
            next if value.nil? && !sparse?(ref.shape)

            shape(ref.shape.member, value)
          end
        end

        def map(ref, values)
          values.each.with_object({}) do |(key, value), data|
            next if value.nil? && !sparse?(ref.shape)

            data[key.to_s] = shape(ref.shape.value, value)
          end
        end

        def structure(ref, values)
          ref.shape.members.each_with_object({}) do |(member_name, member_ref), data|
            value = resolve_value(member_name, member_ref, values.to_h)
            data[location_name(member_ref)] = shape(member_ref, value) unless value.nil?
          end
        end

        def resolve_value(member_name, member_ref, values)
          if (json_name = member_ref.traits['smithy.api#jsonName'])
            value = values[json_name]
            return value unless value.nil?
          end
          values[member_name] || values[member_ref.member_name]
        end

        def resolve_member_name(member_ref, opts)
          json_trait = 'smithy.api#jsonName'
          if opts[:use_json_name] && member_ref.traits[json_trait]
            member_ref.traits[json_trait]
          else
            member_ref.member_name
          end
        end

        def location_name(ref)
          return ref.member_name unless @json_name

          # i think i need to check for traits first

          ref.traits['smithy.api#jsonName'] || ref.member_name
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
            member_ref = ref.shape.member_by_type(values.class)
            data[location_name(member_ref)] = shape(member_ref, values)
          else
            key, value = values.first
            if (member_ref = resolve_member_ref(ref, key))
              data[location_name(member_ref)] = shape(member_ref, value)
            end
          end
          data
        end

        def resolve_member_ref(ref, name)
          return ref.shape.member(name) if ref.shape.member?(name)

          ref.shape.members.values.find do |r|
            r.traits['smithy.api#jsonName'] == name || r.member_name == name
          end
        end

        def normalize_timestamp_value(value)
          case value
          when Time then value
          when Numeric then Time.at(value)
          else Time.parse(value)
          end
        end

        def sparse?(shape)
          shape.traits.include?('smithy.api#sparse')
        end
      end
    end
  end
end
