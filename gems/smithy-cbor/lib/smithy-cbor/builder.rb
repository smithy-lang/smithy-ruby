# frozen_string_literal: true

require 'base64'
require_relative 'encoder'

module Smithy
  module Cbor
    # @api private
    #
    # Writes params straight into one Encoder in a single pass, using per-shape plans cached on the shapes. Scalars,
    # the bulk of most params, are written inline at each call site rather than through #write.
    class Builder
      EMPTY_MAP = Encoder::BYTE_HEADERS[Encoder::MAJOR_TYPE_MAP]
      UNION_HEADER = Encoder::BYTE_HEADERS[Encoder::MAJOR_TYPE_MAP + 1] # one-entry map
      PLAIN_STRUCTS = {} # rubocop:disable Style/MutableConstant

      def initialize(_options = {}); end

      def build(shape, data)
        target = shape.target
        return if target == Schema::Shapes::Prelude::Unit

        encoder = Encoder.new
        if target.is_a?(Schema::Shapes::StructureShape)
          write_structure(encoder, target, data)
        else
          write(encoder, target, kind_of(target), data)
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

      # Members are written in params order behind a one-byte map header, patched with the count afterwards. Params
      # other than a Hash or a plain Struct may yield a member twice, which raises.
      def write_structure(encoder, target, values) # rubocop:disable Metrics
        return encoder.add_nil if values.nil?

        check = !(values.instance_of?(Hash) || plain_struct?(values))
        plan = member_plan(target)
        buffer = encoder.bytes
        start = buffer.bytesize
        buffer << EMPTY_MAP
        count = 0
        seen = 0
        values.each_pair do |member_name, value|
          next if value.nil?
          next unless (entry = plan[member_name])

          if check
            raise BuildError, "Duplicate member: #{member_name}" if seen.anybits?(entry[4])

            seen |= entry[4]
          end
          buffer << entry[0]
          kind = entry[2]
          kind == :scalar ? write_scalar(encoder, value) : write(encoder, entry[1], kind, value)
          count += 1
        end
        return buffer.setbyte(start, Encoder::MAJOR_TYPE_MAP + count) if count < 24

        header = Encoder.new # 24+ members need a longer header
        header.start_map(count)
        buffer[start, 1] = header.bytes
      end

      def write_list(encoder, target, values)
        return encoder.add_nil if values.nil?

        unless values.instance_of?(Array)
          values = values.collect { |value| value }
          return encoder.add(values) unless values.is_a?(Array)
        end
        member, kind = element_plan(target, :member)
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
        value_target, kind = element_plan(target, :value)
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
        return encoder.bytes << EMPTY_MAP unless (entry = member_plan(target)[key])

        encoder.bytes << entry[3]
        kind = entry[2]
        kind == :scalar ? write_scalar(encoder, value) : write(encoder, entry[1], kind, value)
      end

      # Struct values whose #each_pair is the built-in one.
      def plain_struct?(values)
        return false unless values.is_a?(Struct)

        PLAIN_STRUCTS.fetch(values.class) do |klass|
          PLAIN_STRUCTS[klass] = klass.instance_method(:each_pair).owner == Struct
        end
      end

      # Ruby member name => [encoded wire key, member target, writer kind, one-entry map header + key,
      # duplicate-check bit], cached on the shape.
      def member_plan(target)
        target[:cbor_build_plan] ||= build_member_plan(target)
      end

      def build_member_plan(target)
        members = target.members
        names = members.values.map(&:name)
        if (collision = names.detect { |name| names.count(name) > 1 })
          raise BuildError, "Members of #{target.id} share the wire name #{collision}"
        end

        members.each_with_index.to_h { |(name, member), index| [name, member_entry(member, index)] }.freeze
      end

      def member_entry(member, index)
        key = Encoder.new.add(member.name).bytes.freeze
        target = member.target
        [key, target, kind_of(target), (UNION_HEADER + key).freeze, 1 << index].freeze
      end

      # [element target, writer kind] for a list or map shape, cached on the shape.
      def element_plan(target, part)
        target[:cbor_build_plan] ||= [(element = target.public_send(part).target), kind_of(element)].freeze
      end

      def kind_of(target)
        case target
        when Schema::Shapes::BlobShape then :blob
        when Schema::Shapes::ListShape then :list
        when Schema::Shapes::MapShape then :map
        when Schema::Shapes::StructureShape then :structure
        when Schema::Shapes::UnionShape then :union
        else :scalar
        end
      end
    end
  end
end
