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

package software.amazon.smithy.ruby.codegen.protocol.railsjson.generators;

import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.model.traits.HttpHeaderTrait;
import software.amazon.smithy.model.traits.HttpPayloadTrait;
import software.amazon.smithy.model.traits.JsonNameTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;

public class ParserGenerator extends ShapeVisitor.Default<Void> {
    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final Set<ShapeId> generatedParsers;
    private final RubyCodeWriter writer;

    public ParserGenerator(GenerationContext context) {
        this.context = context;
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.generatedParsers = new HashSet<>();
        this.writer = new RubyCodeWriter();
    }

    public void render(FileManifest fileManifest) {
        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Parsers")
                .call(() -> renderParsers())
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/parsers.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderParsers() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        Set<OperationShape> containedOperations = new TreeSet<>(
                topDownIndex.getContainedOperations(context.getService()));
        containedOperations.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderParsersForOperation(o));
    }

    private void renderParsersForOperation(OperationShape operation) {
        System.out.println("Generating parsers for Operation: " + operation.getId());

        // Operations MUST have an Output type, even if it is empty
        if (!operation.getOutput().isPresent()) {
            throw new RuntimeException("Missing Output Shape for: " + operation.getId());
        }

        ShapeId outputShapeId = operation.getOutput().get();
        Shape outputShape = model.expectShape(outputShapeId);

        writer
                .write("\n# Operation Parser for $L", operation.getId().getName())
                .openBlock("class $L", operation.getId().getName())
                .openBlock("def self.parse(http_resp)")
                .write("json = Seahorse::JSON.load(http_resp.body)")
                .write("data = Types::$L.new", outputShapeId.getName())
                .call(() -> renderHeaderParsers(operation, outputShape))
                .call(() -> renderOperationBodyParser(operation, outputShape))
                .write("data")
                .closeBlock("end")
                .closeBlock("end");

        generatedParsers.add(operation.toShapeId());
        generatedParsers.add(outputShapeId);

        Iterator<Shape> it = new Walker(model).iterateShapes(outputShape);
        while (it.hasNext()) {
            Shape s = it.next();
            if (!generatedParsers.contains(s.getId())) {
                generatedParsers.add(s.getId());
                s.accept(this);
            } else {
                System.out.println("\tSkipping " + s.getId() + " because it has already been generated.");
            }
        }

        for (ShapeId errorShapeId : operation.getErrors()) {
            System.out.println("\tGenerating Error parsers connected to: " + errorShapeId);
            Iterator<Shape> errIt = new Walker(model).iterateShapes(model.expectShape(errorShapeId));
            while (errIt.hasNext()) {
                Shape s = errIt.next();
                System.out.println("\t\tError shape: " + s);
                if (!generatedParsers.contains(s.getId())) {
                    System.out.println("\t\tGenerating for new error shape: " + s.getId());
                    generatedParsers.add(s.getId());
                    s.accept(this);
                } else {
                    System.out.println("\tSkipping " + s.getId() + " because it has already been generated.");
                }
            }
        }
    }

    private void renderHeaderParsers(OperationShape operation, Shape outputShape) {
        List<MemberShape> headerMembers = outputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpHeaderTrait.class))
                .collect(Collectors.toList());

        for (MemberShape m : headerMembers) {
            HttpHeaderTrait headerTrait = m.expectTrait(HttpHeaderTrait.class);
            Shape target = model.expectShape(m.getTarget());
            System.out.println("\t\tAdding headers for: " + headerTrait.getValue() + " -> " + target.getId());
            String symbolName = RubyFormatter.toSnakeCase(m.getMemberName());
            writer.write("resp.data.$L = http_resp.headers['$L']", symbolName, headerTrait.getValue());
        }
    }

    // The Output shape is combined with the Operation Parser
    // This generates the parsing of the body as if it was the Parser for the Out[put
    private void renderOperationBodyParser(OperationShape operation, Shape outputShape) {
        //determine if there is an httpPayload member
        List<MemberShape> httpPayloadMembers = outputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpPayloadTrait.class))
                .collect(Collectors.toList());

        if (httpPayloadMembers.size() == 0) {
            renderMemberParsers(writer, outputShape);
        } else if (httpPayloadMembers.size() == 1) {
            MemberShape payloadMember = httpPayloadMembers.get(0);
            Shape target = model.expectShape(payloadMember.getTarget());
            String dataName = RubyFormatter.toSnakeCase(payloadMember.getMemberName());
            writer.write("data.$1L = Parsers::$2L.parse(json)", dataName, target.getId().getName());

        }
    }

    @Override
    protected Void getDefault(Shape shape) {
        System.out.println("\tDefault VISIT for: " + shape.getId() + "\t" + shape.getClass().getSimpleName());
        return null;
    }

    @Override
    public Void structureShape(StructureShape s) {
        System.out.println("\tRENDER parser for STRUCTURE: " + s.getId());
        writer
                .openBlock("\nclass $L", s.getId().getName())
                .openBlock("def self.parse(json)")
                .write("data = Types::$L.new", s.getId().getName())
                .call(() -> renderMemberParsers(writer, s))
                .write("return data")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void listShape(ListShape s) {
        System.out.println("\tRENDER parser for LIST: " + s.getId());
        Shape memberTarget =
                model.expectShape(s.getMember().getTarget());
        writer
                .openBlock("\nclass $L", s.getId().getName())
                .openBlock("def self.parse(json)")
                .openBlock("json.map do |value|")
                .call(() -> memberTarget.accept(new MemberDeserializer(writer, "", "value")))
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void setShape(SetShape s) {
        System.out.println("\tRENDER parser for SET: " + s.getId());
        Shape memberTarget =
                model.expectShape(s.getMember().getTarget());
        writer
                .openBlock("\nclass $L", s.getId().getName())
                .openBlock("def self.parse(json)")
                .openBlock("data = json.map do |value|")
                .call(() -> memberTarget.accept(new MemberDeserializer(writer, "", "value")))
                .closeBlock("end")
                .write("Set.new(data)")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void mapShape(MapShape s) {
        System.out.println("\tRENDER parser for MAP: " + s.getId());
        Shape valueTarget = model.expectShape(s.getValue().getTarget());

        writer
                .openBlock("\nclass $L", s.getId().getName())
                .openBlock("def self.parse(json)")
                .write("data = {}")
                .openBlock("json.map do |key, value|")
                .call(() -> valueTarget.accept(new MemberDeserializer(writer, "data[key] = ", "value")))
                .closeBlock("end")
                .write("data")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void unionShape(UnionShape shape) {
        // TODO: Support union shape
        return null;
    }

    private void renderMemberParsers(RubyCodeWriter writer, Shape s) {
        for (MemberShape member : s.members()) {
            Shape target = model.expectShape(member.getTarget());
            System.out.println("\t\tMEMBER PARSER FOR: " + member.getId() + " target type: " + target.getType());
            String dataName = RubyFormatter.toSnakeCase(member.getMemberName());
            String dataSetter = "data." + dataName + " = ";
            String jsonName = dataName;
            if (member.hasTrait(JsonNameTrait.class)) {
                jsonName = member.getTrait(JsonNameTrait.class).get().getValue();
            }

            String jsonGetter = "json['" + jsonName + "']";
            if (!target.hasTrait(HttpHeaderTrait.class)) {
                target.accept(new MemberDeserializer(writer, dataSetter, jsonGetter));
            }
        }
    }

    private static class MemberDeserializer extends ShapeVisitor.Default<Void> {

        private final RubyCodeWriter writer;
        private final String jsonGetter;
        private final String dataSetter;

        MemberDeserializer(RubyCodeWriter writer, String dataSetter, String jsonGetter) {
            this.writer = writer;
            this.jsonGetter = jsonGetter;
            this.dataSetter = dataSetter;
        }

        /**
         * For simple shapes, just copy to the data.
         */
        @Override
        protected Void getDefault(Shape shape) {
            writer.write("$L$L", dataSetter, jsonGetter);
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            writer.write("$1LTime.parse($2L) if $2L", dataSetter, jsonGetter);
            return null;
        }

        /**
         * For complex shapes, simply delegate to their builder.
         */
        private void defaultComplexDeserializer(Shape shape) {
            writer.write("$1LParsers::$2L.parse($3L) if $3L", dataSetter, shape.getId().getName(),
                    jsonGetter);
        }

        @Override
        public Void listShape(ListShape shape) {
            defaultComplexDeserializer(shape);
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            defaultComplexDeserializer(shape);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            defaultComplexDeserializer(shape);
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            defaultComplexDeserializer(shape);
            return null;
        }
    }
}
