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
import java.util.Optional;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.BlobShape;
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
import software.amazon.smithy.model.traits.HttpLabelTrait;
import software.amazon.smithy.model.traits.HttpQueryTrait;
import software.amazon.smithy.model.traits.HttpTrait;
import software.amazon.smithy.model.traits.JsonNameTrait;
import software.amazon.smithy.model.traits.TimestampFormatTrait;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;
import software.amazon.smithy.ruby.codegen.trait.NoSerializeTrait;

public class BuilderGenerator extends ShapeVisitor.Default<Void> {

    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final Set<ShapeId> generatedBuilders;
    private final RubyCodeWriter writer;

    public BuilderGenerator(GenerationContext context) {
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.generatedBuilders = new HashSet<>();
        this.context = context;
        this.writer = new RubyCodeWriter();
    }

    public void render(FileManifest fileManifest) {

        writer
                .write("require 'base64'\n")
                .openBlock("module $L", settings.getModule())
                .openBlock("module Builders")
                .call(() -> renderBuilders())
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/builders.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderBuilders() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        Set<OperationShape> containedOperations = new TreeSet<>(
                topDownIndex.getContainedOperations(context.getService()));
        containedOperations.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderBuildersForOperation(o));
    }

    private void renderBuildersForOperation(OperationShape operation) {
        System.out.println("Generating builders for Operation: " + operation.getId());

        // Operations MUST have an Input type, even if it is empty
        if (!operation.getInput().isPresent()) {
            throw new RuntimeException("Missing Input Shape for: " + operation.getId());
        }
        ShapeId inputShapeId = operation.getInput().get();

        HttpTrait httpTrait = operation.expectTrait(HttpTrait.class);
        Shape inputShape = model.expectShape(inputShapeId);

        writer
                .write("\n# Operation Builder for $L", operation.getId().getName())
                .openBlock("class $L", operation.getId().getName())
                .openBlock("def self.build(http_req, input:)")
                .write("http_req.http_method = '$L'", httpTrait.getMethod())
                .call(() -> renderUriBuilder(writer, operation, inputShape))
                .call(() -> renderQueryInputBuilder(writer, operation, inputShape))
                .call(() -> renderHeadersBuilder(writer, operation, inputShape))
                .call(() -> renderOperationBodyBuilder(writer, operation, inputShape))
                .closeBlock("end")
                .closeBlock("end");

        generatedBuilders.add(operation.toShapeId());

        Iterator<Shape> it = new Walker(model).iterateShapes(inputShape);
        while (it.hasNext()) {
            Shape s = it.next();
            if (!generatedBuilders.contains(s.getId())) {
                generatedBuilders.add(s.getId());
                s.accept(this);
            } else {
                System.out.println("\tSkipping " + s.getId() + " because it has already been generated.");
            }

        }
    }

    // The Input shape is combined with the OperationBuilder
    // This generates the setting of the body (if any non-http input) as if it was the Builder for the Input
    // Also marks the InputShape as generated
    private void renderOperationBodyBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        generatedBuilders.add(inputShape.getId());

        //determine if there are any members of the input that need to be serialized to the body
        boolean serializeBody = inputShape.members().stream().anyMatch((m) -> !m.hasTrait(HttpLabelTrait.class)
                && !m.hasTrait(HttpQueryTrait.class) && !m.hasTrait((HttpHeaderTrait.class)));
        if (serializeBody) {
            writer
                    .write("")
                    .write("http_req.headers['Content-Type'] = 'application/json'")
                    .call(() -> renderMemberBuilders(writer, inputShape))
                    .write("http_req.body = StringIO.new(Seahorse::JSON.dump(data))");
        }
    }

    private void renderQueryInputBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        // get a list of all of HttpLabel members
        List<MemberShape> queryMembers = inputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpQueryTrait.class))
                .collect(Collectors.toList());
        System.out.println("\tQUERY BUILDER: " + operation.getId() + " has " + queryMembers.size() + " query input...");

        for (MemberShape m : queryMembers) {
            HttpQueryTrait queryTrait = m.expectTrait(HttpQueryTrait.class);
            Shape target = model.expectShape(m.getTarget());
            System.out.println("\t\tAdding query input for: " + queryTrait.getValue() + " -> " + target.getId());
            String symbolName = RubyFormatter.asSymbol(m.getMemberName());
            // TODO: Handle required
            writer.write("http_req.append_query_param('$1L', input[$2L].to_str) unless input[$2L].nil?",
                    queryTrait.getValue(), symbolName);
        }
    }

    private void renderHeadersBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        // get a list of all of HttpLabel members
        List<MemberShape> headerMembers = inputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpHeaderTrait.class))
                .collect(Collectors.toList());
        System.out
                .println("\tHEADER BUILDER: " + operation.getId() + " has " + headerMembers.size() + " query input...");

        for (MemberShape m : headerMembers) {
            HttpHeaderTrait headerTrait = m.expectTrait(HttpHeaderTrait.class);
            Shape target = model.expectShape(m.getTarget());
            System.out.println("\t\tAdding headers for: " + headerTrait.getValue() + " -> " + target.getId());
            String symbolName = RubyFormatter.asSymbol(m.getMemberName());
            // TODO: Handle required
            writer.write("http_req.headers['$1L'] = input[$2L].to_str if input.key?($2L)", headerTrait.getValue(),
                    symbolName);
        }
    }

    private void renderUriBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        // get a list of all of HttpLabel members
        HttpTrait httpTrait = operation.expectTrait(HttpTrait.class);
        List<MemberShape> labelMembers = inputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpLabelTrait.class))
                .collect(Collectors.toList());
        System.out.println("\tURI BUILDER: " + operation.getId() + " has " + labelMembers.size() + " labels...");

        if (labelMembers.size() > 0) {
            String formatUri = httpTrait.getUri().toString()
                    .replaceAll("[{]([a-zA-Z0-9_]+)[}]", "%<$1>s"); //TODO: Handle greedy labels?
            StringBuffer formatArgs = new StringBuffer();
            System.out.println("\t\tURI: " + httpTrait.getUri() + " -> " + formatUri);

            for (MemberShape m : labelMembers) {
                HttpLabelTrait label = m.expectTrait(HttpLabelTrait.class);
                Shape target = model.expectShape(m.getTarget());
                System.out.println("\t\tAdding url subs for: " + target.getId());
                String symbolName = RubyFormatter.asSymbol(m.getMemberName());
                formatArgs.append(
                        ",\n  " + m.getMemberName() + ": Seahorse::HTTP.uri_escape(input[" + symbolName + "].to_str)"
                );
            }
            writer.openBlock("http_req.append_path(format(");
            writer.write("  '$L'$L\n)", formatUri, formatArgs.toString());
            writer.closeBlock(")");
        } else {
            writer.write("http_req.append_path('$L')", httpTrait.getUri());
        }
    }

    @Override
    public Void structureShape(StructureShape shape) {
        System.out.println("\tRENDER builder for STRUCTURE: " + shape.getId());
        writer
                .write("\n# Structure Builder for $L", shape.getId().getName())
                .openBlock("class $L", shape.getId().getName())
                .openBlock("def self.build(input)")
                .call(() -> renderMemberBuilders(writer, shape))
                .write("data")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void listShape(ListShape shape) {
        System.out.println("\tRENDER builder for LIST: " + shape.getId());
        Shape memberTarget =
                model.expectShape(shape.getMember().getTarget());
        writer
                .write("\n# List Builder for $L", shape.getId().getName())
                .openBlock("\nclass $L", shape.getId().getName())
                .openBlock("def self.build(input)")
                .write("data = []")
                .openBlock("input.each do |element|")
                .call(() -> memberTarget.accept(new MemberSerializer(writer, shape.getMember(), "data << ", "element")))
                .closeBlock("end")
                .write("data")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void mapShape(MapShape shape) {
        System.out.println("\tRENDER builder for MAP: " + shape.getId());
        Shape valueTarget = model.expectShape(shape.getValue().getTarget());

        writer
                .write("\n# Map Builder for $L", shape.getId().getName())
                .openBlock("\nclass $L", shape.getId().getName())
                .openBlock("def self.build(input)")
                .write("data = {}")
                .openBlock("input.each do |key, value|")
                .call(() -> valueTarget.accept(new MemberSerializer(writer, shape.getValue(), "data[key] = ", "value")))
                .closeBlock("end")
                .write("data")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void setShape(SetShape shape) {
        System.out.println("\tRENDER builder for Set: " + shape.getId());
        Shape memberTarget =
                model.expectShape(shape.getMember().getTarget());
        writer
                .write("\n# Set Builder for $L", shape.getId().getName())
                .openBlock("\nclass $L", shape.getId().getName())
                .openBlock("def self.build(input)")
                .write("data = Set.new")
                .openBlock("input.each do |element|")
                .call(() -> memberTarget.accept(new MemberSerializer(writer, shape.getMember(), "data << ", "element")))
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

    private void renderMemberBuilders(RubyCodeWriter writer, Shape s) {
        writer.write("data = {}");

        //remove members w/ http traits or marked NoSerialize
        Stream<MemberShape> serializeMembers = s.members().stream()
                .filter((m) -> !m.hasTrait(HttpLabelTrait.class) && !m.hasTrait(HttpQueryTrait.class)
                        && !m.hasTrait((HttpHeaderTrait.class)));
        serializeMembers = serializeMembers.filter(NoSerializeTrait.excludeNoSerializeMembers());

        serializeMembers.forEach((member) -> {
            Shape target = model.expectShape(member.getTarget());
            System.out.println("\t\tMEMBER BUILDER FOR: " + member.getId() + " target type: " + target.getType());

            String symbolName = RubyFormatter.asSymbol(member.getMemberName());
            String dataName = symbolName;
            if (member.hasTrait(JsonNameTrait.class)) {
                dataName = "'" + member.expectTrait(JsonNameTrait.class).getValue() + "'";
            }
            if (member.hasTrait("smithy.railsjson#NestedAttributes")) {
                dataName = symbolName + "_attributes";
            }

            String dataSetter = "data[" + dataName + "] = ";
            String inputGetter = "input[" + symbolName + "]";
            target.accept(new MemberSerializer(writer, member, dataSetter, inputGetter));
        });
    }

    @Override
    protected Void getDefault(Shape shape) {
        return null;
    }

    private static class MemberSerializer extends ShapeVisitor.Default<Void> {

        private final RubyCodeWriter writer;
        private final String inputGetter;
        private final String dataSetter;
        private final MemberShape memberShape;

        MemberSerializer(RubyCodeWriter writer, MemberShape memberShape,
                         String dataSetter, String inputGetter) {
            this.writer = writer;
            this.inputGetter = inputGetter;
            this.dataSetter = dataSetter;
            this.memberShape = memberShape;
        }

        private String checkRequired(Shape shape) {
            return " unless " + inputGetter + ".nil?";
        }

        @Override
        protected Void getDefault(Shape shape) {
            writer.write("$L$L$L", dataSetter, inputGetter, checkRequired(shape));
            return null;
        }

        @Override
        public Void blobShape(BlobShape shape) {
            writer.write("$LBase64::encode64($L).strip$L", dataSetter, inputGetter, checkRequired(shape));
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            // the default protocol format is date_time
            Optional<TimestampFormatTrait> format = memberShape.getTrait(TimestampFormatTrait.class);
            if (format.isPresent()) {
                switch (format.get().getFormat()) {
                    case EPOCH_SECONDS:
                        writer.write("$LSeahorse::TimeHelper.to_epoch_seconds($L)$L", dataSetter, inputGetter,
                                checkRequired(shape));
                        break;
                    case HTTP_DATE:
                        writer.write("$LSeahorse::TimeHelper.to_http_date($L)$L", dataSetter, inputGetter,
                                checkRequired(shape));
                        break;
                    case DATE_TIME:
                    default:
                        writer.write("$LSeahorse::TimeHelper.to_date_time($L)$L", dataSetter, inputGetter,
                                checkRequired(shape));
                        break;
                }
            } else {
                writer.write("$LSeahorse::TimeHelper.to_date_time($L)$L", dataSetter, inputGetter,
                        checkRequired(shape));
            }
            return null;
        }

        /**
         * For complex shapes, simply delegate to their builder.
         */
        private void defaultComplexSerializer(Shape shape) {
            writer.write("$LBuilders::$L.build($L)$L", dataSetter, shape.getId().getName(), inputGetter,
                    checkRequired(shape));
        }

        @Override
        public Void listShape(ListShape shape) {
            defaultComplexSerializer(shape);
            return null;
        }

        @Override
        public Void setShape(SetShape shape) {
            writer.write("$LBuilders::$L.build($L).to_a$L", dataSetter, shape.getId().getName(), inputGetter,
                    checkRequired(shape));
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            defaultComplexSerializer(shape);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            defaultComplexSerializer(shape);
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            defaultComplexSerializer(shape);
            return null;
        }
    }
}


