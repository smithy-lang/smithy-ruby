# frozen_string_literal: true

module Smithy
  module Client
    # A controlled enumerator for paginated results. Exposes only safe
    # enumeration methods that are meaningful for page/item iteration,
    # preventing accidental / wasteful full-pagination calls like #count or #sort.
    class PageEnumerator
      def initialize(&block)
        @block = block
      end

      def each(&consumer)
        return self unless consumer

        enum.each(&consumer)
      end

      def map(&) = enum.map(&)
      def select(&) = enum.select(&)
      def filter(&) = enum.select(&)
      def flat_map(&) = enum.flat_map(&)
      def reduce(*, &) = enum.reduce(*, &)

      def first(val = (no_arg = true
                       nil))
        no_arg ? enum.first : enum.first(val)
      end

      def take(val) = enum.take(val)
      def lazy = enum.lazy

      private

      def enum
        Enumerator.new(&@block)
      end
    end
  end
end
