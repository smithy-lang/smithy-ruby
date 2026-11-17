# frozen_string_literal: true

require_relative 'extension'
require_relative 'value_decoding'

module Smithy
  module Cbor
    # @api private
    #
    # Reads a CBOR body straight into the typed result in one pass, following the shape plans of {Extension}.
    # Scalars, map keys and unknown members are decoded by {ValueDecoding}, shared with the Decoder, so every item,
    # count, key, type and depth error and message is the same. Duplicate map keys and collections of the wrong
    # type raise ParseError. Errors about the values are raised after the whole body is read, so errors in the bytes
    # take precedence.
    #
    # A given structure, list or map result is only filled once the whole body has been read without error; if
    # #read raises, it is left as it was.
    #
    # Text values and map keys are checked for valid UTF-8. A structure or union key that matches the plan is
    # byte for byte a member name from the schema, so only keys that do not match are checked.
    #
    # Scalars and unions, the bulk of most bodies, are read inline at each call site rather than through #value.
    class Reader # rubocop:disable Metrics/ClassLength
      include ValueDecoding
      include Extension::ParseEntry

      NULL = 0xf6
      ONE_ENTRY_MAP = 0xa1
      FILLED_AFTER = %i[structure list map].freeze

      def read(target, result = nil)
        kind = Extension.parse_kind(target)
        if FILLED_AFTER.include?(kind)
          fill = result # filled below, once the whole body has been read
          result = nil
        end
        value = kind == :scalar ? decode_item : value(target, kind, result)
        finish
        fill ? fill_result(fill, value) : value
      end

      private

      def finish
        if @pos != @buffer.bytesize
          raise ParseError, "Extra bytes follow after decoding item. Read #{@pos} / #{@buffer.bytesize} bytes"
        end
        raise @error if @error
      end

      # Lists are appended to, maps take every entry (sparse maps keep nil values), and structures take their
      # non-nil members.
      def fill_result(result, value)
        case value
        when Array then result.concat(value)
        when Hash then value.each { |key, element| result[key] = element }
        else value&.each_pair { |name, member| result[name] = member unless member.nil? }
        end
        result
      end

      # A container item. Counts toward the nesting limit like Decoder#decode_item.
      def value(target, kind, result = nil) # rubocop:disable Metrics
        depth_exceeded if (@depth += 1) > MAX_DEPTH

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
            when :map then map(target, remaining)
            else union(target, remaining, result)
            end
          elsif byte == NULL
            nil
          else
            defer_collection_type_error(target, kind, process_item(major, byte & FIVE_BIT_MASK))
          end
        @depth -= 1
        value
      end

      # ValueDecoding#decode_item with integers and definite-length strings inlined.
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

          start = @pos # ValueDecoding#take and #text, inlined
          out_of_bytes(info, @buffer.bytesize - start) if start + info > @buffer.bytesize
          @pos = start + info
          string = @buffer.byteslice(start, info).force_encoding(Encoding::UTF_8)
          string.valid_encoding? ? string : invalid_text
        else
          decode_item
        end
      end

      # #value for a union whose plan the caller has; a one-entry map, the normal union, is read here.
      def union_value(target, plan) # rubocop:disable Metrics
        depth_exceeded if (@depth += 1) > MAX_DEPTH

        unless @buffer.getbyte(@pos) == ONE_ENTRY_MAP
          @depth -= 1
          return value(target, :union)
        end

        @pos += 1
        key = read_unchecked_string
        if (entry = plan[key]) && @buffer.getbyte(@pos) != NULL
          kind = entry[KIND] # #member_value, inlined
          member =
            if kind == :scalar then scalar
            elsif kind == :union then union_value(entry[TARGET], Extension.parse_plan(entry[TARGET]))
            else value(entry[TARGET], kind)
            end
          @depth -= 1
          return union_member(entry, member)
        end

        invalid_text unless entry || key.valid_encoding?
        raw = decode_item
        @depth -= 1
        unknown_member(target, key == '__type' ? nil : { key => raw })
      end

      # The value of a structure or union member.
      def member_value(entry)
        kind = entry[KIND]
        if kind == :scalar then scalar
        elsif kind == :union then union_value(entry[TARGET], Extension.parse_plan(entry[TARGET]))
        else value(entry[TARGET], kind)
        end
      end

      # A list, map, structure or union given any other item, which was decoded to keep reading the body. Raised
      # by #read as a value error.
      def defer_collection_type_error(target, kind, decoded)
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
        plan = Extension.parse_plan(target)
        result ||= target.type.new
        seen = 0
        unknown = nil
        while remaining != 0
          break if remaining.negative? && break_stop_code?

          key = read_unchecked_string
          if (entry = plan[key])
            duplicate_key(key) if seen.anybits?(entry[BIT])
            seen |= entry[BIT]
            kind = entry[KIND] # #member_value, inlined
            member =
              if kind == :scalar then scalar
              elsif kind == :union then union_value(entry[TARGET], Extension.parse_plan(entry[TARGET]))
              else value(entry[TARGET], kind)
              end
            result[entry[NAME]] = member unless member.nil?
          else
            invalid_text unless key.valid_encoding?
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
        member, kind, sparse = Extension.collection_value_parse_plan(target)
        union_plan = Extension.parse_plan(member) if kind == :union
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

      def map(target, remaining) # rubocop:disable Metrics
        value_target, kind, sparse = Extension.collection_value_parse_plan(target)
        union_plan = Extension.parse_plan(value_target) if kind == :union
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
        map
      end

      # The first known member with a non-nil value; without one, the first entry other than __type is the unknown
      # member. Later entries are still read.
      def union(target, remaining, result) # rubocop:disable Metrics
        plan = Extension.parse_plan(target)
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
            member = member_value(entry)
            found = entry
          else
            raw = decode_item
            unknown = { key => raw } if !found && !unknown && key != '__type'
          end
          remaining -= 1
        end
        @pos += 1 if remaining.negative?
        return unknown_member(target, unknown) unless found
        return result.new(found[NAME] => member) if result

        union_member(found, member)
      end

      # Same object as member_type.new(name => value), without the keyword hash when the class uses Struct's own
      # construction.
      def union_member(entry, member)
        klass = entry[MEMBER_CLASS]
        return klass.new(entry[NAME] => member) unless entry[PLAIN_MEMBER]

        result = klass.allocate
        result[entry[NAME]] = member
        result
      end

      def unknown_member(target, unknown)
        target.member_type(:unknown).new(unknown: unknown || { nil => nil })
      end
    end
  end
end
