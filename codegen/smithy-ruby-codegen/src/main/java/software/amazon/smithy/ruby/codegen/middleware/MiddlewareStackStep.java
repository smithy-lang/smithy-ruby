package software.amazon.smithy.ruby.codegen.middleware;

/**
 * Represents the middleware stack step.
 */
public enum MiddlewareStackStep {
    INITIALIZE,
    SERIALIZE,
    BUILD,
    RETRY,
    FINALIZE,
    DESERIALIZE,
    SEND;

    @Override
    public String toString() {
        switch (this) {
            case INITIALIZE:
                return "Initialize";
            case RETRY:
                return "Retry";
            case SERIALIZE:
                return "Serialize";
            case BUILD:
                return "Build";
            case DESERIALIZE:
                return "Deserialize";
            case FINALIZE:
                return "Finalize";
            case SEND:
                return "Send";
            default:
                return "Unknown";
        }
    }
}
