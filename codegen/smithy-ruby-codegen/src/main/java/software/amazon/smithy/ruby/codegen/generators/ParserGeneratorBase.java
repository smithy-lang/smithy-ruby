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
import java.util.HashSet;
import java.util.Iterator;
import java.util.Optional;
import java.util.Set;
import java.util.TreeSet;
import java.util.logging.Logger;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.build.SmithyBuildException;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.BlobShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.ErrorTrait;
import software.amazon.smithy.model.traits.EventHeaderTrait;
import software.amazon.smithy.model.traits.EventPayloadTrait;
import software.amazon.smithy.model.traits.StreamingTrait;
import software.amazon.smithy.ruby.codegen.CodegenUtils;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.util.Streaming;
import software.amazon.smithy.utils.SmithyUnstableApi;

/**
 * Base class for Parser Generators which iterates shapes and builds skeleton classes.
 *
 * <p>
 * Protocols should extend this class to get common functionality -
 * generates the framework and non-protocol specific parts of
 * parsers.rb.
 */
@SmithyUnstableApi
public abstract class ParserGeneratorBase {

    private static final Logger LOGGER =
            Logger.getLogger(RestParserGeneratorBase.class.getName());

    protected final GenerationContext context;
    protected final RubySettings settings;
    protected final Model model;
    protected final Set<ShapeId> generatedParsers;
    protected final SymbolProvider symbolProvider;

    protected final RubyCodeWriter writer;

    public ParserGeneratorBase(GenerationContext context) {
        this.context = context;
        this.settings = context.settings();
        this.model = context.model();
        this.generatedParsers = new HashSet<>();
        this.writer = new RubyCodeWriter(context.settings().getModule() + "::Parsers");
        this.symbolProvider = context.symbolProvider();
    }

    /**
     * Called to render a union's parser.
     * The rendered code should return the correct member Type class.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * class MyUnion
     *   #### START code generated by this method
     *   def self.parse(map)
     *     key, value = map.flatten
     *     case key
     *     when 'string_value'
     *       Types::MyUnion::StringValue.new(value) if value
     *     else
     *       Types::MyUnion::Unknown.new(name: key, value: value)
     *     end
     *   end
     *   ### END code generated by this method
     * end
     * }</pre>
     *
     * @param s the union shape
     */
    protected abstract void renderUnionParseMethod(UnionShape s);


    /**
     * Called to render a map's parse method.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * class StringMap
     *   #### START code generated by this method
     *   def self.parse(map)
     *     data = {}
     *     map.map do |key, value|
     *       data[key] = value
     *     end
     *     data
     *   end
     *   #### END code generated by this method
     * end
     * }</pre>
     *
     * @param s shape to generate for
     */
    protected abstract void renderMapParseMethod(MapShape s);

    /**
     * Called to render a list's parse method.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * class StringList
     *   #### START code generated by this method
     *   def self.parse(list)
     *     list.map do |value|
     *       value
     *     end
     *   end
     *   #### END code generated by this method
     * end
     * }</pre>
     *
     * @param s shape to generate for
     */
    protected abstract void renderListParseMethod(ListShape s);

    /**
     * Called to render a structure's parse method.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * class SimpleStruct
     *   ### START code generated by this method
     *   def self.parse(map)
     *     data = Types::SimpleStruct.new
     *     data.value = map['value']
     *     data.timestamp = Time.parse(map['timestamp']) if map['timestamp']
     *     return data
     *   end
     *   #### END code generated by this method
     * end
     * }</pre>
     *
     * @param s shape to generate for
     */
    protected abstract void renderStructureParseMethod(StructureShape s);

    /**
     * Called to render an operation's parse method.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * class Operation
     *   ### START code generated by this method
     *   def self.parse(http_resp)
     *     data = Types::OperationOutput.new
     *     map = Hearth::JSON.parse(http_resp.body.read)
     *     data.contents = (Parsers::Contents.parse(map['contents']) unless map['contents'].nil?)
     *     data
     *   end
     *   #### END code generated by this method
     * end
     * }</pre>
     *
     * @param operation   the operation to generate a parse method for
     * @param outputShape the operation's outputShape
     */
    protected abstract void renderOperationParseMethod(OperationShape operation, Shape outputShape);

