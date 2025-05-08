# frozen_string_literal: true

require 'base64'
require 'time'

module Smithy
  module Schema
    module Document
      # Serializes data into a document data.
      class Serializer
        include Shapes

        # @param [TypeRegistry] type_registry Used to find shape based on
        #  on document discriminator.
        def initialize(type_registry)
          @type_registry = type_registry
        end

        # Create document data from various input data formats
        # @param [Object] data Input data can be: Ruby objects, instance of a runtime shape or a
        #  JSON response with type discriminator.
        # @return [Data] document data
        #
        # @example Ruby objects as input
        #   # create serializer with an existing type registry
        #   serializer = Smithy::Schema::Document::Serializer(type_registry)
        #
        #   # ruby objects as input
        #   serializer.create_document("some document")
        #   # => {"foo" => "bar"}
        # @example Runtime shape as input
        #   # create serializer with an existing type registry
        #   serializer = Smithy::Schema::Document::Serializer(type_registry)
        #
        #   # given the following runtime shape
        #   runtime_shape = some_structure.new.type(some_data)
        #   # => #<struct SampleService::Types::Structure...>
        #
        #   serializer.create_document(runtime_shape)
        #   # => an instance of Smithy::Schema::Document::Data
        # @example JSON data
        #   # create serializer with an existing type registry
        #   serializer = Smithy::Schema::Document::Serializer(type_registry)
        #
        #   # given the following json data
        #   parsed_json = {
        #     "__type" => "smithy.ruby.tests#Structure",
        #     "string" => "hello"
        #   }
        #
        #   document = serializer.create_document(parsed_json)
        #   # => an instance of Smithy::Schema::Document::Data
        #   document.discriminator
        #   # => "smithy.ruby.tests#Structure"
        def create_document(data)
          validate_data(data)

          case data
          when Smithy::Schema::Structure
            shape = @type_registry.shape_by_type(data.class)
            Data.new(format_document_data(shape, data), discriminator: shape.id)
          else
            if discriminator?(data)
              shape = @type_registry[data['__type']]
              Data.new(format_document_data(shape, data, discriminator: true), discriminator: shape.id)
            else
              Data.new(serialize_untyped(data))
            end
          end
        end

        # Serializes a document data with optional formatting.
        # @param [Data] document The document to serialize
        # @param [Hash] opts serialization options
        # @option opts [Boolean] :use_timestamp_format Whether to use the
        #  `timestampFormat` trait or ignore it. The `timestampFormat` trait
        #   is ignored by default.
        # @option opts [Boolean] :use_json_name Whether to use `jsonName` trait
        #   or just member name. The `jsonName` trait is ignored by default.
        # @return [Hash] Serialized document data
        def serialize_document(document, opts = {})
          validate_document(document)

          opts[:discriminator] = true
          format_document_data(resolve_shape(document), document.data, opts)
        end

        private

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

        def shape(ref, values, opts = {}) # rubocop:disable Metrics/CyclomaticComplexity
          return if values.nil?

          case ref.shape
          when BlobShape      then blob(values, opts)
          when DocumentShape  then document(values, opts)
          when FloatShape     then float(values, opts)
          when ListShape      then list(ref, values, opts)
          when MapShape       then map(ref, values, opts)
          when StructureShape then structure(ref, values, opts)
          when TimestampShape then timestamp(ref, values, opts)
          when UnionShape     then union(ref, values, opts)
          else values
          end
        end

        def blob(value, opts)
          return value if opts[:discriminator] # blob is already encoded

          Base64.strict_encode64(value.is_a?(String) ? value : value.read)
        end

        def document(values, opts)
          return values unless typed_document?(values)

          shape =
            if values.is_a?(Smithy::Schema::Structure)
              @type_registry.shape_by_type(values.class)
            else
              @type_registry[values['__type']]
            end
          format_document_data(shape, values, opts)
        end

        def typed_document?(values)
          (values.is_a?(Smithy::Schema::Structure) && @type_registry.shape_by_type(values.class)) ||
            (values.is_a?(Hash) && values.key?('__type'))
        end

        def float(value, _opts)
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

        def list(ref, values, opts)
          values.collect do |value|
            next if value.nil?

            shape(ref.shape.member, value, opts)
          end
        end

        def map(ref, values, opts)
          values.each.with_object({}) do |(key, value), data|
            next if value.nil?

            data[key.to_s] = shape(ref.shape.value, value, opts)
          end
        end

        def structure(ref, values, opts)
          values.each_pair.with_object({}) do |(k, v), h|
            next if v.nil?

            if (member_ref = resolve_member_ref(ref, k))
              member_name = resolve_member_name(member_ref, opts)
              h[member_name] = shape(member_ref, v, opts)
            end
          end
        end

        def timestamp(ref, value, opts)
          value = normalize_timestamp_value(value)
          return value.to_i unless opts[:use_timestamp_format]

          trait = 'smithy.api#timestampFormat'
          case ref.traits[trait] || ref.shape.traits[trait]
          when 'date-time' then value.utc.iso8601
          when 'http-date' then value.utc.httpdate
          else
            # default to epoch-seconds
            value.to_i
          end
        end

        def union(ref, values, opts)
          data = {}
          if values.is_a?(Smithy::Schema::Union)
            member_ref = ref.shape.member_by_type(values.class)
            member_name = resolve_member_name(member_ref, opts)
            data[member_name] = shape(member_ref, values, opts)
          else
            key, value = values.first
            if (member_ref = resolve_member_ref(ref, key))
              member_name = resolve_member_name(member_ref, opts)
              data[member_name] = shape(member_ref, value, opts)
            end
          end
          data
        end

        def format_document_data(shape, data, opts = {})
          ref = ShapeRef.new(shape: shape)
          document_data = shape(ref, data, opts)
          document_data['__type'] = shape.id
          document_data
        end

        def discriminator?(data)
          data.is_a?(Hash) && data.key?('__type')
        end

        def normalize_timestamp_value(value)
          case value
          when Time then value
          when Numeric then Time.at(value)
          else Time.parse(value)
          end
        end

        def resolve_member_ref(ref, name)
          ref.shape.member(name) || find_member_ref_by_names(ref, name)
        end

        def find_member_ref_by_names(ref, name)
          ref.shape.members.values.find do |r|
            r.traits['smithy.api#jsonName'] == name || r.member_name == name
          end
        end

        def resolve_member_name(member_ref, opts)
          json_trait = 'smithy.api#jsonName'
          if opts[:use_json_name] && member_ref.traits[json_trait]
            member_ref.traits[json_trait]
          else
            member_ref.member_name
          end
        end

        def resolve_shape(document)
          msg = 'document discriminator not found in type registry'
          raise ArgumentError, msg unless @type_registry.key?(document.discriminator)

          @type_registry[document.discriminator]
        end

        def validate_data(data)
          raise ArgumentError, 'invalid data - data cannot be nil' if data.nil?

          case data
          when Schema::Structure
            msg = 'given runtime shape not found in type registry'
            raise ArgumentError, msg unless @type_registry.shape_by_type?(data.class)
          else
            msg = 'document discriminator not found in type registry'
            raise ArgumentError, msg if discriminator?(data) && !@type_registry.key?(data['__type'])
          end
        end

        def validate_document(document)
          msg = 'document must be an instance of `Document::Data` class'
          raise ArgumentError, msg unless document.is_a?(Data)

          msg = 'invalid document - must have a discriminator'
          raise ArgumentError, msg unless document.discriminator
        end
      end
    end
  end
end
