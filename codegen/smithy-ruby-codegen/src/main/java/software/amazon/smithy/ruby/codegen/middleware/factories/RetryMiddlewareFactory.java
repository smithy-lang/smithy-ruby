/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

package software.amazon.smithy.ruby.codegen.middleware.factories;

import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;

public final class RetryMiddlewareFactory {
    private RetryMiddlewareFactory() {
    }

    public static Middleware build(GenerationContext context) {
        String retryStrategyDocumentation = """
                Specifies which retry strategy class to use. Strategy classes may have additional
                options, such as `max_retries` and backoff strategies.

                Available options are:
                * `Retry::Standard` - A standardized set of retry rules across the AWS SDKs. This
                  includes support for retry quotas, which limit the number of unsuccessful retries
                  a client can make.
                * `Retry::Adaptive` - An experimental retry mode that includes all the functionality
                  of `standard` mode along with automatic client side throttling. This is a provisional
                  mode that may change behavior in the future.
                """;

        ClientConfig retryStrategy = ClientConfig.builder()
                .name("retry_strategy")
                .type("Hearth::Retry::Strategy")
                .documentationDefaultValue("Hearth::Retry::Standard.new")
                .defaultValue("Hearth::Retry::Standard.new")
                .documentation(retryStrategyDocumentation)
                .build();

        return Middleware.builder()
                .klass(Hearth.RETRY_MIDDLEWARE)
                .step(MiddlewareStackStep.RETRY)
                .addConfig(retryStrategy)
                .addParam("error_inspector_class", context.applicationTransport().getErrorInspector())
                .build();
    }
}
