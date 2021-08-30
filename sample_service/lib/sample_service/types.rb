# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module SampleService
  module Types

    HighScoreAttributes = Struct.new(
      :id,
      :game,
      :score,
      :created_at,
      :updated_at,
      keyword_init: true
    )

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
      keyword_init: true
    )

    StructuredEvent = Struct.new(
      :message,
      keyword_init: true
    )

    CreateHighScoreInput = Struct.new(
      :high_score,
      keyword_init: true
    )

    CreateHighScoreOutput = Struct.new(
      :high_score,
      :location,
      keyword_init: true
    )

    DeleteHighScoreInput = Struct.new(
      :id,
      keyword_init: true
    )

    DeleteHighScoreOutput = Struct.new(
      nil,
      keyword_init: true
    )

    GetHighScoreInput = Struct.new(
      :id,
      keyword_init: true
    )

    GetHighScoreOutput = Struct.new(
      :high_score,
      keyword_init: true
    )

    ListHighScoresInput = Struct.new(
      :max_results,
      :next_token,
      keyword_init: true
    )

    ListHighScoresOutput = Struct.new(
      :next_token,
      :high_scores,
      keyword_init: true
    )

    UpdateHighScoreInput = Struct.new(
      :id,
      :high_score,
      keyword_init: true
    )

    UpdateHighScoreOutput = Struct.new(
      :high_score,
      keyword_init: true
    )
  end
end