    /**
     * Called to render an error's parse method.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * class ComplexError
     *   ### START code generated by this method
     *   def self.parse(http_resp)
     *     data = Types::ComplexError.new
     *     data.header = http_resp.headers['X-Header']
     *     map = Hearth::JSON.parse(http_resp.body.read)
     *     data.top_level = map['TopLevel']
     *     data.nested = (Parsers::ComplexNestedErrorData.parse(map['Nested']) unless map['Nested'].nil?)
     *     data
     *   end
     *   ### END code generated by this method
     * end
     * }</pre>
     *
     * @param s the error shape to generate a parse method for
     */
    protected abstract void renderErrorParseMethod(Shape s);

    /**
     * Called to render parser code for an explicit (marked with the @eventPayload trait) payload structure.
     * The skeleton of the parser method is generated outside of this method.  This method only needs to generate
     * code to parse the payload structure from the payload string.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * class SimpleEvent
     *   def self.parse(message)
     *     data = Types::SimpleEvent.new
     *     payload = message.payload.read
     *     return data if payload.empty?
     *
     *     ### START code generated by this method
     *     map = Hearth::CBOR.decode(payload.force_encoding(Encoding::BINARY))
     *     data.message = map['message']
     *     ### END code generated by this method
     *
     *     data
     *   end
     * end
     * }</pre>
     *
     * @param payloadMember the payload member.
     * @param shape         the payload target to generate for.
     */
    protected abstract void renderEventExplicitStructurePayloadParser(MemberShape payloadMember, StructureShape shape);

    /**
     * Called to render parser code for an implicit (no members marked with the @eventPayload trait) payload structure.
     * The skeleton of the parser method is generated outside of this method.  This method only needs to generate
     * code to parse the payload structure from the payload string.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * class SimpleEvent
     *   def self.parse(message)
     *     data = Types::SimpleEvent.new
     *     payload = message.payload.read
     *     return data if payload.empty?
     *
     *     ### START code generated by this method
     *     map = Hearth::CBOR.decode(payload.force_encoding(Encoding::BINARY))
     *     data.nested_payload = NestedPayload.parse(map)
     *     ### END code generated by this method
     *
     *     data
     *   end
     * end
     * }</pre>
     *
     * @param event the event to generate for.
     */
    protected abstract void renderEventImplicitStructurePayloadParser(StructureShape event);

    protected void renderInitialResponseEventParseMethod(StructureShape output) {
        // in general parsing the initial-response should follow the same logic as any other event parsing
        // but allow protocols to override/specialize this if needed.
        renderEventParseMethod(output);
    }

    public void render(FileManifest fileManifest) {
        writer
                .preamble()
                .includeRequires()
                .openBlock("module $L", settings.getModule())
                .apiPrivate()
                .openBlock("module Parsers")
                .call(() -> renderParsers())
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/parsers.rb";
        fileManifest.writeFile(fileName, writer.toString());
        LOGGER.fine("Wrote parsers to " + fileName);
    }

