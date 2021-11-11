# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module SampleService
  module Types

    class EventStream < Seahorse::Union
      class Start < EventStream
        def to_h
          {start: super(__getobj__)}
        end
      end
      class End < EventStream
        def to_h
          {end: super(__getobj__)}
        end
      end
      class Log < EventStream
        def to_h
          {log: super(__getobj__)}
        end
      end
      class SimpleList < EventStream
        def to_h
          {simple_list: super(__getobj__)}
        end
      end
      class ComplexList < EventStream
        def to_h
          {complex_list: super(__getobj__)}
        end
      end
      class Unknown < EventStream; end
    end

    HighScoreAttributes = Struct.new(
      :id,
      :game,
      :score,
      :created_at,
      :updated_at,
      :simple_list,
      :complex_list,
      :simple_map,
      :complex_map,
      :simple_set,
      :complex_set,
      :event_stream,
      :inline_document,
      keyword_init: true
    ) { include Seahorse::Structure }

    HighScoreParams = Struct.new(
      :game,
      :score,
      :simple_list,
      :complex_list,
      :simple_map,
      :complex_map,
      :simple_set,
      :complex_set,
      :event_stream,
      :inline_document,
      keyword_init: true
    ) { include Seahorse::Structure }

    StructuredEvent = Struct.new(
      :message,
      keyword_init: true
    ) { include Seahorse::Structure }

    UnprocessableEntityError = Struct.new(
      :errors,
      keyword_init: true
    ) { include Seahorse::Structure }

    CreateHighScoreInput = Struct.new(
      :high_score,
      keyword_init: true
    ) { include Seahorse::Structure }

    CreateHighScoreOutput = Struct.new(
      :high_score,
      :location,
      keyword_init: true
    ) { include Seahorse::Structure }

    DeleteHighScoreInput = Struct.new(
      :id,
      keyword_init: true
    ) { include Seahorse::Structure }

    DeleteHighScoreOutput = Struct.new(
      nil,
      keyword_init: true
    ) { include Seahorse::Structure }

    GetHighScoreInput = Struct.new(
      :id,
      keyword_init: true
    ) { include Seahorse::Structure }

    GetHighScoreOutput = Struct.new(
      :high_score,
      keyword_init: true
    ) { include Seahorse::Structure }

    ListHighScoresInput = Struct.new(
      :max_results,
      :next_token,
      keyword_init: true
    ) { include Seahorse::Structure }

    ListHighScoresOutput = Struct.new(
      :next_token,
      :high_scores,
      keyword_init: true
    ) { include Seahorse::Structure }

    UpdateHighScoreInput = Struct.new(
      :id,
      :high_score,
      keyword_init: true
    ) { include Seahorse::Structure }

    UpdateHighScoreOutput = Struct.new(
      :high_score,
      keyword_init: true
    ) { include Seahorse::Structure }
  end
end
