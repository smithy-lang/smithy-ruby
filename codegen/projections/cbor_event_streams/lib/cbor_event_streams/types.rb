# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module CborEventStreams
  module Types

    class Events < Hearth::Union
      class SimpleEvent < Events
        def to_h
          { simple_event: super(__getobj__) }
        end

        def to_s
          "#<CborEventStreams::Types::SimpleEvent #{__getobj__ || 'nil'}>"
        end
      end

      class NestedEvent < Events
        def to_h
          { nested_event: super(__getobj__) }
        end

        def to_s
          "#<CborEventStreams::Types::NestedEvent #{__getobj__ || 'nil'}>"
        end
      end

      class ExplicitPayloadEvent < Events
        def to_h
          { explicit_payload_event: super(__getobj__) }
        end

        def to_s
          "#<CborEventStreams::Types::ExplicitPayloadEvent #{__getobj__ || 'nil'}>"
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
    #   @option params [String] :header_a
    #   @option params [NestedStructure] :payload
    # @!attribute header_a
    #   @return [String]
    # @!attribute payload
    #   @return [NestedStructure]
    class ExplicitPayloadEvent
      include Hearth::Structure

      MEMBERS = %i[
        header_a
        payload
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :message
    #   @option params [NestedStructure] :nested
    # @!attribute message
    #   @return [String]
    # @!attribute nested
    #   @return [NestedStructure]
    class InitialStructure
      include Hearth::Structure

      MEMBERS = %i[
        message
        nested
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [NestedStructure] :nested
    # @!attribute nested
    #   @return [NestedStructure]
    class NestedEvent
      include Hearth::Structure

      MEMBERS = %i[
        nested
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Array<String>] :values
    # @!attribute values
    #   @return [Array<String>]
    class NestedStructure
      include Hearth::Structure

      MEMBERS = %i[
        values
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :input_value
    # @!attribute input_value
    #   @return [String]
    class NonStreamingOperationInput
      include Hearth::Structure

      MEMBERS = %i[
        input_value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :output_value
    # @!attribute output_value
    #   @return [String]
    class NonStreamingOperationOutput
      include Hearth::Structure

      MEMBERS = %i[
        output_value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :message
    # @!attribute message
    #   @return [String]
    class SimpleEvent
      include Hearth::Structure

      MEMBERS = %i[
        message
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Events] :event
    #   @option params [InitialStructure] :initial_structure
    # @!attribute event
    #   @return [Events]
    # @!attribute initial_structure
    #   @return [InitialStructure]
    class StartEventStreamInput
      include Hearth::Structure

      MEMBERS = %i[
        event
        initial_structure
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Events] :event
    #   @option params [InitialStructure] :initial_structure
    # @!attribute event
    #   @return [Events]
    # @!attribute initial_structure
    #   @return [InitialStructure]
    class StartEventStreamOutput
      include Hearth::Structure

      MEMBERS = %i[
        event
        initial_structure
      ].freeze

      attr_accessor(*MEMBERS)
    end

  end
end
