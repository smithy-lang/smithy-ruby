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

package software.amazon.smithy.ruby.codegen.test.protocol.fakeprotocol.generators;

import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.TreeSet;
import software.amazon.smithy.build.FileManifest;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.knowledge.TopDownIndex;
import software.amazon.smithy.model.neighbor.Walker;
import software.amazon.smithy.model.shapes.BigDecimalShape;
import software.amazon.smithy.model.shapes.BigIntegerShape;
import software.amazon.smithy.model.shapes.BlobShape;
import software.amazon.smithy.model.shapes.ByteShape;
import software.amazon.smithy.model.shapes.DocumentShape;
import software.amazon.smithy.model.shapes.DoubleShape;
import software.amazon.smithy.model.shapes.FloatShape;
import software.amazon.smithy.model.shapes.IntegerShape;
import software.amazon.smithy.model.shapes.ListShape;
import software.amazon.smithy.model.shapes.LongShape;
import software.amazon.smithy.model.shapes.MapShape;
import software.amazon.smithy.model.shapes.MemberShape;
import software.amazon.smithy.model.shapes.OperationShape;
import software.amazon.smithy.model.shapes.SetShape;
import software.amazon.smithy.model.shapes.Shape;
import software.amazon.smithy.model.shapes.ShapeId;
import software.amazon.smithy.model.shapes.ShapeVisitor;
import software.amazon.smithy.model.shapes.ShortShape;
import software.amazon.smithy.model.shapes.StringShape;
import software.amazon.smithy.model.shapes.StructureShape;
import software.amazon.smithy.model.shapes.TimestampShape;
import software.amazon.smithy.model.shapes.UnionShape;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.ruby.codegen.RubySettings;

public class StubsGenerator extends ShapeVisitor.Default<Void> {

    private final GenerationContext context;
    private final RubySettings settings;
    private final Model model;
    private final Set<ShapeId> generatedStubs;
    private final RubyCodeWriter writer;

    public StubsGenerator(GenerationContext context) {
        this.settings = context.getRubySettings();
        this.model = context.getModel();
        this.generatedStubs = new HashSet<>();
        this.context = context;
        this.writer = new RubyCodeWriter();
    }

    public void render(FileManifest fileManifest) {

        writer
                .openBlock("module $L", settings.getModule())
                .openBlock("module Stubs")
                .call(() -> renderStubs())
                .closeBlock("end")
                .closeBlock("end");

        String fileName = settings.getGemName() + "/lib/" + settings.getGemName() + "/stubs.rb";
        fileManifest.writeFile(fileName, writer.toString());
    }

    private void renderStubs() {
        TopDownIndex topDownIndex = TopDownIndex.of(model);
        Set<OperationShape> containedOperations = new TreeSet<>(
                topDownIndex.getContainedOperations(context.getService()));
        containedOperations.stream()
                .sorted(Comparator.comparing((o) -> o.getId().getName()))
                .forEach(o -> renderStubsForOperation(o));
    }

    private void renderStubsForOperation(OperationShape operation) {
        // Operations MUST have an Output type, even if it is empty
        if (!operation.getOutput().isPresent()) {
            throw new RuntimeException("Missing Output Shape for: " + operation.getId());
        }
        ShapeId outputShapeId = operation.getOutput().get();

        Shape outputShape = model.expectShape(outputShapeId);

        writer
                .write("\n# Operation Stubber for $L", operation.getId().getName())
                .openBlock("class $L", operation.getId().getName())
                .openBlock("\ndef self.default(visited=[])")
                .call(() -> renderMemberDefaults(outputShape))
                .closeBlock("end")
                .openBlock("\ndef self.stub(http_resp, stub:)")
                .closeBlock("end")
                .closeBlock("end");

        generatedStubs.add(operation.toShapeId());

        Iterator<Shape> it = new Walker(model).iterateShapes(outputShape);
        while (it.hasNext()) {
            Shape s = it.next();
            if (!generatedStubs.contains(s.getId())) {
                generatedStubs.add(s.getId());
                s.accept(this);
            } else {
                System.out.println("\tSkipping " + s.getId() + " because it has already been generated.");
            }
        }
    }

