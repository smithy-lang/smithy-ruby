$version: "1.0"
namespace example.rails

use smithy.rails#RailsJson
use smithy.rails#errorOn

/// Rails High Score example from their generator docs
@RailsJson
@errorOn(location: "header", name: "x-smithy-error")
service SampleService {
    version: "2021-02-15",
    resources: [HighScore],
}

/// Rails default scaffold operations
resource HighScore {
    identifiers: { id: String },
    read: GetHighScore,
    create: CreateHighScore,
    update: UpdateHighScore,
    delete: DeleteHighScore,
    list: ListHighScores
}

/// Modeled attributes for a High Score
structure HighScoreAttributes {
    /// The high score id
    id: String,
    /// The game for the high score
    game: String,
    /// The high score for the game
    score: Integer,
    // The time the high score was created at
    createdAt: Timestamp,
    // The time the high score was updated at
    updatedAt: Timestamp
}

/// Permitted params for a High Score
structure HighScoreParams {
    /// The game for the high score
    game: String,
    /// The high score for the game
    score: Integer
}

/// Get a high score
@http(method: "GET", uri: "/high_scores/{id}")
@readonly
operation GetHighScore {
    input: GetHighScoreInput,
    output: GetHighScoreOutput
}

structure GetHighScoreInput {
    /// The high score id
    @required
    @httpLabel
    id: String
}

structure GetHighScoreOutput {
    @httpPayload
    highScore: HighScoreAttributes
}

/// Create a new high score
@http(method: "POST", uri: "/high_scores", code: 201)
operation CreateHighScore {
    input: CreateHighScoreInput,
    output: CreateHighScoreOutput,
    errors: [UnprocessableEntityError]
}

structure CreateHighScoreInput {
    /// The high score params
    highScore: HighScoreParams
}

structure CreateHighScoreOutput {
    @httpPayload
    highScore: HighScoreAttributes,

    @httpHeader("Location")
    location: String
}

/// Update a high score
@http(method: "PUT", uri: "/high_scores/{id}")
@idempotent
operation UpdateHighScore {
    input: UpdateHighScoreInput,
    output: UpdateHighScoreOutput,
    errors: [UnprocessableEntityError]
}

structure UpdateHighScoreInput {
    /// The high score id
    @required
    @httpLabel
    id: String,

    /// The high score params
    highScore: HighScoreParams
}

structure UpdateHighScoreOutput {
    @httpPayload
    highScore: HighScoreAttributes
}

/// Delete a high score
@http(method: "DELETE", uri: "/high_scores/{id}")
@idempotent
operation DeleteHighScore {
    input: DeleteHighScoreInput,
    output: DeleteHighScoreOutput
}

structure DeleteHighScoreInput {
    /// The high score id
    @required
    @httpLabel
    id: String
}

structure DeleteHighScoreOutput {}

/// List all high scores
@http(method: "GET", uri: "/high_scores")
@readonly
operation ListHighScores {
    input: ListHighScoresInput,
    output: ListHighScoresOutput
}

structure ListHighScoresInput {}

structure ListHighScoresOutput {
    @httpPayload
    highScores: HighScores
}

list HighScores {
    member: HighScoreAttributes
}

/// Raised when high score is invalid
@error("client")
@httpError(422)
structure UnprocessableEntityError {
    errors: AttributeErrors
}

map AttributeErrors {
    key: String,
    value: ErrorMessages
}

list ErrorMessages {
    member: String
}
