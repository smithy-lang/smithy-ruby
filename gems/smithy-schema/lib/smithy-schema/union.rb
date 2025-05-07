# frozen_string_literal: true

require 'delegate'

module Smithy
  module Schema
    # Top level class for all generated Union types
    class Union < ::SimpleDelegator
      include Structure

      def to_s
        "#<#{self.class.name} #{__getobj__ || 'nil'}>"
      end

      def value
        __getobj__
      end
    end

    # An empty Union that implements the Union interface.
    class EmptyUnion < Union
      def to_h
        {}
      end
    end
  end
end
