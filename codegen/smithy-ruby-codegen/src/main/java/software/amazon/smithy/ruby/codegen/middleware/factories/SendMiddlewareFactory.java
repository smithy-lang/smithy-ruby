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
import java.util.Map;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.ruby.codegen.ApplicationTransport;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.config.ClientConfig;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareFactory;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;

public final class SendMiddlewareFactory implements MiddlewareFactory {
    private SendMiddlewareFactory() {
    }

    public static Middleware build(GenerationContext context) {
        ApplicationTransport transport = context.applicationTransport();
        SymbolProvider symbolProvider = context.symbolProvider();

        String stubResponsesDocumentation = """
                Enable response stubbing for testing. See {Hearth::ClientStubs#stub_responses}.
                """;
        ClientConfig stubResponses = ClientConfig.builder()
                .name("stub_responses")
                .type("Boolean")
                .defaultPrimitiveValue("false")
                .documentation(stubResponsesDocumentation)
                .build();

        return Middleware.builder()
                .klass(Hearth.SEND_MIDDLEWARE)
                .step(MiddlewareStackStep.SEND)
                .addParam("client", transport.getTransportClient().render(context))
                .addParam("stubs", "@stubs")
                .operationParams((ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    params.put("stub_data_class", "Stubs::" + symbolProvider.toSymbol(operation).getName());
                    String errors = operation.getErrors()
                            .stream()
                            .map((error) -> "Stubs::"
                                    + ctx.symbolProvider().toSymbol(ctx.model().expectShape(error)).getName())
                            .collect(Collectors.joining(", "));
                    params.put("stub_error_classes", "[" + errors + "]");
                    return params;
                })
                .addConfig(stubResponses)
                .build();
    }
}