    protected void renderParsers() {
        TreeSet<Shape> shapesToRender = CodegenUtils.getAlphabeticalOrderedShapesSet();
        TreeSet<Shape> eventStreamEventsToRender = CodegenUtils.getAlphabeticalOrderedShapesSet();

        TopDownIndex topDownIndex = TopDownIndex.of(model);
        Set<OperationShape> containedOperations = new TreeSet<>(
                topDownIndex.getContainedOperations(context.service()));
        containedOperations.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> {
                    Shape outputShape = model.expectShape(o.getOutputShape());
                    shapesToRender.add(o);
                    generatedParsers.add(o.toShapeId());
                    generatedParsers.add(outputShape.toShapeId());
                    Iterator<Shape> it = new Walker(model).iterateShapes(outputShape);
                    while (it.hasNext()) {
                        Shape s = it.next();
                        if (!StreamingTrait.isEventStream(s) && !generatedParsers.contains(s.getId())) {
                            generatedParsers.add(s.getId());
                            shapesToRender.add(s);
                        }
                    }

                    for (ShapeId errorShapeId : o.getErrors()) {
                        Iterator<Shape> errIt = new Walker(model).iterateShapes(model.expectShape(errorShapeId));
                        while (errIt.hasNext()) {
                            Shape s = errIt.next();
                            if (!generatedParsers.contains(s.getId())) {
                                generatedParsers.add(s.getId());
                                shapesToRender.add(s);
                            }
                        }
                    }
                    if (Streaming.isEventStreaming(model, outputShape)) {
                        eventStreamEventsToRender.add(o); // to handle initial-response events
                        for (MemberShape memberShape : outputShape.members()) {
                            if (StreamingTrait.isEventStream(model, memberShape)) {
                                UnionShape eventStreamUnion = model.expectShape(
                                        memberShape.getTarget(), UnionShape.class);
                                for (MemberShape eventMember : eventStreamUnion.members()) {
                                    eventStreamEventsToRender.add(model.expectShape(eventMember.getTarget()));
                                }
                            }
                        }
                    }
                });

        shapesToRender.forEach(shape -> {
            if (shape instanceof OperationShape operation) {
                Shape outputShape = model.expectShape(operation.getOutputShape());
                renderParsersForOperation(operation, outputShape);
            } else if (shape.hasTrait(ErrorTrait.class)) {
                renderErrorParser(shape);
            } else {
                shape.accept(new ParserClassGenerator());
            }
        });

