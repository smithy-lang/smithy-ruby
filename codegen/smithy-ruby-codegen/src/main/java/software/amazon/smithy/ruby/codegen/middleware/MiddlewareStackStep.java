/*
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

package software.amazon.smithy.ruby.codegen.middleware;

import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * Represents the middleware stack step.
 *
 * Steps represent the conceptual boundaries in the middleware stack
 * and are used to organize different middleware components based on their intent.
 */
@SmithyUnstableApi
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
