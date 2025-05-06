# frozen_string_literal: true

require 'base64'
require 'time'

module Smithy
  module Schema
    module Document
      # TODO
      class Serializer
        def initialize(type_registry)
          @type_registry = type_registry
        end

        # data can come in several forms
        # - ruby objects w/o attachments with schema
        # - instance of runtime shape (requires shape to properly serialize)
        # - json response that includes discriminator (requires shape to properly serialize)
        def create_document(data)
          raise ArgumentError, 'Unable to create Document' if data.nil?

          case data
          when Smithy::Schema::Structure # runtime shape
            msg = 'Given runtime shape not found in type registry'
            raise ArgumentError, msg unless @type_registry.shape_by_type?(data.class)

            shape = @type_registry.shape_by_type(data.class)
            ref = Smithy::Schema::Shapes::ShapeRef.new(shape: shape)
            new_data = build(ref, data)
            new_data['__type'] = shape.id
            Data.new(new_data, discriminator: shape.id)
          else
            # shape is typed
            if discriminator?(data)
              msg = 'Given discriminator not found in type registry'
              raise ArgumentError, msg unless @type_registry.key?(data['__type'])

              discriminator = data['__type']
              shape = @type_registry[discriminator]
              ref = Smithy::Schema::Shapes::ShapeRef.new(shape: shape)
              new_data = build(ref, data)
              new_data['__type'] = shape.id
              Data.new(new_data, discriminator: shape.id)
            else
              Data.new(build_untyped(data))
            end
          end
        end

        def serialize_document(document, opts = {})
          error_message = 'Invalid Document - must be a typed document'
          raise ArgumentError, error_message unless document.is_a?(Data) && document.discriminator

          opts[:discriminator] = true
          shape = @type_registry[document.discriminator]
          ref = Smithy::Schema::Shapes::ShapeRef.new(shape: shape)
          new_data = build(ref, document.data, opts)
          new_data['__type'] = shape.id
          new_data
        end

        private

        def discriminator?(data)
          data.is_a?(Hash) && data.key?('__type')
        end

        # Takes untyped ruby data into document-friendly format
        def build_untyped(values)
          return if values.nil?

          case values
          when Time
            values.to_i # timestamp format is "epoch-seconds" by default
          when Hash
            values.each_with_object({}) do |(k, v), h|
              h[k.to_s] = build_untyped(v)
            end
          when Array
            values.map { |d| build_untyped(d) }
          else
            values
          end
        end

        # Construct data into a document-friendly format using a shape
        def build(ref, values, opts = {}) # rubocop:disable Metrics/CyclomaticComplexity
          return if values.nil?

          case ref.shape
          when Shapes::StructureShape then structure(ref, values, opts)
          when Shapes::UnionShape     then union(ref, values, opts)
          when Shapes::ListShape      then list(ref, values, opts)
          when Shapes::MapShape       then map(ref, values, opts)
          when Shapes::BlobShape      then blob(values, opts)
          when Shapes::FloatShape     then float(values, opts)
          when Shapes::TimestampShape then timestamp(ref, values, opts)
          when Shapes::DocumentShape  then document(values, opts)
          else values
          end
        end

        def structure(ref, values, opts)
          values.each_pair.with_object({}) do |(k, v), h|
            next if v.nil?

            member_ref = ref.shape.member(k) || member_by_location_name(ref.shape, k)
            next if member_ref.nil?

            member_name =
              if opts[:use_json_name] && member_ref.traits['smithy.api#jsonName']
                member_ref.traits['smithy.api#jsonName']
              else
                member_ref.location_name
              end
            h[member_name] = build(member_ref, v, opts)
          end
        end

        def member_by_location_name(shape, name)
          shape.members.values.find { |ref| ref.location_name == name }
        end

        def union(ref, values, opts)
          data = {}
          if values.is_a?(Smithy::Schema::Union)
            member_ref = ref.shape.member_by_type(values.class)
            member_name =
              if opts[:use_json_name] && member_ref.traits['smithy.api#jsonName']
                member_ref.traits['smithy.api#jsonName']
              else
                member_ref.location_name
              end
            data[member_name] = build(member_ref, values, opts)
          else
            key, value = values.first
            member_ref = ref.shape.member(key) || member_by_location_name(ref.shape, key)
            unless member_ref.nil?
              member_name =
                if opts[:use_json_name] && member_ref.traits['smithy.api#jsonName']
                  member_ref.traits['smithy.api#jsonName']
                else
                  member_ref.location_name
                end
              data[member_name] = build(member_ref, value, opts)
            end
          end
          data
        end

        def list(ref, values, opts)
          values.collect do |value|
            next if value.nil?

            build(ref.shape.member, value, opts)
          end
        end

        def map(ref, values, opts)
          values.each.with_object({}) do |(key, value), data|
            next if value.nil?

            data[key.to_s] = build(ref.shape.value, value, opts)
          end
        end

        def blob(value, opts)
          return value if opts[:discriminator] # blob is already encoded

          Base64.strict_encode64(value.is_a?(String) ? value : value.read)
        end

        def timestamp(ref, value, opts)
          return value.to_i unless opts[:use_timestamp_format]

          trait = 'smithy.api#timestampFormat'
          value = value.is_a?(Numeric) ? Time.at(value) : Time.parse(value) unless value.is_a?(Time)
          case ref.traits[trait] || ref.shape.traits[trait]
          when 'date-time' then value.utc.iso8601
          when 'http-date' then value.utc.httpdate
          else
            # default to epoch-seconds
            value.to_i
          end
        end

        def float(value, _opts)
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

        def document(values, opts)
          if values.is_a?(Smithy::Schema::Structure)
            shape = @type_registry.shape_by_type(values.class)
            shape_ref = Smithy::Schema::Shapes::ShapeRef.new(shape: shape)
            data = build(shape_ref, values, opts)
            data['__type'] = shape.id
            data
          else
            values
          end
        end
      end
    end
  end
end
