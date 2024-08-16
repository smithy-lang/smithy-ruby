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
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;
import software.amazon.smithy.ruby.codegen.util.Streaming;

public final class SendMiddlewareFactory {
    private SendMiddlewareFactory() {
    }

    public static Middleware build(GenerationContext context, ApplicationTransport transport, boolean eventStream) {
        SymbolProvider symbolProvider = context.symbolProvider();

        String stubResponsesDocumentation = """
                Enable response stubbing for testing. See {Hearth::ClientStubs#stub_responses}.
                """;
        ClientConfig stubResponses = ClientConfig.builder()
                .name("stub_responses")
                .defaultValue("false")
                .documentation(stubResponsesDocumentation)
                .documentationRbsAndValidationType("Boolean")
                .build();

        String stubsDocumentation = """
                Stubs to use with `stub_responses`.  See {Hearth::ClientStubs#stub_responses}.
                """;
        ClientConfig stubs = ClientConfig.builder()
                .name("stubs")
                .defaultValue(Hearth.STUBS + ".new")
                .documentation(stubResponsesDocumentation)
                .documentationRbsAndValidationType(Hearth.STUBS.toString())
                .build();

        return Middleware.builder()
                .klass(Hearth.SEND_MIDDLEWARE)
                .step(MiddlewareStackStep.SEND)
                .addParam("client", transport.getTransportClient().render(context))
                .operationParams((ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    params.put("stub_data_class", "Stubs::" + symbolProvider.toSymbol(operation).getName());
                    String errors = operation.getErrors()
                            .stream()
                            .map((error) -> "Stubs::"
                                    + ctx.symbolProvider().toSymbol(ctx.model().expectShape(error)).getName())
                            .collect(Collectors.joining(", "));
                    params.put("stub_error_classes", "[" + errors + "]");

                    String encodingModule = context.protocolGenerator().get()
                            .getEventStreamEncodingModule(context).toString();
                    params.put("stub_message_encoder", "%s.const_get(:MessageEncoder).new".formatted(encodingModule));
                    boolean responseEvents = Streaming.isEventStreaming(
                            ctx.model(), ctx.model().expectShape(operation.getOutputShape()));
                    params.put("response_events", responseEvents ? "true" : "false");

                    return params;
                })
                .operationPredicate(
                        (model, service, operation) -> {
                            boolean isStreaming = Streaming.isEventStreaming(model, operation);
                            return (eventStream && isStreaming) || (!eventStream && !isStreaming);
                        }
                )
                .addConfig(stubResponses)
                .addConfig(stubs)
                .build();
    }
}
