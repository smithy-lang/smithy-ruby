# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module CborEventStreams
  module Types

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :message
    # @!attribute message
    #   @return [String]
    EventA = ::Struct.new(
      :message,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [NestedEvent] :nested
    # @!attribute nested
    #   @return [NestedEvent]
    EventB = ::Struct.new(
      :nested,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    class Events < Hearth::Union
      class EventA < Events
        def to_h
          { event_a: super(__getobj__) }
        end

        def to_s
          "#<CborEventStreams::Types::EventA #{__getobj__ || 'nil'}>"
        end
      end

      class EventB < Events
        def to_h
          { event_b: super(__getobj__) }
        end

        def to_s
          "#<CborEventStreams::Types::EventB #{__getobj__ || 'nil'}>"
        end
      end

      class Unknown < Events
        def initialize(name:, value:)
          super({name: name, value: value})
        end

        def to_h
          { unknown: super(__getobj__) }
        end

        def to_s
          "#<CborEventStreams::Types::Unknown #{__getobj__ || 'nil'}>"
        end
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :message
    # @!attribute message
    #   @return [String]
    InitialStructure = ::Struct.new(
      :message,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Array<String>] :member_values
    # @!attribute member_values
    #   @return [Array<String>]
    NestedEvent = ::Struct.new(
      :member_values,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :input_value
    # @!attribute input_value
    #   @return [String]
    NonStreamingOperationInput = ::Struct.new(
      :input_value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :output_value
    # @!attribute output_value
    #   @return [String]
    NonStreamingOperationOutput = ::Struct.new(
      :output_value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Events] :event
    #   @option params [InitialStructure] :initial_structure
    # @!attribute event
    #   @return [Events]
    # @!attribute initial_structure
    #   @return [InitialStructure]
    StartEventStreamInput = ::Struct.new(
      :event,
      :initial_structure,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Events] :event
    #   @option params [InitialStructure] :initial_structure
    # @!attribute event
    #   @return [Events]
    # @!attribute initial_structure
    #   @return [InitialStructure]
    StartEventStreamOutput = ::Struct.new(
      :event,
      :initial_structure,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

  end
end
