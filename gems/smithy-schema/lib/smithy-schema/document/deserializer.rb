# frozen_string_literal: true

module Smithy
  module Schema
    module Document
      # TODO
      class Deserializer
        def initialize(type_registry)
          @type_registry = type_registry
        end

        # TODO.........
        def deserialize(document, shape: nil)
          # TODO
        end

        private

        def valid_shape?(shape)
          shape.is_a?(Shapes::StructureShape) && !shape.type.nil?
        end

        # Apply data into a given runtime shape
        def parse(ref, value, type) # rubocop:disable Metrics/CyclomaticComplexity
          case ref.shape
          when Shapes::StructureShape then structure(ref, value, type)
          when Shapes::UnionShape then union(ref, value, type)
          when Shapes::ListShape then list(ref, value, type)
          when Shapes::MapShape then map(ref, value, type)
          when Shapes::TimestampShape then timestamp(ref, value, type)
          when Shapes::DocumentShape then document(ref, value, type)
          when Shapes::BlobShape then Base64.strict_decode64(value)
          else data
          end
        end

        def document(ref, value, type = nil)
          # TODO
        end

        def list(ref, value, type = nil)
          # TODO
        end

        def map(ref, values, type = nil)
          # TODO
        end

        def structure(ref, values, type = nil)
          # TODO
        end

        def timestamp(ref, values, type = nil)
          # TODO
        end

        def union(ref, values, type = nil)
          # TODO
        end
      end
    end
  end
end
