# frozen_string_literal: true

require_relative 'decoder'

module Smithy
  module Cbor
    # @api private
    #
    # Reads a CBOR body straight into the typed result in one pass, using the Decoder's own item reading and errors.
    # Duplicate map keys and collections of the wrong type raise ParseError. Errors about the values are raised after
    # the whole body is read, so errors in the bytes take precedence.
    #
    # Scalars and unions, the bulk of most bodies, are read inline at each call site rather than through #value.
    class Reader < Decoder # rubocop:disable Metrics/ClassLength
      NULL = 0xf6
      ONE_ENTRY_MAP = 0xa1

      def read(target, result = nil)
        kind = target.is_a?(Schema::Shapes::StructureShape) ? :structure : kind_of(target)
        value = kind == :scalar ? decode_item : value(target, kind, result)
        if @pos != @buffer.size
          raise ParseError, "Extra bytes follow after decoding item. Read #{@pos} / #{@buffer.size} bytes"
        end
        raise @error if @error

        value
      end

      private

      # A container item. Counts toward the nesting limit like Decoder#decode_item.
      def value(target, kind, result = nil) # rubocop:disable Metrics
        @depth += 1
        raise ParseError, "Maximum nesting depth (#{MAX_DEPTH}) exceeded" if @depth > MAX_DEPTH

        byte = @buffer.getbyte(@pos) || out_of_bytes(1, @buffer.bytesize - @pos)
        @pos += 1
        major = byte >> 5
        value =
          if major == (kind == :list ? 4 : 5)
            info = byte & FIVE_BIT_MASK
            remaining = info == 31 ? -1 : read_count(info) # -1: indefinite length, ends at a break code
            case kind
            when :structure then structure(target, remaining, result)
            when :list then list(target, remaining, result)
            when :map then map(target, remaining, result)
            else union(target, remaining, result)
            end
          elsif byte == NULL
            nil
          else
            mismatch(target, kind, process_item(major, byte & FIVE_BIT_MASK))
          end
        @depth -= 1
        value
      end

      # Decoder#decode_item with integers and definite-length strings inlined.
      def scalar # rubocop:disable Metrics
        return decode_item if @depth >= MAX_DEPTH # decode_item raises the depth error

        byte = @buffer.getbyte(@pos)
        return decode_item if byte.nil?

        info = byte & FIVE_BIT_MASK
        case byte >> 5
        when 0
          @pos += 1
          info < 24 ? info : read_count(info)
        when 2
          return decode_item if info == 31

          @pos += 1
          read_binary_string(info)
        when 3
          return decode_item if info == 31

          @pos += 1
          return read_string(info) if info > 23

          start = @pos # Decoder#take
          @pos += info
          out_of_bytes(info, @buffer.bytesize - @pos) if @pos > @buffer.bytesize
          @buffer[start, info].force_encoding(Encoding::UTF_8)
        else
          decode_item
        end
      end

      # #value for a union whose plan the caller has; a one-entry map, the normal union, is read here.
      def union_value(target, plan) # rubocop:disable Metrics
        @depth += 1
        raise ParseError, "Maximum nesting depth (#{MAX_DEPTH}) exceeded" if @depth > MAX_DEPTH

        unless @buffer.getbyte(@pos) == ONE_ENTRY_MAP
          @depth -= 1
          return value(target, :union)
        end

        @pos += 1
        key = read_string
        if (entry = plan[key]) && @buffer.getbyte(@pos) != NULL
          kind = entry[2]
          member =
            if kind == :scalar then scalar
            elsif kind == :union then union_value(entry[1], member_plan(entry[1]))
            else value(entry[1], kind)
            end
          @depth -= 1
          return union_member(entry, member)
        end

        raw = decode_item
        @depth -= 1
        unknown_member(target, key == '__type' ? nil : { key => raw })
      end

      # The original walk called #each on the value: anything else gets its NoMethodError, and the other collection
      # type is rejected.
      def mismatch(target, kind, decoded)
        begin
          decoded.each { nil } unless decoded.respond_to?(:each)
        rescue NoMethodError => e
          return value_error(e)
        end
        value_error(
          ParseError.new("Expected a CBOR #{kind == :list ? 'array' : 'map'} for #{target.id}, got #{decoded.class}")
        )
      end

      def duplicate_key(key)
        value_error(ParseError.new("Duplicate map key: #{key.inspect}"))
      end

      # Keeps the first error for #read to raise; the item reads as nil.
      def value_error(error)
        @error ||= error
        nil
      end

      def structure(target, remaining, result) # rubocop:disable Metrics
        plan = member_plan(target)
        result ||= target.type.new
        seen = 0
        unknown = nil
        while remaining != 0
          break if remaining.negative? && break_stop_code?

          key = read_string
          if (entry = plan[key])
            duplicate_key(key) if seen.anybits?(entry[3])
            seen |= entry[3]
            kind = entry[2]
            member =
              if kind == :scalar then scalar
              elsif kind == :union then union_value(entry[1], member_plan(entry[1]))
              else value(entry[1], kind)
              end
            result[entry[0]] = member unless member.nil?
          else
            duplicate_key(key) if (unknown ||= {}).key?(key)
            unknown[key] = true
            decode_item
          end
          remaining -= 1
        end
        @pos += 1 if remaining.negative? # the break code
        result
      end

      def list(target, remaining, result) # rubocop:disable Metrics
        member, kind, sparse = element_plan(target, :member)
        union_plan = member_plan(member) if kind == :union
        result ||= []
        while remaining != 0
          break if remaining.negative? && break_stop_code?

          element =
            if kind == :scalar then scalar
            elsif union_plan then union_value(member, union_plan)
            else value(member, kind)
            end
          result << element unless element.nil? && !sparse
          remaining -= 1
        end
        @pos += 1 if remaining.negative?
        result
      end

      def map(target, remaining, result) # rubocop:disable Metrics
        value_target, kind, sparse = element_plan(target, :value)
        union_plan = member_plan(value_target) if kind == :union
        map = {}
        dropped = nil # keys of dropped nil values, which still count as duplicates
        while remaining != 0
          break if remaining.negative? && break_stop_code?

          key = read_string.freeze # Hash#[]= would store a frozen copy
          duplicate_key(key) if map.key?(key) || dropped&.key?(key)
          element =
            if kind == :scalar then scalar
            elsif union_plan then union_value(value_target, union_plan)
            else value(value_target, kind)
            end
          if element.nil? && !sparse
            (dropped ||= {})[key] = true
          else
            map[key] = element
          end
          remaining -= 1
        end
        @pos += 1 if remaining.negative?
        return map unless result

        map.each { |key, element| result[key] = element }
        result
      end

      # The first known member with a non-nil value; without one, the first entry other than __type is the unknown
      # member. Later entries are still read.
      def union(target, remaining, result) # rubocop:disable Metrics
        plan = member_plan(target)
        keys = {} unless remaining == 1
        found = nil
        unknown = nil
        while remaining != 0
          break if remaining.negative? && break_stop_code?

          key = read_string
          if keys
            duplicate_key(key) if keys.key?(key)
            keys[key] = true
          end
          if !found && (entry = plan[key]) && @buffer.getbyte(@pos) != NULL
            kind = entry[2]
            member = kind == :scalar ? scalar : value(entry[1], kind)
            found = entry
          else
            raw = decode_item
            unknown = { key => raw } if !found && !unknown && key != '__type'
          end
          remaining -= 1
        end
        @pos += 1 if remaining.negative?
        return unknown_member(target, unknown) unless found
        return result.new(found[0] => member) if result

        union_member(found, member)
      end

      # Same object as member_type.new(name => value), without the keyword hash when the class uses Struct's own
      # construction.
      def union_member(entry, member)
        klass = entry[4]
        return klass.new(entry[0] => member) unless entry[5]

        result = klass.allocate
        result[entry[0]] = member
        result
      end

      def unknown_member(target, unknown)
        target.member_type(:unknown).new(unknown: unknown || { nil => nil })
      end

      # Wire name => [Ruby member name, member target, kind, duplicate-check bit, union member class, whether that
      # class uses Struct's own construction], cached on the shape.
      def member_plan(target)
        target[:cbor_parse_plan] ||= build_member_plan(target)
      end

      def build_member_plan(target)
        union = target.is_a?(Schema::Shapes::UnionShape)
        Schema::Extension.wire_index(target).each_with_index.to_h do |(wire_name, (name, member)), index|
          klass = target.member_type(name) if union
          member_target = member.target
          entry = [name, member_target, kind_of(member_target), 1 << index, klass, union && plain_struct_class?(klass)]
          [wire_name, entry.freeze]
        end.freeze
      end

      def plain_struct_class?(klass)
        base = klass.ancestors.find { |ancestor| ancestor.is_a?(Class) && ancestor.superclass == Struct }
        base &&
          klass.instance_method(:initialize).owner == Struct &&
          klass.method(:new).owner == base.singleton_class &&
          klass.method(:allocate).owner == Class
      end

      # [element target, kind, sparse?] for a list or map shape, cached on the shape.
      def element_plan(target, part)
        target[:cbor_parse_plan] ||= [
          (element = target.public_send(part).target), kind_of(element), target.traits.key?('smithy.api#sparse')
        ].freeze
      end

      def kind_of(target)
        case target
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
