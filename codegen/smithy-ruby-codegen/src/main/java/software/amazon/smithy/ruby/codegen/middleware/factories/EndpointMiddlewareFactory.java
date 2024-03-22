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

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.config.RespondsToConstraint;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;

public final class EndpointMiddlewareFactory {
    private EndpointMiddlewareFactory() {
    }

    public static Middleware build(GenerationContext context) {
        String endpointProviderDocumentation = """
                The endpoint provider used to resolve endpoints. Any object that responds to
                `#resolve(parameters)`
                """;
        ClientConfig endpointProviderConfig = ClientConfig.builder()
                .name("endpoint_provider")
                .type("#resolve(params)")
                .defaultValue("Endpoint::Provider.new")
                .documentation(endpointProviderDocumentation)
                .constraint(new RespondsToConstraint(List.of("resolve")))
                .build();

        return Middleware.builder()
                .klass(Hearth.ENDPOINT_MIDDLEWARE)
                .step(MiddlewareStackStep.AFTER_BUILD)
                .addConfig(endpointProviderConfig)
                .relative(Middleware.Relative.builder()
                        .after(Hearth.AUTH_MIDDLEWARE)
                        .build())
                .operationParams((ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    params.put("param_builder",
                            "Endpoint::Parameters::" + context.symbolProvider().toSymbol(operation).getName());
                    context.getBuiltInBindingsFromEndpointRules().forEach((b) -> {
                        b.getClientConfig().forEach((c) -> params.put(c.getName(), c.renderGetConfigValue()));
                    });
                    context.getModeledClientConfig().forEach((c) -> params.put(c.getName(), c.renderGetConfigValue()));

                    return params;
                })
                .build();
    }
}
