# frozen_string_literal: true

require 'delegate'

module Smithy
  module Schema
    # A module mixed into Structs that provides utility methods for Union shapes.
    module Union
      include Structure

      def member
        members.find { |m| !self[m].nil? }
      end

      def value
        self[member] if member
      end
    end
  end
end
