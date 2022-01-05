# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'base64'

module WhiteLabel
  module Builders

    # Operation Builder for KitchenSink
    class KitchenSink
      def self.build(http_req, input:)
      end
    end

    # Structure Builder for Union
    class Union
      def self.build(input)
        data = {}
        case input
        when Types::Union::String
        when Types::Union::Struct
        else
          raise ArgumentError,
          "Expected input to be one of the subclasses of Types::Union"
        end

        data
      end
    end

    # Structure Builder for Struct
    class Struct
      def self.build(input)
        data
      end
    end

    # Set Builder for SetOfStructs

    class SetOfStructs
      def self.build(input)
        data = Set.new
        input.each do |element|
        end
        data
      end
    end

    # Set Builder for SetOfStrings

    class SetOfStrings
      def self.build(input)
        data = Set.new
        input.each do |element|
        end
        data
      end
    end

    # Map Builder for MapOfStructs
    class MapOfStructs
      def self.build(input)
        data = {}
        input.each do |key, value|
        end
        data
      end
    end

    # Map Builder for MapOfStrings
    class MapOfStrings
      def self.build(input)
        data = {}
        input.each do |key, value|
        end
        data
      end
    end

    # List Builder for ListOfStructs
    class ListOfStructs
      def self.build(input)
        data = []
        input.each do |element|
        end
        data
      end
    end

    # List Builder for ListOfStrings
    class ListOfStrings
      def self.build(input)
        data = []
        input.each do |element|
        end
        data
      end
    end

    # Operation Builder for PaginatorsTest
    class PaginatorsTest
      def self.build(http_req, input:)
      end
    end

    # Operation Builder for PaginatorsTestWithItems
    class PaginatorsTestWithItems
      def self.build(http_req, input:)
      end
    end

    # Operation Builder for WaitersTest
    class WaitersTest
      def self.build(http_req, input:)
      end
    end
  end
end
