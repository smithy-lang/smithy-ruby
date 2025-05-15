# frozen_string_literal: true

module Smithy
  module Schema
    module DocumentUtils
      # Deserializes document data into runtime shape.
      class Deserializer
        include Shapes

        # @param [TypeRegistry] type_registry required to find shape based
        #  on document discriminator.
        def initialize(type_registry, options = {})
          @json_name = options[:json_name] || false
          @type_registry = type_registry
        end

        # Deserializes a {Document} into a runtime shape.
        #
        # @param [Document] document The document to deserialize. Must have
        #  a discriminator that maps to a shape in the type registry.
        # @param [StructureShape, nil] shape Optional shape to use for
        #  deserialization. If provided, this shape takes precedence over the
        #  document's discriminator. The shape must have a type.
        # @return [Object] deserialized runtime shape
        #
        # @example Standard Example
        #   # create deserializer with an existing type registry
        #   deserializer = Smithy::Schema::DocumentUtils::Deserializer(type_registry)
        #
        #   deserializer.deserialize(document) # passing document data
        #   # => #<struct SampleService::Types::SampleShape....>
        # @example Providing a shape as input
        #   # using the existing discriminator above
        #   # given shape is a structure and has a type
        #   deserializer.deserialize(document, shape: some_structure)
        #   # => #<struct SampleService::Types::SomeStructure....>
        def deserialize(document, shape: nil)
          validate_input(document, shape)

          shape ||= resolve_shape(document)
          shape(ShapeRef.new(shape: shape), document, shape.type.new)
        end

        private

        def validate_input(document, shape)
          msg = 'document must be an instance of `Document` class'
          raise ArgumentError, msg unless document.is_a?(Document)

          if shape
            msg = 'invalid shape - must be a structure shape with type'
            raise ArgumentError, msg unless valid_shape(shape)
          else
            msg = 'invalid document - must have a discriminator'
            raise ArgumentError, msg unless document.discriminator
          end
        end

        def valid_shape(shape)
          shape.is_a?(StructureShape) && shape.type
        end

        def resolve_shape(document)
          msg = 'document discriminator not found in type registry'
          raise ArgumentError, msg unless @type_registry.key?(document.discriminator)

          @type_registry[document.discriminator]
        end

        def shape(ref, value, target = nil) # rubocop:disable Metrics/CyclomaticComplexity
          case ref.shape
          when BlobShape then Base64.strict_decode64(value)
          when FloatShape then float(value)
          when DocumentShape then document(value)
          when ListShape then list(ref, value, target)
          when MapShape then map(ref, value, target)
          when StructureShape then structure(ref, value, target)
          when TimestampShape then timestamp(value)
          when UnionShape then union(ref, value, target)
          else value
          end
        end

        def document(values)
          return values unless values.is_a?(Hash) && values.key?('__type')

          msg = 'invalid document - document discriminator not found in type registry'
          raise ArgumentError, msg unless @type_registry.key?(values['__type'])

          shape_ref = ShapeRef.new(shape: @type_registry[values['__type']])
          shape(shape_ref, values)
        end

        def float(value)
          case value
          when 'Infinity' then ::Float::INFINITY
          when '-Infinity' then -::Float::INFINITY
          when 'NaN' then ::Float::NAN
          when nil then nil
          else value.to_f
          end
        end

        def list(ref, values, target = nil)
          target = [] if target.nil?
          values.each do |value|
            next if value.nil? && !sparse?(ref.shape)

            target << shape(ref.shape.member, value)
          end
          target
        end

        def map(ref, values, target = nil)
          target = {} if target.nil?
          values.each do |key, value|
            next if value.nil? && !sparse?(ref.shape)

            target[key] = shape(ref.shape.value, value)
          end
          target
        end

        def structure(ref, values, target = nil)
          return if values.nil?

          target = ref.shape.type.new if target.nil?
          ref.shape.members.each do |member_name, member_ref|
            value = values[location_name(member_ref)]
            target[member_name] = shape(member_ref, value) unless value.nil?
          end
          target
        end

        def timestamp(value)
          case value
          when nil then nil
          when Numeric
            Time.at(value).utc
          when /^[\d.]+$/
            Time.at(value.to_f).utc
          else
            begin
              fractional_time = Time.parse(value).to_f
              Time.at(fractional_time).utc
            rescue ArgumentError
              raise "unhandled timestamp format `#{value}'"
            end
          end
        end

        def union(ref, values, target = nil)
          ref.shape.members.each do |member_name, member_ref|
            value = values[location_name(member_ref)]
            next if value.nil?

            target = ref.shape.member_type(member_name) if target.nil?
            return target.new(shape(member_ref, value))
          end
          values.delete('__type')
          key, value = values.first
          ref.shape.member_type(:unknown).new(key, value)
        end

        def location_name(ref)
          return ref.member_name unless @json_name

          ref.traits['smithy.api#jsonName'] || ref.member_name
        end

        def sparse?(shape)
          shape.traits.include?('smithy.api#sparse')
        end
      end
    end

  end
end
