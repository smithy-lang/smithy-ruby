# frozen_string_literal: true

require 'base64'
require 'time'

module Smithy
  module Schema
    # @api private
    # Document Utilities to help (de)construct data to/from Smithy document
    module DocumentUtils
      class << self
        # Used to transform untyped data
        def format(data)
          return if data.nil?

          case data
          when Time
            data.to_i # timestamp format is "epoch-seconds" by default
          when Hash
            data.transform_values { |v| format(v) }
          when Array
            data.map { |d| format(d) }
          else
            data
          end
        end

        # Used to apply data to runtime shape
        def apply(data, shape, type = nil)
          case shape_reference(shape)
          when Shapes::StructureShape then apply_structure(data, shape, type)
          when Shapes::UnionShape then apply_union(data, shape, type)
          when Shapes::ListShape then apply_list(data, shape)
          when Shapes::MapShape then apply_map(data, shape)
          when Shapes::TimestampShape then apply_timestamp(data, shape)
          when Shapes::BlobShape then Base64.decode64(data)
          else data
          end
        end

        # rubocop:disable Metrics/CyclomaticComplexity
        def extract(data, shape, opts = {})
          return if data.nil?

          case shape_reference(shape)
          when Shapes::StructureShape then extract_structure(data, shape, opts)
          when Shapes::UnionShape     then extract_union(data, shape, opts)
          when Shapes::ListShape      then extract_list(data, shape)
          when Shapes::MapShape       then extract_map(data, shape)
          when Shapes::BlobShape      then extract_blob(data)
          when Shapes::TimestampShape then extract_timestamp(data, shape, opts)
          else data
          end
        end
        # rubocop:enable Metrics/CyclomaticComplexity

        private

        def apply_list(data, shape)
          shape = shape_reference(shape)
          data.map do |v|
            next if v.nil?

            apply(v, shape.member)
          end
        end

        def apply_map(data, shape)
          shape = shape_reference(shape)
          data.transform_values do |v|
            if v.nil?
              nil
            else
              apply(v, shape.value)
            end
          end
        end

        def apply_structure(data, shape, type)
          shape = shape_reference(shape)

          type = shape.type.new if type.nil?
          data.each do |k, v|
            name =
              if (member = member_with_json_name(k, shape))
                shape.name_by_member_name(member.name)
              else
                member_name(shape, k)
              end
            next if name.nil?

            type[name] = apply(v, shape.member(name))
          end
          type
        end

        def apply_timestamp(data, shape)
          data = data.is_a?(Numeric) ? Time.at(data) : Time.parse(data)
          time(data, timestamp_format(shape))
        end

        def apply_union(data, shape, type)
          shape = shape_reference(shape)
          key, value = data.flatten
          return if key.nil?

          if (member = member_with_json_name(key, shape))
            apply_union_member(member.name, value, shape, type)
          elsif shape.name_by_member_name?(key)
            apply_union_member(key, value, shape, type)
          else
            shape.member_type(:unknown).new(key, value)
          end
        end

        def apply_union_member(key, value, shape, type)
          member_name = shape.name_by_member_name(key)
          type = shape.member_type(member_name) if type.nil?
          type.new(apply(value, shape.member(member_name)))
        end

        def extract_blob(data)
          Base64.strict_encode64(data.is_a?(String) ? data : data.read)
        end

        def extract_list(data, shape)
          shape = shape_reference(shape)
          data.collect { |v| extract(v, shape.member) }
        end

        def extract_map(data, shape)
          shape = shape_reference(shape)
          data.each.with_object({}) { |(k, v), h| h[k] = extract(v, shape.value) }
        end

        def extract_structure(data, shape, opts)
          shape = shape_reference(shape)
          data.to_h.each_with_object({}) do |(k, v), o|
            next unless shape.member?(k)

            member_shape = shape.member(k)
            member_name = resolve_member_name(member_shape, opts)
            o[member_name] = extract(v, member_shape, opts)
          end
        end

        def extract_timestamp(data, shape, opts)
          return unless data.is_a?(Time)

          trait = timestamp_format(shape) if opts[:use_timestamp_format]
          time(data, trait)
        end

        # rubocop:disable Metrics/AbcSize
        def extract_union(data, shape, opts)
          h = {}
          shape = shape_reference(shape)
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

        def member_name(shape, key)
          return unless shape.name_by_member_name?(key) || shape.member?(key.to_sym)

          shape.name_by_member_name(key) || key.to_sym
        end

        def member_with_json_name(name, shape)
          shape.members.values.find do |v|
            v.traits['smithy.api#jsonName'] == name if v.traits.include?('smithy.api#jsonName')
          end
        end

        def resolve_member_name(member_shape, opts)
          if opts[:use_json_name] && member_shape.traits['smithy.api#jsonName']
            member_shape.traits['smithy.api#jsonName']
          else
            member_shape.name
          end
        end

        def shape_reference(shape)
          shape.is_a?(Shapes::MemberShape) ? shape.shape : shape
        end

        # The following steps are taken to determine the format of timestamp:
        # Use the timestampFormat trait of the member, if present.
        # Use the timestampFormat trait of the shape, if present.
        # If none of the above applies, use epoch-seconds as default
        def timestamp_format(shape)
          if shape.traits['smithy.api#timestampFormat']
            shape.traits['smithy.api#timestampFormat']
          elsif shape.shape.traits['smithy.api#timestampFormat']
            shape.shape.traits['smithy.api#timestampFormat']
          else
            'epoch-seconds'
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
            data.utc.to_i # default format
          end
        end
      end
    end
  end
end
