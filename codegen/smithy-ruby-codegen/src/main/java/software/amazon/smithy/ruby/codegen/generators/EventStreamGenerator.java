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
import java.util.Optional;
import java.util.Set;
import java.util.logging.Logger;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.StreamingTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.generators.docs.PlaceholderExampleGenerator;
import software.amazon.smithy.ruby.codegen.generators.docs.ResponseExampleGenerator;
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
        // TODO: Render RBS For these
        write(writer -> {
            writer
                    .preamble()
                    .includeRequires()
                    .addModule(settings.getModule())
                    .addModule("EventStream")
                    .call(() -> renderEventStreamHandlers(writer))
                    .call(() -> renderEventStreamOutputs(writer))
                    .closeAllModules();
        });
        LOGGER.fine("Wrote auth to " + rbFile());
    }

    private void renderEventStreamOutputs(RubyCodeWriter writer) {
        if (context.eventStreamTransport()
                .map(t -> t.supportsBiDirectionalStreaming())
                .orElse(false)) {

            operations.stream()
                    .filter(o -> Streaming.isEventStreaming(model, model.expectShape(o.getInputShape())))
                    .sorted(Comparator.comparing((m) -> m.getId().getName()))
                    .forEach(o -> renderEventStreamOutput(writer, o));
        }
    }

    private void renderEventStreamHandlers(RubyCodeWriter writer) {
        operations.stream()
                .filter(o -> Streaming.isEventStreaming(model, model.expectShape(o.getOutputShape())))
                .sorted(Comparator.comparing((m) -> m.getId().getName()))
                .forEach(o -> renderEventStreamHandler(writer, o));
    }

    private void renderEventStreamHandler(RubyCodeWriter writer, OperationShape operation) {
        String eventName = symbolProvider.toSymbol(operation).getName();

        StructureShape outputShape = model.expectShape(operation.getOutputShape(), StructureShape.class);
        MemberShape eventStreamMember = getEventStreamMember(
                outputShape).orElseThrow();
        UnionShape eventStreamUnion = model.expectShape(eventStreamMember.getTarget(), UnionShape.class);

        writer
                .write("")
                .call(() -> renderEventStreamHandlerDocs(writer, operation, eventStreamUnion))
                .openBlock("class $LHandler < $T", eventName, Hearth.EVENT_STREAM_HANDLER_BASE)
                .call(() -> renderEventHandlerMethods(writer, outputShape, eventStreamUnion))
                .write("")
                .write("private")
                .write("")
                .call(() -> renderParseEventMethod(writer, operation, eventStreamUnion))
                .closeBlock("end");
    }

    private void renderEventStreamHandlerDocs(
            RubyCodeWriter writer, OperationShape operation, UnionShape eventStreamUnion) {
        String eventName = symbolProvider.toSymbol(operation).getName();
        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());

        writer
                .write("# EventStreamHandler for the the {Client#$L} operation.", operationName)
                .write("# Register event handlers using the +#on_<event_name>+ methods")
                .write("# and set the handler using the +event_stream_handler+ option")
                .write("# on the {Client#$L} method.", operationName)
                .writeYardExample("Basic Usage", basicEventStreamHandlerExample(eventName, operationName));

    }

    private String basicEventStreamHandlerExample(String eventName, String operationName) {
        return String.format(
                "handler = %s.new%n"
                        + "# register handlers for the events you are interested in%n"
                        + "handler.on_initial_response { |initial_response| process(initial_response) }%n"
                        + "client.%s(params, event_stream_handler: handler)",
                eventName,
                operationName);
    }

    private void renderEventHandlerMethods(
            RubyCodeWriter writer, StructureShape outputShape, UnionShape eventStreamUnion) {

        writer
                .call(() -> renderOnInitialResponseDocs(writer, outputShape))
                .openBlock("def on_initial_response(&block)")
                .write("on($T, block)", symbolProvider.toSymbol(outputShape))
                .closeBlock("end");

        for (MemberShape memberShape : eventStreamUnion.members()) {
            String type = symbolProvider.toMemberName(memberShape);
            String eventName = RubyFormatter.toSnakeCase(type);
            writer
                    .write("")
                    .call(() -> renderEventHandlerMethodDocs(writer, eventName, memberShape))
                    .openBlock("def on_$L(&block)", eventName)
                    .write("on($T::$L, block)",
                            symbolProvider.toSymbol(eventStreamUnion), type)
                    .closeBlock("end");
        }

        writer
                .write("")
                .call(() -> renderOnUnknownEventDocs(writer, eventStreamUnion))
                .openBlock("def on_unknown_event(&block)")
                .write("on($T::Unknown, block)", symbolProvider.toSymbol(eventStreamUnion))
                .closeBlock("end");

    }

    private void renderOnInitialResponseDocs(RubyCodeWriter writer, StructureShape outputShape) {
        writer
                .write("# Register an event handler for the initial response.")
                .write("# @yield [event] Called when the initial response is received.")
                .write("# @yieldparam event [$T] the initial response", symbolProvider.toSymbol(outputShape))
                .writeYardExample(
                        "Event structure",
                        new ResponseExampleGenerator(
                                outputShape,
                                "event", symbolProvider, model).generate()
                );

    }

    private void renderEventHandlerMethodDocs(RubyCodeWriter writer, String eventName, MemberShape memberShape) {
        writer
                .write("# Register an event handler for $L events", eventName)
                .write("# @yield [event] Called when $L events are received.", eventName)
                .write("# @yieldparam event [$T] the event.", symbolProvider.toSymbol(memberShape))
                .writeYardExample(
                        "Event structure",
                        new ResponseExampleGenerator(
                                model.expectShape(memberShape.getTarget(), StructureShape.class),
                                "event", symbolProvider, model).generate()
                );

    }

    private void renderOnUnknownEventDocs(RubyCodeWriter writer, UnionShape eventStreamUnion) {
        writer
                .write("# Register an event handler for any unknown events.")
                .write("# @yield [event] Called when unknown events are received.")
                .write("# @yieldparam event [$T::Unknown] the event with value set to the Message",
                        symbolProvider.toSymbol(eventStreamUnion));

    }

    private void renderParseEventMethod(
            RubyCodeWriter writer, OperationShape operation, UnionShape eventStreamUnion) {
        writer
                .openBlock("def parse_event(type, message)")
                .write("case type")
                .write("when 'initial-response' then Parsers::EventStream::$LInitialResponse.parse(message)",
                        symbolProvider.toSymbol(operation).getName())
                .call(() -> {
                    for (MemberShape memberShape : eventStreamUnion.members()) {
                        Shape target = model.expectShape(memberShape.getTarget());
                        writer.write("when '$L' then $T.new(Parsers::EventStream::$L.parse(message))",
                                symbolProvider.toMemberName(memberShape), symbolProvider.toSymbol(memberShape),
                                symbolProvider.toSymbol(target).getName());
                    }
                })
                .openBlock("else")
                .write("$T::Unknown.new(name: type || 'unknown', value: message)",
                        symbolProvider.toSymbol(eventStreamUnion))
                .closeBlock("end")
                .closeBlock("end");
    }

    private void renderEventStreamOutput(RubyCodeWriter writer, OperationShape operation) {
        String eventName = symbolProvider.toSymbol(operation).getName();

        writer
                .write("")
                .call(() -> renderEventStreamOutputDocs(writer, operation))
                .openBlock("class $LOutput < $T", eventName, Hearth.ASYNC_OUTPUT)
                .call(() -> renderSignalMethods(writer, operation))
                .closeBlock("end");
    }

    private void renderEventStreamOutputDocs(RubyCodeWriter writer, OperationShape operation) {
        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());

        writer
                .write("# Output returned from {Client#$L}", operationName)
                .write("# and used to signal (send) async input events.")
                .writeYardExample("Basic Usage", renderEventStreamOutputExample(operation));
    }

    private String renderEventStreamOutputExample(OperationShape operation) {
        MemberShape eventStreamMember = getEventStreamMember(
                model.expectShape(operation.getOutputShape(), StructureShape.class)).orElseThrow();
        UnionShape eventStreamUnion = model.expectShape(eventStreamMember.getTarget(), UnionShape.class);
        String exampleMemberName = eventStreamUnion.getMemberNames().get(0);
        MemberShape exampleMember = eventStreamUnion.getMember(exampleMemberName).get();

        String operationName = RubyFormatter.toSnakeCase(symbolProvider.toSymbol(operation).getName());

        return String.format("stream = client.%s(initial_request)%n"
                        + "stream.signal_%s(event_params) # send an event%n"
                        + "stream.join # close the input stream and wait for the server",
                RubyFormatter.toSnakeCase(symbolProvider.toMemberName(exampleMember)),
                operationName);
    }

    private void renderSignalMethods(RubyCodeWriter writer, OperationShape operation) {
        MemberShape eventStreamMember = getEventStreamMember(
                model.expectShape(operation.getInputShape(), StructureShape.class)).orElseThrow();
        UnionShape eventStreamUnion = model.expectShape(eventStreamMember.getTarget(), UnionShape.class);

        for (MemberShape memberShape : eventStreamUnion.members()) {
            Shape member = model.expectShape(memberShape.getTarget());
            String eventClass = symbolProvider.toSymbol(member).getName();
            writer
                    .write("")
                    .call(() -> renderSignalMethodDocs(writer, memberShape))
                    .openBlock("def signal_$L(params = {})",
                            RubyFormatter.toSnakeCase(symbolProvider.toMemberName(memberShape)))
                    .write("input = Params::$L.build(params, context: 'params')",
                            eventClass)
                    .write("message = Builders::EventStream::$L.build(input: input)",
                            eventClass)
                    .write("send_event(message)")
                    .closeBlock("end");
        }
    }

    private void renderSignalMethodDocs(RubyCodeWriter writer, MemberShape memberShape) {
        StructureShape eventShape = model.expectShape(memberShape.getTarget(), StructureShape.class);
        String eventShapeName = symbolProvider.toSymbol(eventShape).getName();

        String paramsDocString = """
                Request parameters for signaling this event.
                See {Types::%s#initialize} for available parameters.
                """.formatted(eventShapeName);

        String operationCall = "stream.signal_%s".formatted(
                RubyFormatter.toSnakeCase(symbolProvider.toMemberName(memberShape)));

        writer
                .write("# Signal (send) an $L input event", symbolProvider.toSymbol(memberShape).getName())
                .writeYardParam("Hash | Types::" + eventShapeName, "params", paramsDocString)
                .writeYardExample(
                        "Request syntax with placeholder values",
                        new PlaceholderExampleGenerator(eventShape, operationCall, symbolProvider, model).generate()
                );
    }

    private Optional<MemberShape> getEventStreamMember(StructureShape shape) {
        return shape.members()
                .stream()
                .filter(m -> StreamingTrait.isEventStream(model, m))
                .findFirst();
    }
}
