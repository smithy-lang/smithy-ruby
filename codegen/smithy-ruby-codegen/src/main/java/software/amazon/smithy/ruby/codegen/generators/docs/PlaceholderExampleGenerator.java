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

package software.amazon.smithy.ruby.codegen.generators.docs;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.stream.Collectors;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.model.Model;
import software.amazon.smithy.model.shapes.BigDecimalShape;
import software.amazon.smithy.model.shapes.BigIntegerShape;
import software.amazon.smithy.model.shapes.BlobShape;
import software.amazon.smithy.model.shapes.BooleanShape;
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
import software.amazon.smithy.model.traits.EnumTrait;
import software.amazon.smithy.model.traits.RequiredTrait;
import software.amazon.smithy.ruby.codegen.RubyCodeWriter;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class PlaceholderExampleGenerator {

    private final OperationShape operation;
    private final RubyCodeWriter writer;
    private final Set<ShapeId> visited;
    private final SymbolProvider symbolProvider;
    private final Model model;

    public PlaceholderExampleGenerator(OperationShape operation,
                                       SymbolProvider symbolProvider, Model model) {
        this.operation = operation;
        this.symbolProvider = symbolProvider;
        this.model = model;
        this.writer = new RubyCodeWriter();
        this.visited = new HashSet<>();
    }

    public String generate() {
        Symbol symbol = symbolProvider.toSymbol(operation);
        ShapeId inputShapeId = operation.getInputShape();
        Shape inputShape = model.expectShape(inputShapeId);
        String operationName =
                RubyFormatter.toSnakeCase(symbol.getName());

        if (inputShape.members().size() == 0) {
            writer.write("resp = client.$L()", operationName);
        } else {
            writer
                    .openBlock("resp = client.$L(", operationName)
                    .call(() -> {
                        Iterator<MemberShape> itr = inputShape.members().iterator();
                        while (itr.hasNext()) {
                            MemberShape member = itr.next();
                            Shape target = model.expectShape(member.getTarget());
                            String dataSetter = symbolProvider.toMemberName(member) + ": ";
                            String eol = itr.hasNext() ? "," : "";
                            target.accept(new PlaceholderMember(dataSetter, member, eol, visited));
                        }
                    })
                    .closeBlock(")");
        }
        return writer.toString();
    }

    private final class PlaceholderMember extends ShapeVisitor.Default<Void> {
        private final String eol;
        private final String dataSetter;
        private final MemberShape memberShape;
        private final Set<ShapeId> visited;

        private PlaceholderMember(String dataSetter, MemberShape memberShape, String eol, Set<ShapeId> visited) {
            this.dataSetter = dataSetter;
            this.memberShape = memberShape;
            this.visited = visited;

            if (memberShape.hasTrait(RequiredTrait.class)) {
                this.eol = eol + " # required";
            } else {
                this.eol = eol;
            }
        }

        @Override
        protected Void getDefault(Shape shape) {
            return null;
        }

        @Override
        public Void blobShape(BlobShape blob) {
            writer.write("$L'$L'$L", dataSetter, memberShape.getMemberName(), eol);
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
            if (shape.hasTrait(EnumTrait.class)) {
                EnumTrait enumTrait = shape.expectTrait(EnumTrait.class);
                String defaultValue = enumTrait.getValues().get(0).getValue();
                String accepts =
                        enumTrait.getValues().stream().map((v) -> v.getValue()).collect(Collectors.joining(", "));
                if (memberShape.hasTrait(RequiredTrait.class)) {
                    accepts = " - accepts " + accepts;
                } else {
                    accepts = " # accepts " + accepts;
                }
                writer.write("$L'$L'$L", dataSetter, defaultValue, eol + accepts);
            } else {
                writer.write("$L'$L'$L", dataSetter, memberShape.getMemberName(), eol);
            }
            return null;
        }

        @Override
        public Void timestampShape(TimestampShape shape) {
            writer.write("$LTime.now$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void booleanShape(BooleanShape shape) {
            writer.write("$Lfalse$L", dataSetter, eol);
            return null;
        }

        @Override
        public Void structureShape(StructureShape shape) {
            if (!visited.add(shape.getId())) {
                return null;
            }

            if (shape.members().size() == 0) {
                writer.write("$L{ }$L", dataSetter, eol);
            } else {
                writer.openBlock("$L{", dataSetter);
                Iterator<MemberShape> itr = shape.members().iterator();
                while (itr.hasNext()) {
                    MemberShape member = itr.next();
                    Shape target = model.expectShape(member.getTarget());
                    String dataSetter = symbolProvider.toMemberName(member) + ": ";
                    String eol = itr.hasNext() ? "," : "";
                    target.accept(new PlaceholderMember(dataSetter, member, eol, visited));
                }
                writer.closeBlock("}$L", eol);
            }
            return null;
        }

        @Override
        public Void listShape(ListShape shape) {
            if (!visited.add(shape.getId())) {
                return null;
            }

            Shape target = model.expectShape(shape.getMember().getTarget());
            if (!visited.contains(target.getId())) {
                writer.openBlock("$L[", dataSetter);
                target.accept(new PlaceholderMember("", shape.getMember(), "", visited));
                writer.closeBlock("]$L", eol);
            }
            return null;
        }

        @Override
        public Void setShape(SetShape shape) {
            if (!visited.add(shape.getId())) {
                return null;
            }

            Shape target = model.expectShape(shape.getMember().getTarget());
            if (!visited.contains(target.getId())) {
                writer.openBlock("$L[", dataSetter);
                target.accept(new PlaceholderMember("", shape.getMember(), "", visited));
                writer.closeBlock("]$L", eol);
            }
            return null;
        }

        @Override
        public Void mapShape(MapShape shape) {
            if (!visited.add(shape.getId())) {
                return null;
            }

            Shape target = model.expectShape(shape.getValue().getTarget());
            if (!visited.contains(target.getId())) {
                String setter = "'" + shape.getKey().getMemberName() + "' => ";
                writer.openBlock("$L{", dataSetter);
                target.accept(new PlaceholderMember(setter, shape.getValue(), "", visited));
                writer.closeBlock("}$L", eol);
            }
            return null;
        }

        @Override
        public Void unionShape(UnionShape shape) {
            if (!visited.add(shape.getId())) {
                return null;
            }

            writer.openBlock("$L{", dataSetter);
            writer.write("# One of: ");
            Iterator<MemberShape> itr = shape.members().iterator();
            while (itr.hasNext()) {
                MemberShape member = itr.next();
                Shape target = model.expectShape(member.getTarget());
                String dataSetter = RubyFormatter.toSnakeCase(symbolProvider.toMemberName(member)) + ": ";
                String eol = itr.hasNext() ? "," : "";
                target.accept(new PlaceholderMember(dataSetter, member, eol, visited));
            }
            writer.closeBlock("}$L", eol);
            return null;
        }

        @Override
        public Void documentShape(DocumentShape shape) {
            if (!visited.add(shape.getId())) {
                return null;
            }
            writer
                    .openBlock("$L{", dataSetter)
                    .write("'nil' => nil,")
                    .write("'number' => 123.0,")
                    .write("'string' => 'value',")
                    .write("'boolean' => true,")
                    .write("'array' => [],")
                    .write("'map' => {}")
                    .closeBlock("}$L", eol);
            return null;
        }
    }
}
