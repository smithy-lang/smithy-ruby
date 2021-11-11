# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module SampleService
  module Params
    module ComplexList
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, Array, context: context)

        params.each_with_index.map do |element, index|
          if element
            HighScoreAttributes.build(element, context: "#{context}[#{index}]")
          end
        end
      end
    end

    module ComplexMap
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, Hash, context: context)

        data = {}
        params.each do |key, value|
          data[key] =
            HighScoreAttributes.build(
              value,
              context: "#{context}[#{key}]"
            ) if value
        end
        data
      end
    end

    module ComplexSet
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, Set, Array, context: context)
        data = Set.new

        params.each_with_index do |element, index|
          if element
            data <<
              HighScoreAttributes.build(
                element,
                context: "#{context}[#{index}]"
              )
          end
        end
        data
      end
    end

    module CreateHighScoreInput
      def self.build(params, context: '')
        Seahorse::Validator.validate!(
          params,
          Hash,
          Types::CreateHighScoreInput,
          context: context
        )
        type = Types::CreateHighScoreInput.new
        type.high_score =
          HighScoreParams.build(
            params[:high_score],
            context: "#{context}[:high_score]"
          ) if params[:high_score]
        type
      end
    end

    module DeleteHighScoreInput
      def self.build(params, context: '')
        Seahorse::Validator.validate!(
          params,
          Hash,
          Types::DeleteHighScoreInput,
          context: context
        )
        type = Types::DeleteHighScoreInput.new
        type.id = params[:id]
        type
      end
    end

    module EventStream
      def self.build(params, context: '')
        return params if params.is_a?(Types::EventStream)
        Seahorse::Validator.validate!(
          params,
          Hash,
          Types::EventStream,
          context: context
        )

        unless params.size == 1
          raise ArgumentError,
                "Expected #{context} to have exactly one member, got: #{params}"
        end

        key, value = params.flatten
        case key
        when :start
          Types::EventStream::Start.new(
            StructuredEvent.build(params[:start], context: "#{context}[:start]")
          )
        when :end
          Types::EventStream::End.new(
            StructuredEvent.build(params[:end], context: "#{context}[:end]")
          )
        when :log
          Types::EventStream::Log.new(params[:log])
        when :simple_list
          Types::EventStream::SimpleList.new(
            SimpleList.build(
              params[:simple_list],
              context: "#{context}[:simple_list]"
            )
          )
        when :complex_list
          Types::EventStream::ComplexList.new(
            ComplexList.build(
              params[:complex_list],
              context: "#{context}[:complex_list]"
            )
          )
        else
          raise ArgumentError,
                "Expected #{context} to have one of :start, :end, :log, :simple_list, :complex_list set"
        end
      end
    end

    module GetHighScoreInput
      def self.build(params, context: '')
        Seahorse::Validator.validate!(
          params,
          Hash,
          Types::GetHighScoreInput,
          context: context
        )
        type = Types::GetHighScoreInput.new
        type.id = params[:id]
        type
      end
    end

    module HighScoreAttributes
      def self.build(params, context: '')
        Seahorse::Validator.validate!(
          params,
          Hash,
          Types::HighScoreAttributes,
          context: context
        )
        type = Types::HighScoreAttributes.new
        type.id = params[:id]
        type.game = params[:game]
        type.score = params[:score]
        type.created_at = params[:created_at]
        type.updated_at = params[:updated_at]
        type.simple_list =
          SimpleList.build(
            params[:simple_list],
            context: "#{context}[:simple_list]"
          ) if params[:simple_list]
        type.complex_list =
          ComplexList.build(
            params[:complex_list],
            context: "#{context}[:complex_list]"
          ) if params[:complex_list]
        type.simple_map =
          SimpleMap.build(
            params[:simple_map],
            context: "#{context}[:simple_map]"
          ) if params[:simple_map]
        type.complex_map =
          ComplexMap.build(
            params[:complex_map],
            context: "#{context}[:complex_map]"
          ) if params[:complex_map]
        type.simple_set =
          SimpleSet.build(
            params[:simple_set],
            context: "#{context}[:simple_set]"
          ) if params[:simple_set]
        type.complex_set =
          ComplexSet.build(
            params[:complex_set],
            context: "#{context}[:complex_set]"
          ) if params[:complex_set]
        type.event_stream =
          EventStream.build(
            params[:event_stream],
            context: "#{context}[:event_stream]"
          ) if params[:event_stream]
        type
      end
    end

    module HighScoreParams
      def self.build(params, context: '')
        Seahorse::Validator.validate!(
          params,
          Hash,
          Types::HighScoreParams,
          context: context
        )
        type = Types::HighScoreParams.new
        type.game = params[:game]
        type.score = params[:score]
        type.simple_list =
          SimpleList.build(
            params[:simple_list],
            context: "#{context}[:simple_list]"
          ) if params[:simple_list]
        type.complex_list =
          ComplexList.build(
            params[:complex_list],
            context: "#{context}[:complex_list]"
          ) if params[:complex_list]
        type.simple_map =
          SimpleMap.build(
            params[:simple_map],
            context: "#{context}[:simple_map]"
          ) if params[:simple_map]
        type.complex_map =
          ComplexMap.build(
            params[:complex_map],
            context: "#{context}[:complex_map]"
          ) if params[:complex_map]
        type.simple_set =
          SimpleSet.build(
            params[:simple_set],
            context: "#{context}[:simple_set]"
          ) if params[:simple_set]
        type.complex_set =
          ComplexSet.build(
            params[:complex_set],
            context: "#{context}[:complex_set]"
          ) if params[:complex_set]
        type.event_stream =
          EventStream.build(
            params[:event_stream],
            context: "#{context}[:event_stream]"
          ) if params[:event_stream]
        type
      end
    end

    module ListHighScoresInput
      def self.build(params, context: '')
        Seahorse::Validator.validate!(
          params,
          Hash,
          Types::ListHighScoresInput,
          context: context
        )
        type = Types::ListHighScoresInput.new
        type.max_results = params[:max_results]
        type.next_token = params[:next_token]
        type
      end
    end

    module SimpleList
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, Array, context: context)

        params.each_with_index.map { |element, index| element }
      end
    end

    module SimpleMap
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, Hash, context: context)

        data = {}
        params.each { |key, value| data[key] = value }
        data
      end
    end

    module SimpleSet
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, Set, Array, context: context)
        data = Set.new

        params.each_with_index { |element, index| data << element }
        data
      end
    end

    module StructuredEvent
      def self.build(params, context: '')
        Seahorse::Validator.validate!(
          params,
          Hash,
          Types::StructuredEvent,
          context: context
        )
        type = Types::StructuredEvent.new
        type.message = params[:message]
        type
      end
    end

    module UpdateHighScoreInput
      def self.build(params, context: '')
        Seahorse::Validator.validate!(
          params,
          Hash,
          Types::UpdateHighScoreInput,
          context: context
        )
        type = Types::UpdateHighScoreInput.new
        type.id = params[:id]
        type.high_score =
          HighScoreParams.build(
            params[:high_score],
            context: "#{context}[:high_score]"
          ) if params[:high_score]
        type
      end
    end
  end
end
