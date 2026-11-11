# frozen_string_literal: true

require 'base64'
require_relative 'encoder'
require_relative 'extension'

module Smithy
  module Cbor
    # @api private
    #
    # Writes params straight into one Encoder in a single pass, following the shape plans of {Extension}. Scalars,
    # the bulk of most params, are written inline at each call site rather than through #write.
    #
    # The shape decides how aggregates and blobs are written. Scalars are encoded from the Ruby value, as
    # Encoder#add does: a String is text unless its encoding is BINARY, and an Integer, Float, true, false or nil is
    # written as that type.
    #
    # Accepted params:
    #
    # * Structures: an instance of the generated structure type, or a Hash keyed by Ruby member name. Both are
    #   known to yield each member at most once. Any other object that responds to #each_pair is accepted too, and
    #   raises BuildError if it yields a member twice.
    # * Unions: a Schema::Union, a Hash, or any object whose #first is a [member name, value] pair.
    # * Lists: an Array or any Enumerable. Maps: a Hash or any Enumerable of [key, value] pairs; keys that collide
    #   raise BuildError.
    # * Blobs: a String, or an IO-like object that responds to #read.
    class Builder
      def initialize(_options = {}); end

      def build(shape, data)
        target = shape.target
        return if target == Schema::Shapes::Prelude::Unit

        encoder = Encoder.new
        if target.is_a?(Schema::Shapes::StructureShape)
          write_structure(encoder, target, data)
        else
          write(encoder, target, Extension.build_kind(target), data)
        end
        encoder.bytes
      end

      private

      def write(encoder, target, kind, value)
        case kind
        when :scalar then write_scalar(encoder, value)
        when :structure then write_structure(encoder, target, value)
        when :list then write_list(encoder, target, value)
        when :map then write_map(encoder, target, value)
        when :union then write_union(encoder, target, value)
        else write_blob(encoder, value)
        end
      end

      # Same type dispatch as Encoder#add; other classes are left to #add itself.
      def write_scalar(encoder, value)
        case value
        when String
          value.encoding == Encoding::BINARY ? encoder.add_byte_string(value) : encoder.add_string(value)
        when Integer then encoder.add_auto_integer(value)
        when Float then encoder.add_auto_float(value)
        when true, false then encoder.add_boolean(value)
        when nil then encoder.add_nil
        else encoder.add(value)
        end
      end

      def write_blob(encoder, value)
        write_scalar(encoder, value.respond_to?(:read) ? value.read : value)
      end

      # Members are written in params order behind a map header whose count is set afterwards. Params other than a
      # Hash or an instance of the generated type may yield a member twice, which raises.
      def write_structure(encoder, target, values) # rubocop:disable Metrics
        return encoder.add_nil if values.nil?

        plan, plain = Extension.structure_build_plan(target)
        check = !(values.instance_of?(Hash) || (plain && values.instance_of?(plain)))
        position = encoder.begin_map
        count = 0
        seen = 0
        values.each_pair do |member_name, value|
          next if value.nil?
          next unless (entry = plan[member_name])

          if check
            raise BuildError, "Duplicate member: #{member_name}" if seen.anybits?(entry[4])

            seen |= entry[4]
          end
          encoder.add_encoded(entry[0])
          kind = entry[2]
          kind == :scalar ? write_scalar(encoder, value) : write(encoder, entry[1], kind, value)
          count += 1
        end
        encoder.finish_map(position, count)
      end

      def write_list(encoder, target, values)
        return encoder.add_nil if values.nil?

        unless values.instance_of?(Array)
          values = values.collect { |value| value }
          return encoder.add(values) unless values.is_a?(Array)
        end
        member, kind = Extension.element_build_plan(target)
        encoder.start_array(values.size)
        values.each { |value| write(encoder, member, kind, value) }
      end

      # Maps other than a plain Hash are copied into one first; keys that collide in the copy raise.
      def write_map(encoder, target, values) # rubocop:disable Metrics
        return encoder.add_nil if values.nil?

        unless values.instance_of?(Hash) && !values.compare_by_identity?
          data = {}
          values.each do |key, value|
            raise BuildError, "Duplicate map key: #{key.inspect}" if data.key?(key)

            data[key] = value
          end
          values = data
        end
        value_target, kind = Extension.element_build_plan(target)
        union = kind == :union
        encoder.start_map(values.size)
        values.each do |key, value|
          if key.instance_of?(String) && key.encoding != Encoding::BINARY
            encoder.add_string(key)
          else
            write_scalar(encoder, key)
          end
          if union then write_union(encoder, value_target, value)
          elsif kind == :scalar then write_scalar(encoder, value)
          else write(encoder, value_target, kind, value)
          end
        end
      end

      def write_union(encoder, target, values) # rubocop:disable Metrics
        return encoder.add_nil if values.nil?

        if values.is_a?(Schema::Union)
          key = values.member
          value = values.value
        elsif values.instance_of?(Hash)
          # Hash#first without the Enumerable overhead; a Symbol key's lookup returns the first pair's value.
          key = values.keys[0]
          key.is_a?(Symbol) ? value = values[key] : (key, value = values.first)
        else
          key, value = values.first
        end
        return encoder.add_empty_map unless (entry = Extension.build_plan(target)[key])

        encoder.add_encoded(entry[3])
        kind = entry[2]
        kind == :scalar ? write_scalar(encoder, value) : write(encoder, entry[1], kind, value)
      end
    end
  end
end
