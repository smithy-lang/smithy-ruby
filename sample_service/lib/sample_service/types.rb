module SampleService
  module Types
    HighScoreParams = Struct.new(
      :game,
      :score,
      :time,
      keyword_init: true
    )

    HighScoreAttributes = Struct.new(
      :id,
      :game,
      :score,
      :time,
      :created_at,
      :updated_at,
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

    CreateHighScoreInput = Struct.new(
      :high_score,
      keyword_init: true
    )

    CreateHighScoreOutput = Struct.new(
      :high_score,
      :location,
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

    DeleteHighScoreInput = Struct.new(
      :id,
      keyword_init: true
    )

    DeleteHighScoreOutput = Struct.new(
      nil,
      keyword_init: true
    )

    ListHighScoresInput = Struct.new(
      nil,
      keyword_init: true
    )

    ListHighScoresOutput = Struct.new(
      :high_scores,
      keyword_init: true
    )

    UnprocessableEntityError = Struct.new(
      :errors,
      keyword_init: true
    )
  end
end
