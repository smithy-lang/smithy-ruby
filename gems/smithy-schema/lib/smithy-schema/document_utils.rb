# frozen_string_literal: true

require 'base64'
require 'time'

module Smithy
  module Schema
    # Document Utilities to help (de)construct given data as a document
    module DocumentUtils
      class << self
        # Used to transform untyped data
        def format(data)
          return if data.nil?

          case data
          when Time
            # timestamp format is "epoch-seconds" by default
            data.to_i
          when Hash
            data.transform_values { |v| format(v) }
          when Array
            data.map { |d| format(d) }
          else
            data
          end
        end

        def apply(data, schema, type = nil, opts = {})
          case resolve_shape(schema)
          when Shapes::StructureShape then apply_structure(data, schema, type)
          when Shapes::UnionShape then apply_union(data, schema, type)
          when Shapes::ListShape then apply_list(data, schema)
          when Shapes::MapShape then apply_map(data, schema)
          when Shapes::TimestampShape then apply_timestamp(data, schema, opts)
          when Shapes::BlobShape then Base64.decode64(data)
          else data
          end
        end

        # rubocop:disable Metrics/CyclomaticComplexity
        def extract(data, schema, opts = {})
          return if data.nil?

          case resolve_shape(schema)
          when Shapes::StructureShape then extract_structure(data, schema, opts)
          when Shapes::UnionShape     then extract_union(data, schema, opts)
          when Shapes::ListShape      then extract_list(data, schema)
          when Shapes::MapShape       then extract_map(data, schema)
          when Shapes::BlobShape      then extract_blob(data, schema)
          when Shapes::TimestampShape then extract_timestamp(data, schema, opts)
          else data
          end
        end
        # rubocop:enable Metrics/CyclomaticComplexity

        private

        def apply_structure(data, schema, type)
          shape = resolve_shape(schema)

          type = shape.type.new if type.nil?
          data.each do |k, v|
            name =
              if (member = json_name_member(k, shape))
                shape.name_by_member_name(member.name)
              else
                member_name(shape, k)
              end
            next if name.nil?

            type[name] = apply(v, shape.member(name))
          end
          type
        end

        def apply_timestamp(data, schema, opts)
          data = data.is_a?(Numeric) ? Time.at(data) : Time.parse(data)
          trait = resolve_timestamp_trait(schema) if opts[:use_timestamp_format]
          time(data, trait)
        end

        # rubocop:disable Metrics/AbcSize
        def apply_union(data, schema, type)
          shape = resolve_shape(schema)
          key, value = data.flatten
          return if key.nil?

          if (member = json_name_member(key, shape))
            member_name = shape.name_by_member_name(member.name)
            type = shape.member_type(member_name) if type.nil?
            type.new(apply(value, shape.member(member_name)))
          elsif shape.name_by_member_name?(key)
            member_name = shape.name_by_member_name(key)
            type = shape.member_type(member_name) if type.nil?
            type.new(apply(value, shape.member(member_name)))
          else
            shape.member_type(:unknown).new(key, value)
          end
        end
        # rubocop:enable Metrics/AbcSize

        def json_name_member(name, shape)
          shape.members.values.find do |v|
            v.traits['smithy.api#jsonName'] == name if v.traits.include?('smithy.api#jsonName')
          end
        end

        def apply_list(data, schema)
          shape = resolve_shape(schema)
          data.map do |v|
            next if v.nil?

            apply(v, shape.member)
          end
        end

        def apply_map(data, schema)
          shape = resolve_shape(schema)
          data.transform_values do |v|
            if v.nil?
              nil
            else
              apply(v, shape.value)
            end
          end
        end

        def extract_structure(data, schema, opts)
          shape = resolve_shape(schema)
          data.to_h.each_with_object({}) do |(k, v), o|
            next unless shape.member?(k)

            member_shape = shape.member(k)
            member_name = resolve_member_name(member_shape, opts)
            o[member_name] = extract(v, member_shape, opts)
          end
        end

        # rubocop:disable Metrics/AbcSize
        def extract_union(data, schema, opts)
          h = {}
          shape = resolve_shape(schema)
          if data.is_a?(Schema::Union)
            member_shape = shape.member_by_type(data.class)
            member_name = resolve_member_name(member_shape, opts)
            h[member_name] = extract(data, member_shape).value
          else
            key, value = data.first
            if shape.member?(key)
              member_shape = shape.member(key)
              member_name = resolve_member_name(member_shape, opts)
              h[member_name] = extract(value, member_shape)
            end
          end
          h
        end
        # rubocop:enable Metrics/AbcSize

        def extract_list(data, schema)
          shape = resolve_shape(schema)
          data.collect { |v| extract(v, shape.member) }
        end

        def extract_map(data, schema)
          shape = resolve_shape(schema)
          data.each.with_object({}) do |(k, v), h|
            h[k] = extract(v, shape.value)
          end
        end

        def extract_blob(data, _schema)
          Base64.strict_encode64(data.is_a?(String) ? data : data.read)
        end

        def extract_timestamp(data, schema, opts)
          return unless data.is_a?(Time)

          trait = resolve_timestamp_trait(schema) if opts[:use_timestamp_format]
          time(data, trait)
        end

        def member_name(schema, key)
          return unless schema.name_by_member_name?(key) || schema.member?(key.to_sym)

          schema.name_by_member_name(key) || key.to_sym
        end

        def resolve_shape(schema)
          schema.is_a?(Shapes::MemberShape) ? schema.shape : schema
        end

        def resolve_member_name(member_shape, opts)
          if opts[:use_json_name] && member_shape.traits['smithy.api#jsonName']
            member_shape.traits['smithy.api#jsonName']
          else
            member_shape.name
          end
        end

        def resolve_timestamp_trait(schema)
          if schema.is_a?(Shapes::MemberShape)
            schema.traits['smithy.api#timestampFormat']
          else
            schema.shape.traits['smithy.api#timestampFormat']
          end
        end

        def time(data, trait = nil)
          if trait
            case trait
            when 'http-date'
              data.utc.iso8601
            when 'date-time'
              data.utc.httpdate
            when 'epoch-seconds'
              data.utc.to_i
            else
              raise "unhandled timestamp format `#{value}`"
            end
          else
            #  timestamp format is "epoch-seconds" by default
            data.utc.to_i
          end
        end
      end
    end
  end
end
