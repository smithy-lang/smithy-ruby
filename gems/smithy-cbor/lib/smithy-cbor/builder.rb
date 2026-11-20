# frozen_string_literal: true

require_relative 'encoder'
require_relative 'extension'

module Smithy
  module Cbor
    # @api private
    #
    # Writes params straight into one Encoder in a single pass, following the shape plans of {Extension}. Scalars,
    # the bulk of most params, are written inline at each call site rather than through #write.
    #
    # The shape decides how aggregates, blobs and map keys are written: blobs are always byte strings and map keys
    # are always text strings. Other scalars are encoded from the Ruby value, as Encoder#add does: a String is text
    # unless its encoding is BINARY, and an Integer, Float, true, false or nil is written as that type.
    #
    # Accepted params:
    #
    # * Structures: an instance of the generated structure type, or a Hash keyed by Ruby member name. Both are
    #   known to yield each member at most once. Any other object that responds to #each_pair is accepted too, and
    #   raises BuildError if it yields a member twice.
    # * Unions: a Schema::Union, a Hash, or any object whose #first is a [member name, value] pair.
    # * Lists: an Array or any Enumerable.
    # * Maps: a Hash or any Enumerable of [key, value] pairs, keyed by Strings or Symbols. Keys are compared by the
    #   text they are written as, so keys that collide, such as :name and "name", raise BuildError.
    # * Blobs: a String in any encoding, or an IO-like object that responds to #read.
    class Builder
      def initialize(_options = {}); end

      def build(shape, data)
        target = shape.target
        return if target == Schema::Shapes::Prelude::Unit

        encoder = Encoder.new
        if target.is_a?(Schema::Shapes::StructureShape) # every operation input; faster than the cached kind
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
        value = value.read if value.respond_to?(:read)
        value.is_a?(String) ? encoder.add_byte_string(value) : write_scalar(encoder, value)
      end

      # Writes members in params order. The map header is reserved first and updated afterwards with the number of
      # members actually written.
      #
      # Hashes and unmodified generated Structs yield each member at most once. Other objects are checked and raise
      # BuildError if they yield the same recognized, non-nil member more than once.
      def write_structure(encoder, target, values) # rubocop:disable Metrics
        return encoder.add_nil if values.nil?

        plan, plain = Extension.structure_build_plan(target)
        check_duplicates = !(values.instance_of?(Hash) || (plain && values.instance_of?(plain)))
        position = encoder.begin_map
        count = 0
        seen = 0
        values.each_pair do |member_name, value|
          next if value.nil?
          next unless (entry = plan[member_name])

          if check_duplicates
            bit = entry[Extension::BuildEntry::BIT]
            raise BuildError, "Duplicate member: #{member_name}" if seen.anybits?(bit)

            seen |= bit
          end
          encoder.add_encoded(entry[Extension::BuildEntry::KEY])
          kind = entry[Extension::BuildEntry::KIND]
          if kind == :scalar
            write_scalar(encoder, value)
          else
            write(encoder, entry[Extension::BuildEntry::TARGET], kind, value)
          end
          count += 1
        end
        encoder.finish_map(position, count)
      end

      def write_list(encoder, target, values) # rubocop:disable Metrics
        return encoder.add_nil if values.nil?

        unless values.instance_of?(Array)
          values = values.collect { |value| value }
          return encoder.add(values) unless values.is_a?(Array)
        end
        member, kind = Extension.collection_value_build_plan(target)
        encoder.start_array(values.size)
        # Every element has the same kind, so the writer is chosen once rather than per element.
        case kind
        when :scalar then values.each { |value| write_scalar(encoder, value) }
        when :union then values.each { |value| write_union(encoder, member, value) }
        when :structure then values.each { |value| write_structure(encoder, member, value) }
        else values.each { |value| write(encoder, member, kind, value) }
        end
      end

      # A plain Hash with UTF-8 String keys, the normal case, is written as is. Any other map is first copied into
      # a Hash keyed by the text of each key, and a plain Hash with other keys is checked after it is written, so
      # keys that collide as text raise.
      def write_map(encoder, target, values) # rubocop:disable Metrics
        return encoder.add_nil if values.nil?

        values = text_keyed(values) unless values.instance_of?(Hash) && !values.compare_by_identity?
        value_target, kind = Extension.collection_value_build_plan(target)
        union = kind == :union
        other_keys = false
        encoder.start_map(values.size)
        values.each do |key, value|
          if key.instance_of?(String) && key.encoding == Encoding::UTF_8
            encoder.add_string(key)
          else
            encoder.add_map_key(key)
            other_keys = true
          end
          if union then write_union(encoder, value_target, value)
          elsif kind == :scalar then write_scalar(encoder, value)
          else write(encoder, value_target, kind, value)
          end
        end
        text_keyed(values) if other_keys
      end

      # A copy of the map keyed by the UTF-8 text each key is written as; raises for keys that collide.
      def text_keyed(values)
        copy = {}
        values.each do |key, value|
          text = Encoder.map_key_text(key).encode(Encoding::UTF_8)
          raise BuildError, "Duplicate map key: #{key.inspect}" if copy.key?(text)

          copy[text] = value
        end
        copy
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

        encoder.add_encoded(entry[Extension::BuildEntry::UNION_KEY])
        kind = entry[Extension::BuildEntry::KIND]
        if kind == :scalar
          write_scalar(encoder, value)
        else
          write(encoder, entry[Extension::BuildEntry::TARGET], kind, value)
        end
      end
    end
  end
end
