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

import java.util.List;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.config.RespondsToConstraint;
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
        String retryStrategyTypes = "#acquire_initial_retry_token(token_scope),"
            + "#refresh_retry_token(retry_token, error_info),#record_success(retry_token)";
        ClientConfig retryStrategy = ClientConfig.builder()
                .name("retry_strategy")
                .type(retryStrategyTypes)
                .defaultValue("Hearth::Retry::Standard.new")
                .documentation(retryStrategyDocumentation)
                .documentationDefaultValue("Hearth::Retry::Standard.new")
                .constraint(
                        new RespondsToConstraint(
                                List.of("acquire_initial_retry_token", "refresh_retry_token", "record_success"))
                )
                .build();

        return Middleware.builder()
                .klass(Hearth.RETRY_MIDDLEWARE)
                .step(MiddlewareStackStep.RETRY)
                .addConfig(retryStrategy)
                .addParam("error_inspector_class", context.applicationTransport().getErrorInspector())
                .build();
    }
}
