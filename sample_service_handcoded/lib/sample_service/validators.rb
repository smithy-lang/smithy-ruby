module SampleService
  # @api private
  module Validators

    class HighScoreParams
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:game], String, context: "#{context}[:game]")
        Seahorse::Validator.validate!(input[:score], Integer, context: "#{context}[:score]")
        SimpleList.validate!(input[:simple_list], context: "#{context}[:simple_list]")
        ComplexList.validate!(input[:complex_list], context: "#{context}[:complex_list]")
        SimpleMap.validate!(input[:simple_map], context: "#{context}[:simple_map]")
        ComplexMap.validate!(input[:complex_map], context: "#{context}[:complex_map]")
      end
    end

    class GetHighScoreInput
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:id], String, context: "#{context}[:id]")
      end
    end

    class CreateHighScoreInput
      def self.validate!(input, context:)
        HighScoreParams.validate!(input[:high_score], context: "#{context}[:high_score]")
      end
    end

    class UpdateHighScoreInput
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:id], String, context: "#{context}[:id]")
        HighScoreParams.validate!(input[:high_score], context: "#{context}[:high_score]")
      end
    end

    class DeleteHighScoreInput
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:id], String, context: "#{context}[:id]")
      end
    end

    class ListHighScoresInput
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:max_results], Integer, context: "#{context}[:max_results]")
        Seahorse::Validator.validate!(input[:next_token], String, context: "#{context}[:next_token]")
      end
    end

    class StreamInputOutput
      def self.validate!(input, context:)
        v = Seahorse::Validator.new(input, context: context)
        Seahorse::Validator.validate!(input[:stream_id], String, context: "#{context}[:stream_id]")
        Seahorse::Validator.validate!(input[:blob], String, context: "#{context}[:blob]")
      end
    end

    class HighScoreAttributes
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:id], String, context: "#{context}[:id]")
        Seahorse::Validator.validate!(input[:game], String, context: "#{context}[:game]")
        # ...
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

    class ComplexList
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input, Array, context: context)
        input.each_with_index do |element, index|
          HighScoreAttributes.validate!(element, context: "#{context}[#{index}]")
        end
      end
    end

    class SimpleMap
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input, Hash, context: context)
        input.each do |key, value|
          Seahorse::Validator.validate!(key, String, Symbol, context: "#{context}.keys")
          Seahorse::Validator.validate!(value, Integer, context: "#{context}[:#{key}]")
        end
      end
    end

    class ComplexMap
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input, Hash, context: context)
        input.each do |key, value|
          Seahorse::Validator.validate!(key, String, Symbol, context: "#{context}.keys")
          HighScoreAttributes.validate!(value, context: "#{context}[:#{key}]")
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

    class ComplexSet
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input, Set, context: context)
        input.each_with_index do |element, index|
          HighScoreAttributes.validate!(element, context: "#{context}[#{index}]")
        end
      end
    end

    class StructuredEvent
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:message], String, context: "#{context}[:message]")
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
        when Types::EventStream::Unknown
          nil
        else
          raise ArgumentError,
                "Expected #{context} to be a union member of "\
                "Types::EventStream, got #{input.class}."
        end
      end

      class Start
        def self.validate!(input, context:)
          StructuredEvent.validate!(input, context: context)
        end
      end

      class End
        def self.validate!(input, context:)
          StructuredEvent.validate!(input, context: context)
        end
      end

      class Log
        def self.validate!(input, context:)
          Seahorse::Validator.validate!(input, String, context: context)
        end
      end
    end

  end
end
