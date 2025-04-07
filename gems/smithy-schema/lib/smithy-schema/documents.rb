# frozen_string_literal: true

module Smithy
  module Schema
    module Documents
      # Contains methods to extract given data as document data
      module Extractor
        class << self
          def extract(schema, data)
            return nil if data.nil?

            case schema
            when Shapes::StructureShape then extract_structure(schema, data)
            when Shapes::UnionShape     then extract_union(schema, data)
            when Shapes::ListShape      then extract_list(schema, data)
            when Shapes::MapShape       then extract_map(schema, data)
            else data
            end
          end

          def extract_structure(schema, data)
            data.to_h.each_with_object({}) do |(k, v), o|
              next unless schema.member?(k)

              o[k] = extract(schema.member(k).shape, v)
            end
          end

          def extract_union(schema, data)
            output = {}
            if data.is_a?(Schema::Union)
              member_shape = schema.member_by_type(data.class)
              output[member_shape.name] = extract(member_shape.shape, data).value
            else
              key, value = data.first
              if schema.member?(key)
                member_shape = schema.member(key)
                output[member_shape.name] = extract(member_shape.shape, value)
              end
            end
            output
          end

          def extract_list(schema, data)
            data.collect { |v| extract(schema.member.shape, v) }
          end

          def extract_map(schema, data)
            data.each.with_object({}) do |(k, v), h|
              h[k] = extract(schema.value.shape, v)
            end
          end

          def discriminator(data, schema)
            return if data.nil?

            if discriminator?(data)
              data['__type']
            elsif schema
              unless schema.is_a?(Shapes::StructureShape)
                raise "Expected a structure schema, given #{schema.class} instead"
              end

              schema.id
            end
          end

          def discriminator?(data)
            data.is_a?(Hash) && data.key?('__type')
          end
        end
      end

      # Contains methods to apply document data to runtime shapes
      module Applier
        class << self
          def apply(schema, data, type = nil)
            case schema
            when Shapes::StructureShape then apply_structure(schema, data, type)
            when Shapes::UnionShape then apply_union(schema, data, type)
            when Shapes::ListShape then apply_list(schema, data)
            when Shapes::MapShape then apply_map(schema, data)
            else data
            end
          end

          def apply_structure(schema, data, type)
            type = schema.type.new if type.nil?
            data.each do |k, v|
              next if (name = resolve_member_name(schema, k)).nil?

              type[name] = apply(schema.member(name).shape, v)
            end
            type
          end

          def apply_union(schema, data, type)
            key, value = data.flatten
            return if key.nil?

            if schema.name_by_member_name?(key)
              member_name = schema.name_by_member_name(key)
              type = schema.member_type(member_name) if type.nil?
              type.new(apply(schema.member(member_name).shape, value))
            else
              schema.member_type(:unknown).new(key, value)
            end
          end

          def apply_list(schema, data)
            data.map do |v|
              next if v.nil?

              apply(schema.member.shape, v)
            end
          end

          def apply_map(schema, data)
            data.transform_values do |v|
              if v.nil?
                nil
              else
                apply(schema.value.shape, v)
              end
            end
          end

          private

          def resolve_member_name(schema, key)
            return unless schema.name_by_member_name?(key) || schema.member?(key.to_sym)

            schema.name_by_member_name(key) || key.to_sym
          end
        end
      end
    end
  end
end
