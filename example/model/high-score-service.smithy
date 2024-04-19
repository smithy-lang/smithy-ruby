$version: "1.0"

namespace myapp

use smithy.ruby.protocols#railsJson
use smithy.ruby.protocols#UnprocessableEntityError
//use smithy.waiters#waitable

//apply UnprocessableEntityError @retryable

/// Rails High Score example from their generator docs
@railsJson
@title("High Score Sample Rails Service")
service HighScoreService {
    version: "2021-02-15",
    resources: [HighScore]
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
//@waitable(
//    HighScoreExists: {
//        documentation: "Waits until a high score has been created",
//        acceptors: [
//            // Fail-fast if the thing does not exist.
//            {
//                state: "retry",
//                matcher: {
//                    errorType: "NotFoundError"
//                }
//            },
//            // Succeed when the response is successful.
//            {
//                state: "success",
//                matcher: {
//                    success: true
//                }
//            }
//        ]
//    }
//)
operation GetHighScore {
    input: GetHighScoreInput,
    output: GetHighScoreOutput
}

/// Input structure for GetHighScore
structure GetHighScoreInput {
    /// The high score id
    @required
    @httpLabel
    id: String
}

/// Output structure for GetHighScore
structure GetHighScoreOutput {
    /// The high score attributes
    @httpPayload
    highScore: HighScoreAttributes,
}

/// Create a new high score
@http(method: "POST", uri: "/high_scores", code: 201)
operation CreateHighScore {
    input: CreateHighScoreInput,
    output: CreateHighScoreOutput,
    errors: [UnprocessableEntityError]
}

/// Input structure for CreateHighScore
structure CreateHighScoreInput {
    /// The high score params
    @required
    highScore: HighScoreParams
}

/// Output structure for CreateHighScore
structure CreateHighScoreOutput {
    /// The high score attributes
    @httpPayload
    highScore: HighScoreAttributes,

    /// The location of the high score
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

/// Input structure for UpdateHighScore
structure UpdateHighScoreInput {
    /// The high score id
    @required
    @httpLabel
    id: String,

    /// The high score params
    highScore: HighScoreParams
}

/// Output structure for UpdateHighScore
structure UpdateHighScoreOutput {
    /// The high score attributes
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

/// Input structure for DeleteHighScore
structure DeleteHighScoreInput {
    /// The high score id
    @required
    @httpLabel
    id: String
}

/// Output structure for DeleteHighScore
structure DeleteHighScoreOutput {}

/// List all high scores
@http(method: "GET", uri: "/high_scores")
@readonly
//@paginated(inputToken: "nextToken", outputToken: "nextToken",
//           pageSize: "maxResults", items: "highScores")
operation ListHighScores {
    input: ListHighScoresInput,
    output: ListHighScoresOutput
}

structure ListHighScoresInput {
//    /// The next token to use for pagination
//    @httpQuery("nextToken")
//    nextToken: String,
//
//    /// The maximum number of results to return
//    @httpQuery("maxResults")
//    maxResults: Integer
}

/// Output structure for ListHighScores
structure ListHighScoresOutput {
    /// A list of high scores
    @httpPayload
    highScores: HighScores,

//    /// The next token to use for pagination
//    @httpHeader("nextToken")
//    nextToken: String
}

list HighScores {
    member: HighScoreAttributes
}