    @Override
    public Void structureShape(StructureShape shape) {
        System.out.println("\tRENDER stubber for STRUCTURE: " + shape.getId());
        writer
                .write("\n# Structure Stubber for $L", shape.getId().getName())
                .openBlock("class $L", shape.getId().getName())
                .openBlock("\ndef self.default(visited=[])")
                .write("return nil if visited.include?('$L')", shape.getId().getName())
                .write("visited = visited + ['$L']", shape.getId().getName())
                .call(() -> renderMemberDefaults(shape))
                .closeBlock("end")
                .openBlock("\ndef self.stub(stub = {})")
                .write("{}")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void listShape(ListShape shape) {
        System.out.println("\tRENDER stubber for LIST: " + shape.getId());
        Shape memberTarget =
                model.expectShape(shape.getMember().getTarget());
        writer
                .write("\n# List Stubber for $L", shape.getId().getName())
                .openBlock("\nclass $L", shape.getId().getName())
                .openBlock("\ndef self.default(visited=[])")
                .write("return nil if visited.include?('$L')", shape.getId().getName())
                .write("visited = visited + ['$L']", shape.getId().getName())
                .openBlock("[")
                .call(() -> memberTarget.accept(new MemberDefaults(writer, "", "", memberTarget.getId().getName())))
                .closeBlock("]")
                .closeBlock("end")
                .openBlock("def self.stub(stub = [])")
                .write("[]")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void mapShape(MapShape shape) {
        System.out.println("\tRENDER stubber for MAP: " + shape.getId());
        Shape valueTarget = model.expectShape(shape.getValue().getTarget());

        writer
                .write("\n# Map Stubber for $L", shape.getId().getName())
                .openBlock("\nclass $L", shape.getId().getName())
                .openBlock("\ndef self.default(visited=[])")
                .write("return nil if visited.include?('$L')", shape.getId().getName())
                .write("visited = visited + ['$L']", shape.getId().getName())
                .openBlock("{")
                .call(() -> valueTarget
                        .accept(new MemberDefaults(writer, "test_key: ", "", valueTarget.getId().getName())))
                .closeBlock("}")
                .closeBlock("end")
                .openBlock("\ndef self.stub(stub = {})")
                .write("{}")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void setShape(SetShape shape) {
        System.out.println("\tRENDER stubber for Set: " + shape.getId());
        Shape memberTarget =
                model.expectShape(shape.getMember().getTarget());
        writer
                .write("\n# Set Stubber for $L", shape.getId().getName())
                .openBlock("\nclass $L", shape.getId().getName())
                .openBlock("\ndef self.default(visited=[])")
                .write("return nil if visited.include?('$L')", shape.getId().getName())
                .write("visited = visited + ['$L']", shape.getId().getName())
                .openBlock("[")
                .call(() -> memberTarget.accept(new MemberDefaults(writer, "", "", memberTarget.getId().getName())))
                .closeBlock("]")
                .closeBlock("end")
                .openBlock("def \nself.stub(stub = [])")
                .write("Set.new")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void unionShape(UnionShape shape) {
        System.out.println("\tRENDER stubber for UNION: " + shape.getId());
        writer
                .write("\n# Union Stubber for $L", shape.getId().getName())
                .openBlock("class $L", shape.getId().getName())
                .openBlock("\ndef self.default(visited=[])")
                .write("return nil if visited.include?('$L')", shape.getId().getName())
                .write("visited = visited + ['$L']", shape.getId().getName())
                .call(() -> {
                    writer.openBlock("{");
                    MemberShape defaultMember = shape.members().iterator().next();
                    Shape target = model.expectShape(defaultMember.getTarget());
                    System.out.println(
                            "\t\tMEMBER default FOR: " + defaultMember.getId() + " target type: " + target.getType());

                    String symbolName = RubyFormatter.toSnakeCase(defaultMember.getMemberName());
                    String dataSetter = symbolName + ": ";
                    target.accept(new MemberDefaults(writer, dataSetter, ",", symbolName));
                    writer.closeBlock("}");
                })
                .closeBlock("end")
                .openBlock("\ndef self.stub(stub = {})")
                .write("{}")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    @Override
    public Void documentShape(DocumentShape shape) {
        System.out.println("\tRENDER stubber for Document: " + shape.getId());
        String name = shape.getId().getName();
        writer
                .write("\n# Document Type Stubber for $L", name)
                .openBlock("class $L", name)
                .openBlock("\ndef self.default(visited=[])")
                .write("return nil if visited.include?('$L')", name)
                .write("visited = visited + ['$L']", name)
                .write("{ '$L' => [0, 1, 2] }", name)
                .closeBlock("end")
                .openBlock("\ndef self.stub(stub = {})")
                .write("{}")
                .closeBlock("end")
                .closeBlock("end");

        return null;
    }

    private void renderMemberDefaults(Shape s) {
        writer.openBlock("{");
        s.members().forEach((member) -> {
            Shape target = model.expectShape(member.getTarget());
            System.out.println("\t\tMEMBER default FOR: " + member.getId() + " target type: " + target.getType());

            String symbolName = RubyFormatter.toSnakeCase(member.getMemberName());
            String dataSetter = symbolName + ": ";
            target.accept(new MemberDefaults(writer, dataSetter, ",", symbolName));
        });
        writer.closeBlock("}");
    }

    @Override
    protected Void getDefault(Shape shape) {
        return null;
    }

    private static class MemberDefaults extends ShapeVisitor.Default<Void> {

        private final RubyCodeWriter writer;
        private final String eol;
        private final String dataSetter;
        private final String memberName;

        MemberDefaults(RubyCodeWriter writer, String dataSetter, String eol, String memberName) {
            this.writer = writer;
            this.eol = eol;
            this.dataSetter = dataSetter;
            this.memberName = memberName;
        }

        @Override
        protected Void getDefault(Shape shape) {
            writer.write("$Lnil$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void blobShape(BlobShape blob) {
            writer.write("$LStringIO.new('blob')$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void byteShape(ByteShape shape) {
            writer.write("$L1$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void shortShape(ShortShape shape) {
            writer.write("$L1$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void integerShape(IntegerShape shape) {
            writer.write("$L1$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void longShape(LongShape shape) {
            writer.write("$L1$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void floatShape(FloatShape shape) {
            writer.write("$L1.0$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void doubleShape(DoubleShape shape) {
            writer.write("$L1.0$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void bigIntegerShape(BigIntegerShape shape) {
            writer.write("$L1$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void bigDecimalShape(BigDecimalShape shape) {
            writer.write("$L1.0$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void stringShape(StringShape shape) {
            writer.write("$L'$L'$L", dataSetter, memberName, eol);
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            writer.write("$LTime.now$L", dataSetter, eol);
            return null;
        }

        /**
         * For complex shapes, simply delegate to their Stubber.
         */
        private void complexShapeDefaults(Shape shape) {
            writer.write("$LStubs::$L.default(visited)$L", dataSetter, shape.getId().getName(), eol);
        }

        @Override
        public Void listShape(ListShape shape) {
            complexShapeDefaults(shape);
            return null;
        }

        @Override
        public Void setShape(SetShape shape) {
            complexShapeDefaults(shape);
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            complexShapeDefaults(shape);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            complexShapeDefaults(shape);
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            complexShapeDefaults(shape);
            return null;
        }
    }
}

