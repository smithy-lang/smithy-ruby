$version: "1.0"
namespace smithy.ruby.tests

use smithy.waiters#waitable

@waitable(
    ResourceExists: {
        documentation: "Test that this waiter exists",
        minDelay: 10,
        maxDelay: 100,
        deprecated: true, // todo - implement
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