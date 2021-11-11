# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module SampleService
  module Validators

    class ComplexList
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input, Array, context: context)
        input.each_with_index do |element, index|
          HighScoreAttributes.validate!(element, context: "#{context}[#{index}]") if element
        end
      end
    end

    class ComplexMap
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input, Hash, context: context)
        input.each do |key, value|
          Seahorse::Validator.validate!(key, String, Symbol, context: "#{context}.keys")
          HighScoreAttributes.validate!(value, context: "#{context}[#{key}]") if value
        end
      end
    end

    class ComplexSet
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input, Set, context: context)
        input.each_with_index do |element, index|
          HighScoreAttributes.validate!(element, context: "#{context}[#{index}]") if element
        end
      end
    end

    class CreateHighScoreInput
      def self.validate!(input, context:)
        HighScoreParams.validate!(input[:high_score], context: "#{context}[:high_score]") if input[:high_score]
      end
    end

    class DeleteHighScoreInput
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:id], String, context: "#{context}[:id]")
      end
    end

    class Document
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input, Hash, String, Array, TrueClass, FalseClass, Numeric, context: context)
        case input
        when Hash
          input.each do |k,v|
            validate!(v, context: context + "[#{k}]")
          end
        when Array
          input.each_with_index do |v, i|
            validate!(v, context: context + "[#{i}]")
          end
        end
      end
    end

    class EventStream
      def self.validate!(input, context:)
        case input
        when Types::EventStream::Start
          Start.validate!(input.__getobj__, context: context)
        when Types::EventStream::End
          End.validate!(input.__getobj__, context: context)
        when Types::EventStream::Log
          Log.validate!(input.__getobj__, context: context)
        when Types::EventStream::SimpleList
          SimpleList.validate!(input.__getobj__, context: context)
        when Types::EventStream::ComplexList
          ComplexList.validate!(input.__getobj__, context: context)
        when Types::EventStream::Unknown
          nil
        else
          raise ArgumentError,
                "Expect #{context} to be a union member of "\
                "Types::EventStream, got #{input.class}."
        end
      end

      class Start
        def self.validate!(input, context:)
          StructuredEvent.validate!(input, context: context) if input
        end
      end

      class End
        def self.validate!(input, context:)
          StructuredEvent.validate!(input, context: context) if input
        end
      end

      class Log
        def self.validate!(input, context:)
          Seahorse::Validator.validate!(input, String, context: context)
        end
      end

      class SimpleList
        def self.validate!(input, context:)
          SimpleList.validate!(input, context: context) if input
        end
      end

      class ComplexList
        def self.validate!(input, context:)
          ComplexList.validate!(input, context: context) if input
        end
      end
    end

    class GetHighScoreInput
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:id], String, context: "#{context}[:id]")
      end
    end

    class HighScoreAttributes
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:id], String, context: "#{context}[:id]")
        Seahorse::Validator.validate!(input[:game], String, context: "#{context}[:game]")
        Seahorse::Validator.validate!(input[:score], Integer, context: "#{context}[:score]")
        Seahorse::Validator.validate!(input[:created_at], Time, context: "#{context}[:created_at]")
        Seahorse::Validator.validate!(input[:updated_at], Time, context: "#{context}[:updated_at]")
        SimpleList.validate!(input[:simple_list], context: "#{context}[:simple_list]") if input[:simple_list]
        ComplexList.validate!(input[:complex_list], context: "#{context}[:complex_list]") if input[:complex_list]
        SimpleMap.validate!(input[:simple_map], context: "#{context}[:simple_map]") if input[:simple_map]
        ComplexMap.validate!(input[:complex_map], context: "#{context}[:complex_map]") if input[:complex_map]
        SimpleSet.validate!(input[:simple_set], context: "#{context}[:simple_set]") if input[:simple_set]
        ComplexSet.validate!(input[:complex_set], context: "#{context}[:complex_set]") if input[:complex_set]
        EventStream.validate!(input[:event_stream], context: "#{context}[:event_stream]") if input[:event_stream]
        Document.validate!(input[:inline_document], context: "#{context}[:inline_document]") if input[:inline_document]
      end
    end

    class HighScoreParams
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:game], String, context: "#{context}[:game]")
        Seahorse::Validator.validate!(input[:score], Integer, context: "#{context}[:score]")
        SimpleList.validate!(input[:simple_list], context: "#{context}[:simple_list]") if input[:simple_list]
        ComplexList.validate!(input[:complex_list], context: "#{context}[:complex_list]") if input[:complex_list]
        SimpleMap.validate!(input[:simple_map], context: "#{context}[:simple_map]") if input[:simple_map]
        ComplexMap.validate!(input[:complex_map], context: "#{context}[:complex_map]") if input[:complex_map]
        SimpleSet.validate!(input[:simple_set], context: "#{context}[:simple_set]") if input[:simple_set]
        ComplexSet.validate!(input[:complex_set], context: "#{context}[:complex_set]") if input[:complex_set]
        EventStream.validate!(input[:event_stream], context: "#{context}[:event_stream]") if input[:event_stream]
        Document.validate!(input[:inline_document], context: "#{context}[:inline_document]") if input[:inline_document]
      end
    end

    class ListHighScoresInput
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:max_results], Integer, context: "#{context}[:max_results]")
        Seahorse::Validator.validate!(input[:next_token], String, context: "#{context}[:next_token]")
      end
    end

    class SimpleList
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input, Array, context: context)
        input.each_with_index do |element, index|
          Seahorse::Validator.validate!(element, String, context: "#{context}[#{index}]")
        end
      end
    end

    class SimpleMap
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input, Hash, context: context)
        input.each do |key, value|
          Seahorse::Validator.validate!(key, String, Symbol, context: "#{context}.keys")
          Seahorse::Validator.validate!(value, Integer, context: "#{context}[#{key}]")
        end
      end
    end

    class SimpleSet
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input, Set, context: context)
        input.each_with_index do |element, index|
          Seahorse::Validator.validate!(element, String, context: "#{context}[#{index}]")
        end
      end
    end

    class StructuredEvent
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:message], String, context: "#{context}[:message]")
      end
    end

    class UpdateHighScoreInput
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:id], String, context: "#{context}[:id]")
        HighScoreParams.validate!(input[:high_score], context: "#{context}[:high_score]") if input[:high_score]
      end
    end
  end
end
