# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'base64'

module WhiteLabel
  module Parsers

    # Operation Parser for KitchenSink
    class KitchenSink
      def self.parse(http_resp)
        data = Types::KitchenSinkOutput.new
        data
      end
    end

    class Union
      def self.parse(map)
        key, value = map.flatten
        case key
        when 'String'
          Types::Union::String.new(value) if value
        when 'Struct'
          Types::Union::Struct.new(value) if value
        else
          Types::Union::Unknown.new({name: key, value: value})
        end
      end
    end

    class Struct
      def self.parse(map)
        data = Types::Struct.new
        return data
      end
    end

    class SetOfStructs
      def self.parse(list)
        data = list.map do |value|
        end
        Set.new(data)
      end
    end

    class SetOfStrings
      def self.parse(list)
        data = list.map do |value|
        end
        Set.new(data)
      end
    end

    class MapOfStructs
      def self.parse(map)
        data = {}
        map.map do |key, value|
        end
        data
      end
    end

    class MapOfStrings
      def self.parse(map)
        data = {}
        map.map do |key, value|
        end
        data
      end
    end

    class ListOfStructs
      def self.parse(list)
        list.map do |value|
        end
      end
    end

    class ListOfStrings
      def self.parse(list)
        list.map do |value|
        end
      end
    end

    # Error Parser for ClientError
    class ClientError
      def self.parse(http_resp)
        data = Types::ClientError.new
        data
      end
    end

    # Error Parser for ServerError
    class ServerError
      def self.parse(http_resp)
        data = Types::ServerError.new
        data
      end
    end

    # Operation Parser for PaginatorsTest
    class PaginatorsTest
      def self.parse(http_resp)
        data = Types::PaginatorsTestOperationOutput.new
        data
      end
    end

    class Items
      def self.parse(list)
        list.map do |value|
        end
      end
    end

    # Operation Parser for PaginatorsTestWithItems
    class PaginatorsTestWithItems
      def self.parse(http_resp)
        data = Types::PaginatorsTestWithItemsOutput.new
        data
      end
    end

    # Operation Parser for WaitersTest
    class WaitersTest
      def self.parse(http_resp)
        data = Types::WaitersTestOutput.new
        data
      end
    end
  end
end