        // Render event stream module with shapes in alphabetical order
        // EventStream event parsers must be in a separate namespace since those shapes may be used in
        // non-event stream operations as well.
        if (!eventStreamEventsToRender.isEmpty()) {
            writer
                    .write("")
                    .openBlock("module EventStream")
                    .call(() -> {
                        // Render all shapes in alphabetical ordering
                        eventStreamEventsToRender
                                .forEach(shape -> {
                                    if (shape.isOperationShape()) {
                                        // initial-response
                                        writer
                                                .write("")
                                                .openBlock("class $LInitialResponse",
                                                        symbolProvider.toSymbol(shape).getName())
                                                .call(() -> renderInitialResponseEventParseMethod(
                                                                model.expectShape(
                                                                        shape.asOperationShape().get().getOutputShape(),
                                                                        StructureShape.class)
                                                        )
                                                )
                                                .closeBlock("end");
                                    } else {
                                        // Event stream event members MUST target only StructureShapes
                                        writer
                                                .write("")
                                                .openBlock("class $L", symbolProvider.toSymbol(shape).getName())
                                                .call(() -> renderEventParseMethod(shape.asStructureShape().get()))
                                                .closeBlock("end");
                                    }
                                });
                    })
                    .closeBlock("end");
        }

    }

    /**
     * Called to render an EventStream Event's parse method.
     * The class skeleton is rendered outside of this method.
     *
     * <p>The following example shows the generated skeleton and an example of what
     * this method is expected to render.</p>
     * <pre>{@code
     * class SimpleEvent
     *   ### START code generated by this method
     *   def self.parse(message)
     *     data = Types::SimpleEvent.new
     *     map = Hearth::JSON.parse(http_resp.body.read)
     *     data.contents = (Parsers::Contents.parse(map['contents']) unless map['contents'].nil?)
     *     data
     *   end
     *   #### END code generated by this method
     * end
     * }</pre>
     *
     * @param event the EventStream event to generate a parser method for.
     */
    protected void renderEventParseMethod(StructureShape event) {
        Optional<MemberShape> payloadMember = event.members().stream()
                .filter(m -> m.hasTrait(EventPayloadTrait.class))
                .findFirst();

        writer
                .openBlock("def self.parse(message)")
                .write("data = $T.new", context.symbolProvider().toSymbol(event))
                .call(() -> renderParseEventHeaders(event))
                .write("payload = message.payload.read")
                .write("return data if payload.empty?")
                .call(() -> {
                    if (payloadMember.isPresent()) {
                        model.expectShape(payloadMember.get().getTarget())
                                .accept(new EventPayloadParser(payloadMember.get()));
                    } else {
                        renderEventImplicitStructurePayloadParser(event);
                    }
                })
                .write("data")
                .closeBlock("end");

    }

    protected void renderParseEventHeaders(StructureShape event) {
        event.members().stream().filter(m -> m.getTrait(EventHeaderTrait.class).isPresent()).forEach(m -> {
            // the value should already be an appropriate ruby type, parsed by the MessageDecoder based on the
            // header's type.
            writer.write("data.$L = message.headers['$L']&.value",
                    symbolProvider.toMemberName(m),
                    m.getMemberName());
        });
    }

    protected void renderParsersForOperation(OperationShape operation, Shape outputShape) {
        writer
                .write("")
                .openBlock("class $L", symbolProvider.toSymbol(operation).getName())
                .call(() -> renderOperationParseMethod(operation, outputShape))
                .closeBlock("end");
    }

    protected void renderErrorParser(Shape s) {
        writer
                .write("")
                .write("# Error Parser for $L", s.getId().getName())
                .openBlock("class $L", symbolProvider.toSymbol(s).getName())
                .call(() -> renderErrorParseMethod(s))
                .closeBlock("end");
    }

    protected void renderStreamingBodyParser(Shape outputShape) {
        MemberShape streamingMember = outputShape.members().stream()
                .filter((m) -> m.getMemberTrait(model, StreamingTrait.class).isPresent())
                .findFirst().get();

        writer.write("data.$L = http_resp.body",
                symbolProvider.toMemberName(streamingMember)); // do NOT read the body when streaming
    }

    private class ParserClassGenerator extends ShapeVisitor.Default<Void> {
        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void structureShape(StructureShape s) {
            writer
                    .write("")
                    .openBlock("class $L", symbolProvider.toSymbol(s).getName())
                    .call(() -> renderStructureParseMethod(s))
                    .closeBlock("end");

            return null;
        }

        @Override
        public Void listShape(ListShape s) {
            writer
                    .write("")
                    .openBlock("class $L", symbolProvider.toSymbol(s).getName())
                    .call(() -> renderListParseMethod(s))
                    .closeBlock("end");

            return null;
        }

        @Override
        public Void mapShape(MapShape s) {
            writer
                    .write("")
                    .openBlock("class $L", symbolProvider.toSymbol(s).getName())
                    .call(() -> renderMapParseMethod(s))
                    .closeBlock("end");

            return null;
        }

        @Override
        public Void unionShape(UnionShape s) {
            writer
                    .write("")
                    .openBlock("class $L", symbolProvider.toSymbol(s).getName())
                    .call(() -> renderUnionParseMethod(s))
                    .closeBlock("end");

            return null;
        }
    }

    protected class EventPayloadParser extends ShapeVisitor.Default<Void> {

        private final MemberShape payloadMember;

        public EventPayloadParser(MemberShape payloadMember) {
            this.payloadMember = payloadMember;
        }

        @Override
        protected Void getDefault(Shape shape) {
            throw new SmithyBuildException("Unsupported type for EventPayload: " + shape.getClass());
        }

        @Override
        public Void structureShape(StructureShape shape) {
            renderEventExplicitStructurePayloadParser(payloadMember, shape);
            return null;
        }

        @Override
        public Void blobShape(BlobShape shape) {
            String dataName = symbolProvider.toMemberName(payloadMember);
            String dataSetter = "data." + dataName + " = ";
            writer.write("$L payload", dataSetter);
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            String dataName = symbolProvider.toMemberName(payloadMember);
            String dataSetter = "data." + dataName + " = ";
            writer.write("$L payload", dataSetter);
            return null;
        }

    }

}
