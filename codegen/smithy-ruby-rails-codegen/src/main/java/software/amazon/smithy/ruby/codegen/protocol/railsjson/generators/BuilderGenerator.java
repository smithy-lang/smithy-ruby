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

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.*;
import software.amazon.smithy.model.traits.HttpHeaderTrait;
import software.amazon.smithy.model.traits.HttpLabelTrait;
import software.amazon.smithy.model.traits.HttpQueryTrait;
import software.amazon.smithy.model.traits.HttpTrait;
import software.amazon.smithy.model.traits.RequiredTrait;
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
                .openBlock("module $L", settings.getModule())
                .openBlock("module Builders")
                .call(() -> renderBuilders())
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/builders.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderBuilders() {
        Stream<OperationShape> operations = model.shapes(OperationShape.class);
        operations.forEach(o -> renderBuildersForOperation(writer, o));
    }

    private void renderBuildersForOperation(RubyCodeWriter writer, OperationShape operation) {
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
                .openBlock("def self.build(http_req, params:)")
                .write("http_req.http_method = '$L'", httpTrait.getMethod())
                .call(() -> renderUriBuilder(writer, operation, inputShape))
                .call(() -> renderQueryParamsBuilder(writer, operation, inputShape))
                .call(() -> renderHeadersBuilder(writer, operation, inputShape))
                .call(() -> renderOperationBodyBuilder(writer, operation, inputShape))
                .closeBlock("end")
                .closeBlock("end");

        generatedBuilders.add(operation.toShapeId());

        for (Iterator<Shape> it = new Walker(model).iterateShapes(inputShape); it.hasNext(); ) {
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
    // This generates the setting of the body (if any non-http params) as if it was the Builder for the Input
    // Also marks the InputShape as generated
    private void renderOperationBodyBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        generatedBuilders.add(inputShape.getId());

        //determine if there are any members of the input that need to be serialized to the body
        boolean serializeBody = inputShape.members().stream().anyMatch((m) -> !m.hasTrait(HttpLabelTrait.class) && !m.hasTrait(HttpQueryTrait.class) && !m.hasTrait((HttpHeaderTrait.class)));
        if (serializeBody) {
            writer
                .write("")
                .write("http_req.headers['Content-Type'] = 'application/json'")
                .call(() -> renderMemberBuilders(writer, inputShape))
                .write("http_req.body = StringIO.new(Seahorse::JSON.dump(data))");
        }
    }

    private void renderQueryParamsBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        // get a list of all of HttpLabel members
        List<MemberShape> queryMembers = inputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpQueryTrait.class))
                .collect(Collectors.toList());
        System.out.println("\tQUERY BUILDER: " + operation.getId() + " has " + queryMembers.size() + " query params...");

        for(MemberShape m : queryMembers) {
            HttpQueryTrait queryTrait = m.expectTrait(HttpQueryTrait.class);
            Shape target = model.expectShape(m.getTarget());
            System.out.println("\t\tAdding query params for: " + queryTrait.getValue() + " -> " + target.getId());
            String symbolName =  RubyFormatter.asSymbol(m.getMemberName());
            // TODO: Handle required
            writer.write("http_req.append_query_param('$1L', params[$2L].to_str) if params.key?($2L)", queryTrait.getValue(), symbolName);
        }
    }

    private void renderHeadersBuilder(RubyCodeWriter writer, OperationShape operation, Shape inputShape) {
        // get a list of all of HttpLabel members
        List<MemberShape> headerMembers = inputShape.members()
                .stream()
                .filter((m) -> m.hasTrait(HttpHeaderTrait.class))
                .collect(Collectors.toList());
        System.out.println("\tHEADER BUILDER: " + operation.getId() + " has " + headerMembers.size() + " query params...");

        for(MemberShape m : headerMembers) {
            HttpHeaderTrait headerTrait = m.expectTrait(HttpHeaderTrait.class);
            Shape target = model.expectShape(m.getTarget());
            System.out.println("\t\tAdding headers for: " + headerTrait.getValue() + " -> " + target.getId());
            String symbolName =  RubyFormatter.asSymbol(m.getMemberName());
            // TODO: Handle required
            writer.write("http_req.headers['$1L'] = params[$2L].to_str if params.key?($2L)", headerTrait.getValue(), symbolName);
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
            String formatArgs = ""; // use string builder instead?
            System.out.println("\t\tURI: " + httpTrait.getUri() + " -> " + formatUri);

            for(MemberShape m : labelMembers) {
                HttpLabelTrait label = m.expectTrait(HttpLabelTrait.class);
                Shape target = model.expectShape(m.getTarget());
                System.out.println("\t\tAdding url subs for: " + target.getId());
                String symbolName =  RubyFormatter.asSymbol(m.getMemberName());
                formatArgs += ",\n  " + m.getMemberName() + ": Seahorse::HTTP.uri_escape(params[" + symbolName + "].to_str)";
            }
            writer.openBlock("http_req.append_path(format(");
            writer.write("  '$L'$L\n)", formatUri, formatArgs);
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
                .openBlock("def self.build(params)")
                .call(() -> renderMemberBuilders(writer, shape))
                .write("data")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void listShape(ListShape shape) {
        System.out.println("\tRENDER builder for LIST: " + shape.getId());
        writer
                .write("\n# List Builder for $L", shape.getId().getName())
                .openBlock("\nclass $L", shape.getId().getName())
                .openBlock("def self.build(params)")
                .write("data = []")
                .openBlock("params.each do |p|")
                .write("data << p") // TODO: This likely needs conversion here.  Another nested visitor?
                .closeBlock("end")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void mapShape(MapShape shape) {
        // TODO: Support map shape
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
        Stream<MemberShape> serializeMembers = s.members().stream().filter((m) -> !m.hasTrait(HttpLabelTrait.class) && !m.hasTrait(HttpQueryTrait.class) && !m.hasTrait((HttpHeaderTrait.class)));
        serializeMembers = serializeMembers.filter(NoSerializeTrait.excludeNoSerializeMembers());

        serializeMembers.forEach((member) -> {
            Shape target = model.expectShape(member.getTarget());
            System.out.println("\t\tMEMBER BUILDER FOR: " + member.getId() + " target type: " + target.getType());

            String symbolName = RubyFormatter.asSymbol(member.getMemberName());
            String dataName = symbolName;
            if (member.hasTrait("smithy.railsjson#NestedAttributes")) {
                dataName = symbolName + "_attributes";
            }
            target.accept(new MemberSerializer(writer, dataName, symbolName));
        });
    }

    @Override
    protected Void getDefault(Shape shape) {
        return null;
    }

    private static class MemberSerializer extends ShapeVisitor.Default<Void> {

        private final RubyCodeWriter writer;
        private final String symbolName;
        private final String dataName;

        public MemberSerializer(RubyCodeWriter writer, String dataName, String symbolName) {
            this.writer = writer;
            this.symbolName = symbolName;
            this.dataName = dataName;
        }

        public String checkRequired(Shape shape) {
            return " unless params[" + symbolName + "].nil?";
        }

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void booleanShape(BooleanShape shape) {
            writer.write("data[$L] = params[$L]$L", symbolName, symbolName, checkRequired(shape));
            return null;
        }

        @Override
        public Void integerShape(IntegerShape shape) {
            writer.write("data[$L] = params[$L]$L", symbolName, symbolName, checkRequired(shape));
            return null;
        }

        @Override
        public Void floatShape(FloatShape shape) {
            writer.write("data[$L] = params[$L]$L", symbolName, symbolName, checkRequired(shape));
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            writer.write("data[$L] = params[$L]$L", symbolName, symbolName, checkRequired(shape));
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            writer.write("data[$L] = params[$L].to_s$L", symbolName, symbolName, checkRequired(shape));
            return null;
        }

        /**
         *  For complex shapes, simply delegate to their builder
         */
        private void defaultComplexSerializer(Shape shape) {
            writer.write("data[$L] = Builders::$L.build(params[$L])$L", dataName, shape.getId().getName(), symbolName, checkRequired(shape));
        }

        @Override
        public Void listShape(ListShape shape) {
            defaultComplexSerializer(shape);
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


