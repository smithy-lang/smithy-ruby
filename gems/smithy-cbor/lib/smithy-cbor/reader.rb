# frozen_string_literal: true

require_relative 'extension'
require_relative 'item_reader'

module Smithy
  module Cbor
    # @api private
    #
    # Reads a CBOR body straight into the typed result in one pass, following the shape plans of {Extension}. The
    # bytes are read by {ItemReader}, shared with the Decoder, so every item, count, key and depth error and message
    # is the same. Duplicate map keys and collections of the wrong type raise ParseError. Errors about the values
    # are raised after the whole body is read, so errors in the bytes take precedence.
    #
    # A given result is only filled once the whole body has been read without error; if #read raises, it is left
    # as it was.
    #
    # Scalars and unions, the bulk of most bodies, are read inline at each call site rather than through #value.
    class Reader # rubocop:disable Metrics/ClassLength
      include ItemReader

      NULL = 0xf6
      ONE_ENTRY_MAP = 0xa1
      FILLED_AFTER = %i[structure list].freeze

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
        if @pos != @buffer.size
          raise ParseError, "Extra bytes follow after decoding item. Read #{@pos} / #{@buffer.size} bytes"
        end
        raise @error if @error
      end

      def fill_result(result, value)
        return result.concat(value) if value.is_a?(Array)

        value&.each_pair { |name, member| result[name] = member unless member.nil? }
        result
      end

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
            elsif kind == :union then union_value(entry[1], Extension.parse_plan(entry[1]))
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
        plan = Extension.parse_plan(target)
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
              elsif kind == :union then union_value(entry[1], Extension.parse_plan(entry[1]))
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
        member, kind, sparse = Extension.element_parse_plan(target)
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

      def map(target, remaining, result) # rubocop:disable Metrics
        value_target, kind, sparse = Extension.element_parse_plan(target)
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
        return map unless result

        map.each { |key, element| result[key] = element }
        result
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
    end
  end
end
