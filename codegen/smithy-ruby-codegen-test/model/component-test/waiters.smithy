$version: "1.0"
namespace smithy.ruby.tests

use smithy.waiters#waitable

@waitable(
    ResourceExists: {
        documentation: "Test that this waiter exists",
        minDelay: 10,
        maxDelay: 100,
        deprecated: true,
        acceptors: [
            {
                state: "success",
                matcher: {
                    success: true
                }
            },
            {
                state: "retry",
                matcher: {
                    errorType: "NotFound"
                }
            },
            {
                state: "failure",
                matcher: {
                    output: {
                        path: "Status",
                        comparator: "stringEquals",
                        expected: "failed"
                    }
                }
            },
            {
                state: "failure",
                matcher: {
                    inputOutput: {
                        path: "input.Status == 'failed' || output.Status == 'failed'",
                        comparator: "booleanEquals",
                        expected: "true"
                    }
                }
            }
        ],
        tags: ["waiter", "test"]
    }
)
operation WaitersTest {
    input: WaitersTestInputOutput,
    output: WaitersTestInputOutput
}

structure WaitersTestInputOutput {
    Status: String
}