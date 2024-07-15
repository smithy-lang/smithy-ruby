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

package software.amazon.smithy.ruby.codegen.generators;

import java.util.Comparator;
import java.util.Set;
import java.util.logging.Logger;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.StreamingTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.util.Streaming;

public class EventStreamGenerator extends RubyGeneratorBase {

    private static final Logger LOGGER =
            Logger.getLogger(EventStreamGenerator.class.getName());

    private final Set<OperationShape> operations;

    public EventStreamGenerator(
            ContextualDirective<GenerationContext, RubySettings> directive) {
        super(directive);
        this.operations = directive.operations();
    }

    @Override
    protected String getModule() {
        return "EventStream";
    }

    public void render() {
        // TODO: Render documentation and examples for these?
        write(writer -> {
            writer
                    .preamble()
                    .includeRequires()
                    .addModule(settings.getModule())
                    .addModule("EventStream")
                    .call(() -> renderEventStreamHandlers(writer))
                    .closeAllModules();
        });
        LOGGER.fine("Wrote auth to " + rbFile());
    }

    private void renderEventStreamHandlers(RubyCodeWriter writer) {
        operations.stream()
                .filter((o) -> Streaming.isEventStreaming(model, o))
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderEventStreamHandler(writer, o));
    }

    private void renderEventStreamHandler(RubyCodeWriter writer, OperationShape operation) {
        String operationName = symbolProvider.toSymbol(operation).getName();
        Shape inputShape = model.expectShape(operation.getInputShape());
        Shape outputShape = model.expectShape(operation.getOutputShape());

        writer
                .write("")
                .openBlock("class $L < $T", operationName, Hearth.EVENT_STREAM_HANDLER_BASE)
                .call(() -> {
                    if (Streaming.isEventStreaming(model, inputShape)) {
                        renderSignalMethods(writer, inputShape);
                    }
                })
                .call(() -> {
                    if (Streaming.isEventStreaming(model, outputShape)) {
                        renderEventHandlerMethods(writer, outputShape);
                    }
                })
                // TODO: Generate on methods for output events (handlers)
                .closeBlock("end");
    }

    private void renderSignalMethods(RubyCodeWriter writer, Shape inputShape) {
        MemberShape eventStreamMember = inputShape.members()
                .stream()
                .filter(m -> StreamingTrait.isEventStream(model, m))
                .findFirst()
                .orElseThrow();
        UnionShape eventStreamUnion = model.expectShape(eventStreamMember.getTarget(), UnionShape.class);

        for (MemberShape memberShape : eventStreamUnion.members()) {
            Shape member = model.expectShape(memberShape.getTarget());
            String eventClass = symbolProvider.toSymbol(member).getName();
            writer
                    .write("")
                    .openBlock("def signal_$L(params = {})",
                            RubyFormatter.toSnakeCase(symbolProvider.toMemberName(memberShape)))
                    .write("input = Params::$L.build(params, context: 'params')",
                            eventClass)
                    .write("message = Builders::EventStream::$L.build(input: input)",
                            eventClass)
                    .write("encoder.send_event(:event, message)")
                    .closeBlock("end");
            // use the Params class to translate params to input
        }
    }

    private void renderEventHandlerMethods(RubyCodeWriter writer, Shape outputShape) {
        MemberShape eventStreamMember = outputShape.members()
                .stream()
                .filter(m -> StreamingTrait.isEventStream(model, m))
                .findFirst()
                .orElseThrow();
        UnionShape eventStreamUnion = model.expectShape(eventStreamMember.getTarget(), UnionShape.class);

        for (MemberShape memberShape : eventStreamUnion.members()) {
            String type = symbolProvider.toMemberName(memberShape);
            String eventName = RubyFormatter.toSnakeCase(type);
            writer
                    .write("")
                    .openBlock("def on_$L(&block)", eventName)
                    .write("on('$L', block)", type)
                    .closeBlock("end");
        }

        writer
                .write("")
                .openBlock("def parse_event(type, message)")
                .write("case type")
                .call(() -> {
                    for (MemberShape memberShape : eventStreamUnion.members()) {
                        Shape target = model.expectShape(memberShape.getTarget());

                        writer.write("when '$L' then Parsers::EventStream::$L.parse(message)",
                                symbolProvider.toMemberName(memberShape), symbolProvider.toSymbol(target).getName());
                    }
                })
                .write("end")
                .closeBlock("end");
    }
}
