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
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.middleware.Middleware;
import software.amazon.smithy.ruby.codegen.middleware.MiddlewareStackStep;
import software.amazon.smithy.ruby.codegen.util.Streaming;

public final class EventStreamsMiddlewareFactory {

    private EventStreamsMiddlewareFactory() {

    }

    public static Middleware build(GenerationContext context) {
        return Middleware.builder()
                .klass(Hearth.EVENT_STREAMS_MIDDLEWARE)
                .step(MiddlewareStackStep.AFTER_BUILD)
                .operationParams((ctx, operation) -> {
                    Map<String, String> params = new HashMap<>();
                    params.put("event_handler", "options[:event_stream_handler]");
                    params.put("message_encoding_module",
                            context.protocolGenerator().get().getEventStreamEncodingModule(context).toString());
                    boolean requestEvents = Streaming.isEventStreaming(
                            ctx.model(), ctx.model().expectShape(operation.getInputShape()));
                    boolean responseEvents = Streaming.isEventStreaming(
                            ctx.model(), ctx.model().expectShape(operation.getOutputShape()));
                    params.put("request_events", requestEvents ? "true" : "false");
                    params.put("response_events", responseEvents ? "true" : "false");
                    if (ctx.eventStreamTransport()
                            .map(t -> t.supportsBiDirectionalStreaming())
                            .orElse(false)) {
                        if (requestEvents) {
                            params.put(
                                    "async_output_class",
                                    "EventStream::" + ctx.symbolProvider().toSymbol(operation).getName()
                                            + "Output");
                        } else {
                            params.put("async_output_class", Hearth.ASYNC_OUTPUT.toString());
                        }
                    } else {
                        params.put("async_output_class", "nil");
                    }
                    return params;
                })
                .operationPredicate(
                        (model, service, operation) -> Streaming.isEventStreaming(model, operation)
                )
                .build();
    }
}
