$version: "1.0"
namespace example.rails
use smithy.rails#RailsJson
use smithy.rails#errorOn

/// Rails High Score example from their generator docs
@RailsJson
@errorOn(location: "header", name: "x-rails-errorcode")
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
    id: Integer,
    game: String,
    score: Integer,
    createdAt: Timestamp,
    updatedAt: Timestamp,
    @httpHeader("Location")
    location: String
}
/// Permitted params for a High Score
structure HighScoreParams {
    game: String,
    score: Integer
}
/// Get a high score
@http(method: "GET", uri: "/high_scores/{id}")
@readonly
@errorOn(location: "header", name: "x-rails-errorcode")
operation GetHighScore {
    input: GetHighScoreInput,
    output: GetHighScoreOutput
}
structure GetHighScoreInput {
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
    output: CreateHighScoreOutput
}
structure CreateHighScoreInput {
    highScore: HighScoreParams
}
structure CreateHighScoreOutput {
    @httpPayload
    highScore: HighScoreAttributes
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
    @required
    @httpLabel
    id: String,
    highScore: HighScoreParams
}
structure UpdateHighScoreOutput {
    @httpPayload
    highScore: HighScoreAttributes
}
/// Delete high score
@http(method: "DELETE", uri: "/high_scores/{id}")
@idempotent
operation DeleteHighScore {
    input: DeleteHighScoreInput,
    output: DeleteHighScoreOutput
}
structure DeleteHighScoreInput {
    @required
    @httpLabel
    id: String
}
structure DeleteHighScoreOutput {}
@http(method: "GET", uri: "/high_scores")
@readonly
operation ListHighScores {
    output: ListHighScoresOutput
}

// TODO use @httpPayload when it's relaxed for lists
structure ListHighScoresOutput {
    highScores: HighScoreSummaries
}
list HighScoreSummaries {
    member: HighScoreAttributes
}

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